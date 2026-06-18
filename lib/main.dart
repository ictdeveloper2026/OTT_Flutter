// Clean, self-contained entry point for the OTT app.
// Talks directly to the .NET backend (Auth + Content). Kept independent of the
// older half-built screens/blocs (still in lib/, not imported here) so the app
// compiles and runs today. Grow it by wiring those screens in one at a time.
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _apiBase = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

late final Api api;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  api = Api(prefs);
  runApp(const OttApp());
}

// ── API client ───────────────────────────────────────────────────────────────
class Api {
  final Dio _dio;
  final SharedPreferences _prefs;

  Api(this._prefs)
      : _dio = Dio(BaseOptions(
          baseUrl: '$_apiBase/api',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
        )) {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (o, h) {
      final t = token;
      if (t != null) o.headers['Authorization'] = 'Bearer $t';
      h.next(o);
    }));
  }

  String? get token => _prefs.getString('token');
  bool get isLoggedIn => token != null;
  Future<void> _setToken(String? t) async =>
      t == null ? await _prefs.remove('token') : await _prefs.setString('token', t);

  Future<void> logout() => _setToken(null);

  Future<void> login(String email, String password) async {
    final res = await _dio.post('/auth/login', data: {'email': email, 'password': password});
    await _setToken(res.data['accessToken'] as String);
  }

  Future<Map<String, dynamic>> publicConfig() async {
    final res = await _dio.get('/config/public');
    return Map<String, dynamic>.from(res.data['data'] ?? res.data);
  }

  Future<List<dynamic>> featured() async {
    final res = await _dio.get('/contents/featured');
    final data = res.data is Map ? res.data['data'] : res.data;
    return (data is List) ? data : <dynamic>[];
  }
}

// ── App + theme ──────────────────────────────────────────────────────────────
class OttApp extends StatelessWidget {
  const OttApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTT Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
        colorScheme: const ColorScheme.dark(primary: Color(0xFFE50914), surface: Color(0xFF1A1A1A)),
        inputDecorationTheme: const InputDecorationTheme(filled: true, fillColor: Color(0xFF1A1A1A)),
      ),
      home: api.isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}

// ── Login ────────────────────────────────────────────────────────────────────
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: 'admin@ott.local');
  final _pass = TextEditingController(text: 'Admin@123');
  bool _busy = false;
  String? _error;

  Future<void> _login() async {
    setState(() { _busy = true; _error = null; });
    try {
      await api.login(_email.text.trim(), _pass.text);
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    } catch (e) {
      setState(() => _error = _friendly(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('OTT Platform', textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFE50914), fontSize: 34, fontWeight: FontWeight.w800)),
                const SizedBox(height: 32),
                TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 12),
                TextField(controller: _pass, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
                const SizedBox(height: 20),
                if (_error != null)
                  Padding(padding: const EdgeInsets.only(bottom: 12),
                      child: Text(_error!, style: const TextStyle(color: Colors.redAccent))),
                FilledButton(
                  onPressed: _busy ? null : _login,
                  style: FilledButton.styleFrom(backgroundColor: const Color(0xFFE50914), padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _busy
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Sign in'),
                ),
                const SizedBox(height: 12),
                Text('API: $_apiBase', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white30, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Home ─────────────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<(Map<String, dynamic>, List<dynamic>)> _load;

  @override
  void initState() {
    super.initState();
    _load = _fetch();
  }

  Future<(Map<String, dynamic>, List<dynamic>)> _fetch() async {
    final cfg = await api.publicConfig();
    final items = await api.featured();
    return (cfg, items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<(Map<String, dynamic>, List<dynamic>)>(
        future: _load,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFE50914)));
          }
          if (snap.hasError) {
            return _ErrorView(message: _friendly(snap.error!), onRetry: () => setState(() => _load = _fetch()));
          }
          final (cfg, items) = snap.data!;
          final appName = (cfg['branding']?['appName'] ?? 'OTT Platform').toString();
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                title: Text(appName),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () async {
                      await api.logout();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
                      }
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: items.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Center(child: Text('No content yet.\nAdd titles from the admin API.',
                              textAlign: TextAlign.center, style: TextStyle(color: Colors.white54))),
                        ),
                      )
                    : SliverGrid(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 140, childAspectRatio: 2 / 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => _PosterCard(items[i] as Map<String, dynamic>),
                          childCount: items.length,
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const _PosterCard(this.item);
  @override
  Widget build(BuildContext context) {
    final url = (item['posterUrl'] ?? item['thumbnailUrl'] ?? item['bannerUrl']) as String?;
    final title = (item['title'] ?? '').toString();
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: const Color(0xFF1A1A1A),
        child: (url != null && url.isNotEmpty)
            ? Image.network(url, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _titleFallback(title))
            : _titleFallback(title),
      ),
    );
  }

  Widget _titleFallback(String title) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ),
      );
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, color: Colors.white38, size: 48),
              const SizedBox(height: 12),
              Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white60)),
              const SizedBox(height: 16),
              FilledButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ),
        ),
      );
}

String _friendly(Object e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {
      return 'Cannot reach the backend at $_apiBase.\nIs the API running?';
    }
    final code = e.response?.statusCode;
    if (code == 401) return 'Invalid email or password.';
    return 'Request failed${code != null ? ' ($code)' : ''}.';
  }
  return e.toString();
}
