// Clean, self-contained OTT app wired to the .NET backend.
// Login -> Home (banner + rows) -> Detail -> Video player, plus Search, Profile, and an Admin panel.
// Independent of the older half-built screens/blocs (still in lib/, not imported).
// adminDo()/async helpers guard `mounted` internally, so the across-async-gap lint
// is a false positive here.
// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

const _apiBase = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');
const _red = Color(0xFFE50914);

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

  // Decode the JWT payload to show profile info without an extra round-trip.
  Map<String, dynamic> get claims {
    final t = token;
    if (t == null) return {};
    try {
      final parts = t.split('.');
      if (parts.length < 2) return {};
      var p = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      p = p.padRight(p.length + (4 - p.length % 4) % 4, '=');
      return Map<String, dynamic>.from(jsonDecode(utf8.decode(base64.decode(p))));
    } catch (_) {
      return {};
    }
  }

  String? _claim(String needle) {
    for (final e in claims.entries) {
      if (e.key.toLowerCase().contains(needle)) return e.value?.toString();
    }
    return null;
  }

  String get email => _claim('emailaddress') ?? _claim('email') ?? '';
  String get role => _claim('/role') ?? _claim('role') ?? 'viewer';
  String get fullName => (claims['full_name'] ?? '').toString().trim();
  bool get isAdmin => role.toLowerCase() == 'admin';

  List<dynamic> _list(dynamic body) {
    final data = (body is Map) ? body['data'] : body;
    if (data is List) return data;
    if (data is Map && data['items'] is List) return data['items'] as List;
    return const [];
  }

  Future<List<dynamic>> featured() async => _list((await _dio.get('/contents/featured')).data);
  Future<List<dynamic>> trending() async => _list((await _dio.get('/contents/trending')).data);
  Future<List<dynamic>> newReleases() async => _list((await _dio.get('/contents/new-releases')).data);
  Future<List<dynamic>> search(String q) async =>
      _list((await _dio.get('/contents/search', queryParameters: {'q': q})).data);

  Future<Map<String, dynamic>> detail(String id) async {
    final res = await _dio.get('/contents/$id');
    final d = (res.data is Map) ? res.data['data'] : res.data;
    return Map<String, dynamic>.from(d ?? {});
  }

  // Admin
  Future<Map<String, dynamic>> adminStats() async {
    final res = await _dio.get('/admin/stats');
    return Map<String, dynamic>.from(res.data['data'] ?? res.data);
  }

  Future<List<dynamic>> adminContents() async => _list((await _dio.get('/admin/contents')).data);

  Future<void> createAndPublish(String title, String description, String posterUrl, bool featured) async {
    final res = await _dio.post('/admin/contents', data: {
      'title': title,
      'description': description,
      'type': 'movie',
      'posterUrl': posterUrl,
      'thumbnailUrl': posterUrl,
      'bannerUrl': posterUrl,
      'monetizationModel': 'svod',
      'isFeatured': featured,
      'isTrending': featured,
      'trailerUrl': 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    });
    final id = (res.data['data']?['id'] ?? res.data['id'])?.toString();
    if (id != null) await _dio.post('/admin/contents/$id/publish');
  }

  // Admin: revenue, banners, content-rows, users, live, genres, promos, branding
  Future<List<dynamic>> adminRevenue(String period) async =>
      _list((await _dio.get('/admin/revenue', queryParameters: {'period': period})).data);

  Future<List<dynamic>> adminBanners() async => _list((await _dio.get('/admin/banners')).data);
  Future<void> saveBanner(Map<String, dynamic> data, {String? id}) async =>
      id == null ? await _dio.post('/admin/banners', data: data) : await _dio.put('/admin/banners/$id', data: data);
  Future<void> deleteBanner(String id) => _dio.delete('/admin/banners/$id');

  Future<List<dynamic>> adminContentRows() async => _list((await _dio.get('/admin/content-rows')).data);
  Future<void> saveContentRow(Map<String, dynamic> data, {String? id}) async =>
      id == null ? await _dio.post('/admin/content-rows', data: data) : await _dio.put('/admin/content-rows/$id', data: data);

  Future<Map<String, dynamic>> adminUsers() async {
    final r = await _dio.get('/admin/users');
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }
  Future<void> setUserStatus(String id, String status) => _dio.put('/admin/users/$id/status', data: {'status': status});

  Future<List<dynamic>> adminLive() async => _list((await _dio.get('/admin/live')).data);
  Future<void> createLive(Map<String, dynamic> data) => _dio.post('/admin/live', data: data);
  Future<void> startLive(String id) => _dio.post('/admin/live/$id/start');
  Future<void> endLive(String id) => _dio.post('/admin/live/$id/end');

  Future<List<dynamic>> adminGenres() async => _list((await _dio.get('/admin/genres')).data);
  Future<void> createGenre(String name, String slug) => _dio.post('/admin/genres', data: {'name': name, 'slug': slug, 'sortOrder': 0});

  Future<List<dynamic>> adminPromos() async => _list((await _dio.get('/admin/promos')).data);
  Future<void> createPromo(Map<String, dynamic> data) => _dio.post('/admin/promos', data: data);

  Future<Map<String, dynamic>?> adminBranding() async {
    final r = await _dio.get('/admin/branding');
    final d = (r.data is Map) ? r.data['data'] : r.data;
    return d == null ? null : Map<String, dynamic>.from(d);
  }
  Future<void> updateBranding(Map<String, dynamic> data) => _dio.put('/admin/branding', data: data);

  // Subscription / plans
  Future<List<dynamic>> plans() async => _list((await _dio.get('/plans')).data);
  Future<Map<String, dynamic>?> mySubscription() async {
    try {
      final r = await _dio.get('/subscriptions/me');
      final d = (r.data is Map) ? r.data['data'] : r.data;
      return d == null ? null : Map<String, dynamic>.from(d);
    } catch (_) {
      return null;
    }
  }

  // Profiles
  bool get hasProfile => claims['profile_id'] != null;
  Future<List<dynamic>> profiles() async => _list((await _dio.get('/Profiles')).data);
  Future<Map<String, dynamic>> createProfile(String name) async {
    final res = await _dio.post('/Profiles', data: {'name': name, 'maturityLevel': 'all'});
    final d = (res.data is Map) ? res.data['data'] : res.data;
    return Map<String, dynamic>.from(d ?? {});
  }
  Future<void> selectProfile(String profileId) async {
    final res = await _dio.post('/auth/select-profile', data: {'profileId': profileId});
    await _setToken(res.data['accessToken'] as String); // new token carries profile_id
  }

  // Server-side watchlist (needs an active profile)
  Future<List<dynamic>> watchlist() async => _list((await _dio.get('/watchlist')).data);
  Future<void> addToWatchlist(String contentId) => _dio.post('/watchlist', data: {'contentId': contentId});
  Future<void> removeFromWatchlist(String contentId) => _dio.delete('/watchlist/$contentId');

  // Continue watching + progress
  Future<List<dynamic>> continueWatching() async => _list((await _dio.get('/watch-history/continue')).data);
  Future<void> saveProgress(String contentId, int watchedSeconds, int totalSeconds) async {
    try {
      await _dio.post('/watch-history/$contentId/progress',
          data: {'watchedSeconds': watchedSeconds, 'totalSeconds': totalSeconds});
    } catch (_) {/* progress save is best-effort */}
  }

  // Genres
  Future<List<dynamic>> genres() async => _list((await _dio.get('/config/genres')).data);
  Future<List<dynamic>> byGenre(String genreId) async => _list((await _dio.get('/contents/genre/$genreId')).data);

  // Notifications
  Future<Map<String, dynamic>> notifications() async {
    final r = await _dio.get('/Notifications');
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }

  // Auth (sign-up) + Live
  Future<void> register(String email, String password, String firstName, String lastName) async {
    final res = await _dio.post('/auth/register', data: {
      'email': email, 'password': password, 'firstName': firstName, 'lastName': lastName,
    });
    await _setToken(res.data['accessToken'] as String);
  }

  Future<List<dynamic>> liveStreams() async => _list((await _dio.get('/Live')).data);
  Future<Map<String, dynamic>> liveDetail(String id) async {
    final r = await _dio.get('/Live/$id');
    return Map<String, dynamic>.from(r.data['data'] ?? r.data);
  }
}

String posterOf(Map item) => (item['posterUrl'] ?? item['thumbnailUrl'] ?? item['bannerUrl'] ?? '') as String;

// ── App ──────────────────────────────────────────────────────────────────────
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
        colorScheme: const ColorScheme.dark(primary: _red, surface: Color(0xFF1A1A1A)),
        inputDecorationTheme: const InputDecorationTheme(filled: true, fillColor: Color(0xFF1A1A1A)),
      ),
      home: !api.isLoggedIn
          ? const LoginScreen()
          : (api.hasProfile ? const HomeShell() : const ProfileGate()),
    );
  }
}

// ── Profile gate ("Who's watching?") ─────────────────────────────────────────
class ProfileGate extends StatefulWidget {
  const ProfileGate({super.key});
  @override
  State<ProfileGate> createState() => _ProfileGateState();
}

class _ProfileGateState extends State<ProfileGate> {
  late Future<List<dynamic>> _load = _fetch();

  Future<List<dynamic>> _fetch() async {
    var list = await api.profiles();
    if (list.isEmpty) {
      final p = await api.createProfile('Me');
      list = [p];
    }
    return list;
  }

  Future<void> _choose(String id) async {
    try {
      await api.selectProfile(id);
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeShell()));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendly(e))));
    }
  }

  Future<void> _addProfile() async {
    final c = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add profile'),
        content: TextField(controller: c, decoration: const InputDecoration(labelText: 'Name')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, c.text.trim()), child: const Text('Add')),
        ],
      ),
    );
    if (name != null && name.isNotEmpty) {
      await api.createProfile(name);
      if (mounted) setState(() => _load = _fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: _load,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator(color: _red));
            }
            if (snap.hasError) {
              return ErrorView(message: friendly(snap.error!), onRetry: () => setState(() => _load = _fetch()));
            }
            final profs = snap.data ?? [];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Who's watching?", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                const SizedBox(height: 32),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24, runSpacing: 24,
                  children: [
                    ...profs.map((p) {
                      final m = p as Map<String, dynamic>;
                      final name = (m['name'] ?? 'Profile').toString();
                      return GestureDetector(
                        onTap: () => _choose(m['id'].toString()),
                        child: Column(children: [
                          CircleAvatar(radius: 44, backgroundColor: const Color(0xFF333333),
                              child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?',
                                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
                          const SizedBox(height: 8),
                          Text(name),
                        ]),
                      );
                    }),
                    GestureDetector(
                      onTap: _addProfile,
                      child: Column(children: const [
                        CircleAvatar(radius: 44, backgroundColor: Color(0xFF1A1A1A), child: Icon(Icons.add, size: 36)),
                        SizedBox(height: 8),
                        Text('Add profile'),
                      ]),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () async {
                    await api.logout();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
                    }
                  },
                  child: const Text('Log out'),
                ),
              ],
            );
          },
        ),
      ),
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
      if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ProfileGate()));
    } catch (e) {
      setState(() => _error = friendly(e));
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
                    style: TextStyle(color: _red, fontSize: 34, fontWeight: FontWeight.w800)),
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
                  style: FilledButton.styleFrom(backgroundColor: _red, padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _busy
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Sign in'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
                  child: const Text('New here? Create an account'),
                ),
                Text('API: $_apiBase', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white30, fontSize: 11)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Register / Sign-up ───────────────────────────────────────────────────────
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _busy = false;
  String? _error;

  Future<void> _register() async {
    if (_email.text.trim().isEmpty || _pass.text.length < 6) {
      setState(() => _error = 'Enter an email and a password of at least 6 characters.');
      return;
    }
    setState(() { _busy = true; _error = null; });
    try {
      await api.register(_email.text.trim(), _pass.text, _first.text.trim(), _last.text.trim());
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ProfileGate()), (_) => false);
      }
    } catch (e) {
      setState(() => _error = friendly(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(children: [
                  Expanded(child: TextField(controller: _first, decoration: const InputDecoration(labelText: 'First name'))),
                  const SizedBox(width: 10),
                  Expanded(child: TextField(controller: _last, decoration: const InputDecoration(labelText: 'Last name'))),
                ]),
                const SizedBox(height: 12),
                TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
                const SizedBox(height: 12),
                TextField(controller: _pass, obscureText: true, decoration: const InputDecoration(labelText: 'Password (min 6)')),
                const SizedBox(height: 20),
                if (_error != null)
                  Padding(padding: const EdgeInsets.only(bottom: 12),
                      child: Text(_error!, style: const TextStyle(color: Colors.redAccent))),
                FilledButton(
                  onPressed: _busy ? null : _register,
                  style: FilledButton.styleFrom(backgroundColor: _red, padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: _busy
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Text('Create account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shell with bottom navigation ─────────────────────────────────────────────
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  late final List<Widget> _tabs = const [HomeTab(), SearchTab(), LiveTab(), MyListTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _tabs[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: const Color(0xFF0D0D0D),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.live_tv_outlined), selectedIcon: Icon(Icons.live_tv), label: 'Live'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'My List'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ── Home tab: banner + rows ──────────────────────────────────────────────────
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<List<dynamic>>> _load;
  @override
  void initState() { super.initState(); _load = _fetch(); }
  Future<List<List<dynamic>>> _fetch() async =>
      Future.wait([api.featured(), api.trending(), api.newReleases(), api.continueWatching()]);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => _load = _fetch()),
      child: FutureBuilder<List<List<dynamic>>>(
        future: _load,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: _red));
          }
          if (snap.hasError) {
            return ListView(children: [const _HomeHeader(), const SizedBox(height: 80),
              ErrorView(message: friendly(snap.error!), onRetry: () => setState(() => _load = _fetch()))]);
          }
          final featured = snap.data![0], trending = snap.data![1], fresh = snap.data![2], cont = snap.data![3];
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const _HomeHeader(),
              if (featured.isNotEmpty) _HeroCarousel(featured),
              _Row('Continue Watching', cont),
              _Row('Featured', featured),
              _Row('Trending', trending),
              _Row('New Releases', fresh),
              if (featured.isEmpty && trending.isEmpty && fresh.isEmpty)
                const Padding(padding: EdgeInsets.all(40),
                    child: Center(child: Text('No content yet.', style: TextStyle(color: Colors.white54)))),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
      child: Row(children: [
        const Text('OTT Platform', style: TextStyle(color: _red, fontSize: 22, fontWeight: FontWeight.w800)),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
        ),
      ]),
    );
  }
}

class _HeroCarousel extends StatefulWidget {
  final List<dynamic> items;
  const _HeroCarousel(this.items);
  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  final _pc = PageController();
  int _page = 0;
  @override
  void dispose() { _pc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final items = widget.items.take(6).toList();
    return Column(children: [
      SizedBox(
        height: 230,
        child: PageView.builder(
          controller: _pc,
          onPageChanged: (i) => setState(() => _page = i),
          itemCount: items.length,
          itemBuilder: (_, i) {
            final item = items[i] as Map<String, dynamic>;
            final img = posterOf(item);
            return GestureDetector(
              onTap: () => openDetail(context, item),
              child: Stack(fit: StackFit.expand, children: [
                if (img.isNotEmpty) Image.network(img, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFF1A1A1A)))
                else Container(color: const Color(0xFF1A1A1A)),
                Container(decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87]))),
                Positioned(left: 16, bottom: 16, right: 16,
                    child: Text((item['title'] ?? '').toString(),
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800))),
              ]),
            );
          },
        ),
      ),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(items.length, (i) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: _page == i ? 18 : 6, height: 6,
          decoration: BoxDecoration(color: _page == i ? _red : Colors.white30, borderRadius: BorderRadius.circular(3)),
        );
      })),
    ]);
  }
}

class _Row extends StatelessWidget {
  final String title;
  final List<dynamic> items;
  const _Row(this.title, this.items);
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
        SizedBox(
          height: 165,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => PosterTile(items[i] as Map<String, dynamic>, width: 110),
          ),
        ),
      ],
    );
  }
}

class PosterTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final double width;
  const PosterTile(this.item, {super.key, this.width = 120});
  @override
  Widget build(BuildContext context) {
    final img = posterOf(item);
    return GestureDetector(
      onTap: () => openDetail(context, item),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: width,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: Container(
              color: const Color(0xFF1A1A1A),
              child: img.isEmpty
                  ? Center(child: Padding(padding: const EdgeInsets.all(6),
                      child: Text((item['title'] ?? '').toString(),
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.white70))))
                  : Image.network(img, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white24)),
            ),
          ),
        ),
      ),
    );
  }
}

void openDetail(BuildContext context, Map<String, dynamic> item) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailScreen(id: item['id'].toString(), preview: item)));
}

// ── Detail ───────────────────────────────────────────────────────────────────
class DetailScreen extends StatefulWidget {
  final String id;
  final Map<String, dynamic> preview;
  const DetailScreen({super.key, required this.id, required this.preview});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Map<String, dynamic>> _load = api.detail(widget.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _load,
        builder: (context, snap) {
          final loaded = snap.connectionState == ConnectionState.done;
          final d = (snap.hasData && snap.data!.isNotEmpty) ? snap.data! : widget.preview;
          final img = posterOf(d);
          final video = (d['trailerUrl'] ?? d['streamUrls']?['hls']) as String?;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280, pinned: true,
                actions: [
                  IconButton(
                    tooltip: 'My List',
                    icon: Icon(d['isInWatchlist'] == true ? Icons.bookmark : Icons.bookmark_add_outlined),
                    onPressed: !loaded
                        ? null
                        : () async {
                            try {
                              if (d['isInWatchlist'] == true) {
                                await api.removeFromWatchlist(widget.id);
                              } else {
                                await api.addToWatchlist(widget.id);
                              }
                              setState(() => _load = api.detail(widget.id));
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendly(e))));
                              }
                            }
                          },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: img.isEmpty
                      ? Container(color: const Color(0xFF1A1A1A))
                      : Image.network(img, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: const Color(0xFF1A1A1A))),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((d['title'] ?? '').toString(),
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text([
                        if (d['releaseYear'] != null) d['releaseYear'].toString(),
                        if (d['type'] != null) d['type'].toString(),
                        if (d['ageRating'] != null) d['ageRating'].toString(),
                      ].join('  •  '), style: const TextStyle(color: Colors.white54)),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: !loaded
                            ? null
                            : () {
                                if (video != null && video.isNotEmpty) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PlayerScreen(url: video, title: (d['title'] ?? '').toString(), contentId: widget.id)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('No video source for this title yet.')));
                                }
                              },
                        style: FilledButton.styleFrom(backgroundColor: _red, minimumSize: const Size.fromHeight(48)),
                        icon: !loaded
                            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.play_arrow),
                        label: Text(!loaded ? 'Loading…' : 'Play'),
                      ),
                      const SizedBox(height: 16),
                      Text((d['description'] ?? 'No description.').toString(),
                          style: const TextStyle(color: Colors.white70, height: 1.4)),
                    ],
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

// ── Video player ─────────────────────────────────────────────────────────────
class PlayerScreen extends StatefulWidget {
  final String url, title;
  final String? contentId; // when set, watch progress is saved to the server
  const PlayerScreen({super.key, required this.url, required this.title, this.contentId});
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final VideoPlayerController _c;
  bool _ready = false;
  String? _error;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _c.initialize().then((_) {
      if (!mounted) return;
      setState(() => _ready = true);
      _c.play();
      if (widget.contentId != null) {
        _timer = Timer.periodic(const Duration(seconds: 15), (_) => _saveProgress());
      }
    }).catchError((Object e) {
      if (mounted) setState(() => _error = 'Could not play this video.');
    });
  }

  void _saveProgress() {
    if (widget.contentId == null || !_c.value.isInitialized) return;
    api.saveProgress(widget.contentId!, _c.value.position.inSeconds, _c.value.duration.inSeconds);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _saveProgress();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.black),
      body: Center(
        child: _error != null
            ? Text(_error!, style: const TextStyle(color: Colors.white60))
            : _ready
                ? AspectRatio(aspectRatio: _c.value.aspectRatio, child: VideoPlayer(_c))
                : const CircularProgressIndicator(color: _red),
      ),
      floatingActionButton: _ready
          ? FloatingActionButton(
              backgroundColor: _red,
              onPressed: () => setState(() => _c.value.isPlaying ? _c.pause() : _c.play()),
              child: Icon(_c.value.isPlaying ? Icons.pause : Icons.play_arrow),
            )
          : null,
    );
  }
}

// ── Search ───────────────────────────────────────────────────────────────────
class SearchTab extends StatefulWidget {
  const SearchTab({super.key});
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _c = TextEditingController();
  List<dynamic> _results = [];
  bool _busy = false;

  Future<void> _run(String q) async {
    if (q.trim().isEmpty) { setState(() => _results = []); return; }
    setState(() => _busy = true);
    try {
      final r = await api.search(q.trim());
      if (mounted) setState(() => _results = r);
    } catch (_) {
      if (mounted) setState(() => _results = []);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            controller: _c, textInputAction: TextInputAction.search, onSubmitted: _run,
            decoration: InputDecoration(
              hintText: 'Search titles…', prefixIcon: const Icon(Icons.search),
              suffixIcon: _busy ? const Padding(padding: EdgeInsets.all(12),
                  child: SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))) : null,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _results.isEmpty
                ? const _GenreBrowse()
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 120, childAspectRatio: 2 / 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                    itemCount: _results.length,
                    itemBuilder: (_, i) => PosterTile(_results[i] as Map<String, dynamic>),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Live TV ──────────────────────────────────────────────────────────────────
class LiveTab extends StatefulWidget {
  const LiveTab({super.key});
  @override
  State<LiveTab> createState() => _LiveTabState();
}

class _LiveTabState extends State<LiveTab> {
  late Future<List<dynamic>> _load = api.liveStreams();

  Future<void> _playLive(BuildContext context, Map<String, dynamic> m) async {
    try {
      final d = await api.liveDetail(m['id'].toString());
      final url = (d['playbackUrl'] ?? '') as String?;
      if (!context.mounted) return;
      if (url != null && url.isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PlayerScreen(url: url, title: (m['title'] ?? 'Live').toString())));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This channel has no stream URL yet.')));
      }
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendly(e))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => _load = api.liveStreams()),
      child: FutureBuilder<List<dynamic>>(
        future: _load,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: _red));
          }
          if (snap.hasError) {
            return ErrorView(message: friendly(snap.error!), onRetry: () => setState(() => _load = api.liveStreams()));
          }
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return ListView(children: const [
              SizedBox(height: 120),
              Icon(Icons.live_tv, size: 56, color: Colors.white24),
              SizedBox(height: 12),
              Center(child: Text('No live channels right now.', style: TextStyle(color: Colors.white38))),
            ]);
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final m = items[i] as Map<String, dynamic>;
              final live = (m['status'] ?? '').toString().toLowerCase() == 'live';
              return Card(
                color: const Color(0xFF181818),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: (m['thumbnailUrl'] ?? '').toString().isEmpty
                            ? const ColoredBox(color: Color(0xFF222222), child: Icon(Icons.live_tv, color: Colors.white24, size: 40))
                            : Image.network(m['thumbnailUrl'].toString(), fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF222222))),
                      ),
                      if (live)
                        Positioned(top: 8, left: 8, child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: _red, borderRadius: BorderRadius.circular(4)),
                          child: const Text('● LIVE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        )),
                    ]),
                    ListTile(
                      title: Text((m['title'] ?? '').toString()),
                      subtitle: Text(m['category']?.toString() ?? (live ? 'Live now' : (m['status'] ?? '').toString())),
                      trailing: const Icon(Icons.play_circle_outline, color: _red),
                      onTap: () => _playLive(context, m),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MyListTab extends StatefulWidget {
  const MyListTab({super.key});
  @override
  State<MyListTab> createState() => _MyListTabState();
}

class _MyListTabState extends State<MyListTab> {
  late Future<List<dynamic>> _load = api.watchlist();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => setState(() => _load = api.watchlist()),
      child: FutureBuilder<List<dynamic>>(
        future: _load,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: _red));
          }
          final items = (snap.data ?? []);
          if (items.isEmpty) {
            return ListView(children: const [
              SizedBox(height: 120),
              Padding(
                padding: EdgeInsets.all(24),
                child: Text('Your list is empty.\nOpen any title and tap the bookmark to save it here.',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white38)),
              ),
            ]);
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120, childAspectRatio: 2 / 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemCount: items.length,
            itemBuilder: (_, i) => PosterTile(items[i] as Map<String, dynamic>),
          );
        },
      ),
    );
  }
}

// ── Profile ──────────────────────────────────────────────────────────────────
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) {
    final name = api.fullName.isNotEmpty ? api.fullName : 'OTT User';
    final initial = (name.isNotEmpty ? name[0] : 'U').toUpperCase();
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        Center(child: CircleAvatar(radius: 40, backgroundColor: _red, child: Text(initial, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)))),
        const SizedBox(height: 16),
        Center(child: Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
        const SizedBox(height: 4),
        Center(child: Text(api.email, style: const TextStyle(color: Colors.white54))),
        const SizedBox(height: 8),
        Center(child: Chip(
          label: Text(api.role.toUpperCase(), style: const TextStyle(fontSize: 11)),
          backgroundColor: api.isAdmin ? _red : const Color(0xFF333333),
          visualDensity: VisualDensity.compact,
        )),
        const SizedBox(height: 24),
        _tile(Icons.person_outline, 'Account', api.email),
        _tile(Icons.verified_user_outlined, 'Role', api.role),
        _tile(Icons.cloud_outlined, 'Server', _apiBase),
        const Divider(height: 32),
        ListTile(
          leading: const Icon(Icons.workspace_premium_outlined, color: Colors.amber),
          title: const Text('Subscription & Plans'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PlansScreen())),
        ),
        if (api.isAdmin)
          ListTile(
            leading: const Icon(Icons.admin_panel_settings, color: _red),
            title: const Text('Admin panel'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminScreen())),
          ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log out'),
          onTap: () async {
            await api.logout();
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
            }
          },
        ),
      ],
    );
  }

  Widget _tile(IconData icon, String label, String value) => ListTile(
        dense: true,
        leading: Icon(icon, color: Colors.white54),
        title: Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
        subtitle: Text(value.isEmpty ? '—' : value, style: const TextStyle(color: Colors.white)),
      );
}

// ── Admin: shared helpers ─────────────────────────────────────────────────────
Future<Map<String, String>?> adminForm(BuildContext context, String title, List<String> fields) async {
  final ctrls = {for (final f in fields) f: TextEditingController()};
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: fields.map((f) =>
          Padding(padding: const EdgeInsets.only(bottom: 8),
            child: TextField(controller: ctrls[f], decoration: InputDecoration(labelText: f)))).toList()),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
      ],
    ),
  );
  if (ok != true) return null;
  return {for (final f in fields) f: ctrls[f]!.text.trim()};
}

// Runs an admin write, shows a success/error snackbar, and refreshes the list.
Future<void> adminDo(BuildContext ctx, Future<void> Function() action, VoidCallback refresh, [String? okMsg]) async {
  try {
    await action();
    refresh();
    if (ctx.mounted && okMsg != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(okMsg)));
    }
  } catch (e) {
    if (ctx.mounted) ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(friendly(e))));
  }
}

class AdminListScaffold extends StatefulWidget {
  final String title;
  final Future<List<dynamic>> Function() loader;
  final Widget Function(BuildContext, Map<String, dynamic>, VoidCallback) tile;
  final Future<void> Function(BuildContext, VoidCallback)? onAdd;
  final String addLabel;
  const AdminListScaffold({super.key, required this.title, required this.loader, required this.tile, this.onAdd, this.addLabel = 'Add'});
  @override
  State<AdminListScaffold> createState() => _AdminListScaffoldState();
}

class _AdminListScaffoldState extends State<AdminListScaffold> {
  late Future<List<dynamic>> _f = widget.loader();
  void _refresh() => setState(() => _f = widget.loader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: widget.onAdd == null ? null : FloatingActionButton.extended(
        backgroundColor: _red, icon: const Icon(Icons.add), label: Text(widget.addLabel),
        onPressed: () => widget.onAdd!(context, _refresh),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _f,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator(color: _red));
          if (snap.hasError) return ErrorView(message: friendly(snap.error!), onRetry: _refresh);
          final items = snap.data ?? [];
          if (items.isEmpty) return const Center(child: Text('Nothing here yet.', style: TextStyle(color: Colors.white38)));
          return RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: ListView(children: items.map((e) => widget.tile(context, Map<String, dynamic>.from(e as Map), _refresh)).toList()),
          );
        },
      ),
    );
  }
}

// ── Admin panel hub ───────────────────────────────────────────────────────────
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  static Widget _stat(String label, dynamic value) => Expanded(
        child: Card(
          color: const Color(0xFF1A1A1A),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(children: [
              Text('${value ?? 0}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 11, color: Colors.white54)),
            ]),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final sections = <(IconData, String, Widget Function())>[
      (Icons.movie_outlined, 'Content', () => const AdminContentScreen()),
      (Icons.view_carousel_outlined, 'Banners', () => const AdminBannersScreen()),
      (Icons.view_agenda_outlined, 'Content rows', () => const AdminContentRowsScreen()),
      (Icons.people_outline, 'Users', () => const AdminUsersScreen()),
      (Icons.live_tv_outlined, 'Live streams', () => const AdminLiveScreen()),
      (Icons.category_outlined, 'Genres', () => const AdminGenresScreen()),
      (Icons.local_offer_outlined, 'Promo codes', () => const AdminPromosScreen()),
      (Icons.palette_outlined, 'Branding', () => const AdminBrandingScreen()),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Admin panel')),
      body: ListView(children: [
        FutureBuilder<Map<String, dynamic>>(
          future: api.adminStats(),
          builder: (_, s) {
            final st = s.data ?? {};
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                _stat('Users', st['totalUsers']),
                _stat('Titles', st['totalContent']),
                _stat('Subs', st['activeSubscriptions']),
                _stat('Revenue', st['monthlyRevenue']),
              ]),
            );
          },
        ),
        const _RevenueChart(),
        const Divider(height: 24),
        ...sections.map((s) => ListTile(
              leading: Icon(s.$1, color: _red),
              title: Text(s.$2),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => s.$3())),
            )),
        const SizedBox(height: 24),
      ]),
    );
  }
}

class _RevenueChart extends StatelessWidget {
  const _RevenueChart();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: api.adminRevenue('30d'),
      builder: (_, snap) {
        final data = snap.data ?? [];
        if (data.isEmpty) return const SizedBox.shrink();
        final amounts = data.map((e) => ((e as Map)['amount'] as num?)?.toDouble() ?? 0).toList();
        final maxV = amounts.fold<double>(1, (p, e) => e > p ? e : p);
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Revenue (last 30 days)', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            SizedBox(
              height: 70,
              child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                children: amounts.map((a) => Expanded(child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  height: 70 * (a / maxV).clamp(0.03, 1.0),
                  decoration: BoxDecoration(color: _red.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(2)),
                ))).toList()),
            ),
          ]),
        );
      },
    );
  }
}

// ── Admin: Content ────────────────────────────────────────────────────────────
class AdminContentScreen extends StatelessWidget {
  const AdminContentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminListScaffold(
      title: 'Content', addLabel: 'Add title', loader: api.adminContents,
      tile: (ctx, m, refresh) => ListTile(
        leading: ClipRRect(borderRadius: BorderRadius.circular(4),
            child: SizedBox(width: 38, height: 56,
                child: posterOf(m).isEmpty ? const ColoredBox(color: Color(0xFF1A1A1A))
                    : Image.network(posterOf(m), fit: BoxFit.cover, errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF1A1A1A))))),
        title: Text((m['title'] ?? '').toString()),
        subtitle: Text('${m['type'] ?? ''} • ${m['isFeatured'] == true ? 'featured' : 'standard'}'),
      ),
      onAdd: (ctx, refresh) async {
        final title = TextEditingController();
        final desc = TextEditingController();
        final poster = TextEditingController(text: 'https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/300/450');
        bool featured = true;
        final ok = await showDialog<bool>(
          context: ctx,
          builder: (d) => StatefulBuilder(builder: (d, setS) => AlertDialog(
            title: const Text('Add title'),
            content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
              const SizedBox(height: 8),
              TextField(controller: desc, decoration: const InputDecoration(labelText: 'Description'), maxLines: 2),
              const SizedBox(height: 8),
              TextField(controller: poster, decoration: const InputDecoration(labelText: 'Poster URL')),
              CheckboxListTile(contentPadding: EdgeInsets.zero, value: featured,
                  onChanged: (v) => setS(() => featured = v ?? true), title: const Text('Featured')),
            ])),
            actions: [
              TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
              FilledButton(onPressed: () => Navigator.pop(d, true), child: const Text('Add')),
            ],
          )),
        );
        if (ok == true && title.text.trim().isNotEmpty) {
          try {
            await api.createAndPublish(title.text.trim(), desc.text.trim(), poster.text.trim(), featured);
            refresh();
          } catch (e) {
            if (ctx.mounted) ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(friendly(e))));
          }
        }
      },
    );
  }
}

// ── Admin: Banners ────────────────────────────────────────────────────────────
class AdminBannersScreen extends StatelessWidget {
  const AdminBannersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminListScaffold(
      title: 'Banners', addLabel: 'Add banner', loader: api.adminBanners,
      tile: (ctx, m, refresh) => ListTile(
        leading: const Icon(Icons.view_carousel),
        title: Text((m['title'] ?? '(untitled)').toString()),
        subtitle: Text((m['type'] ?? 'hero').toString()),
        trailing: IconButton(icon: const Icon(Icons.delete_outline),
            onPressed: () => adminDo(ctx, () => api.deleteBanner(m['id'].toString()), refresh, 'Banner deleted')),
      ),
      onAdd: (ctx, refresh) async {
        final v = await adminForm(ctx, 'Add banner', ['Title', 'Image URL', 'CTA text']);
        if (v != null && v['Title']!.isNotEmpty) {
          await adminDo(ctx, () => api.saveBanner({'title': v['Title'], 'type': 'hero', 'imageUrl': v['Image URL'],
            'ctaText': v['CTA text'], 'sortOrder': 0, 'isActive': true}), refresh, 'Banner added');
        }
      },
    );
  }
}

// ── Admin: Content rows ───────────────────────────────────────────────────────
class AdminContentRowsScreen extends StatelessWidget {
  const AdminContentRowsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminListScaffold(
      title: 'Content rows', addLabel: 'Add row', loader: api.adminContentRows,
      tile: (ctx, m, refresh) => ListTile(
        leading: const Icon(Icons.view_agenda),
        title: Text((m['title'] ?? '').toString()),
        subtitle: Text('${m['rowType'] ?? 'manual'} • ${m['displayStyle'] ?? ''}'),
      ),
      onAdd: (ctx, refresh) async {
        final v = await adminForm(ctx, 'Add row', ['Title', 'Type (manual/trending/new)', 'Display (landscape/portrait)']);
        if (v != null && v['Title']!.isNotEmpty) {
          await adminDo(ctx, () => api.saveContentRow({'title': v['Title'],
            'rowType': v['Type (manual/trending/new)']!.isEmpty ? 'manual' : v['Type (manual/trending/new)'],
            'displayStyle': v['Display (landscape/portrait)']!.isEmpty ? 'landscape' : v['Display (landscape/portrait)'],
            'sortOrder': 0, 'maxItems': 20, 'isActive': true}), refresh, 'Row added');
        }
      },
    );
  }
}

// ── Admin: Users ──────────────────────────────────────────────────────────────
class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminListScaffold(
      title: 'Users',
      loader: () async => (await api.adminUsers())['items'] as List? ?? [],
      tile: (ctx, m, refresh) {
        final blocked = m['isBlocked'] == true;
        return ListTile(
          leading: CircleAvatar(backgroundColor: const Color(0xFF333333),
              child: Text((m['email'] ?? '?').toString()[0].toUpperCase())),
          title: Text((m['email'] ?? '').toString()),
          subtitle: Text('${m['role'] ?? 'viewer'}${blocked ? ' • blocked' : ''}'),
          trailing: Switch(
            value: !blocked, activeThumbColor: Colors.green,
            onChanged: (v) => adminDo(ctx, () => api.setUserStatus(m['id'].toString(), v ? 'active' : 'blocked'),
                refresh, v ? 'User unblocked' : 'User blocked'),
          ),
        );
      },
    );
  }
}

// ── Admin: Live streams ───────────────────────────────────────────────────────
class AdminLiveScreen extends StatelessWidget {
  const AdminLiveScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminListScaffold(
      title: 'Live streams', addLabel: 'Add stream', loader: api.adminLive,
      tile: (ctx, m, refresh) {
        final live = (m['status'] ?? '').toString().toLowerCase() == 'live';
        return ListTile(
          leading: Icon(Icons.live_tv, color: live ? _red : Colors.white54),
          title: Text((m['title'] ?? '').toString()),
          subtitle: Text((m['status'] ?? 'offline').toString()),
          trailing: TextButton(
            onPressed: () => adminDo(ctx,
                () => live ? api.endLive(m['id'].toString()) : api.startLive(m['id'].toString()),
                refresh, live ? 'Stream ended' : 'Stream started'),
            child: Text(live ? 'End' : 'Start'),
          ),
        );
      },
      onAdd: (ctx, refresh) async {
        final v = await adminForm(ctx, 'Add live stream', ['Title', 'Category']);
        if (v != null && v['Title']!.isNotEmpty) {
          await adminDo(ctx, () => api.createLive({'title': v['Title'], 'category': v['Category'], 'description': '',
            'streamProvider': 'youtube', 'chatEnabled': true, 'isScheduled': false, 'monetizationModel': 'free'}),
            refresh, 'Stream added');
        }
      },
    );
  }
}

// ── Admin: Genres ─────────────────────────────────────────────────────────────
class AdminGenresScreen extends StatelessWidget {
  const AdminGenresScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminListScaffold(
      title: 'Genres', addLabel: 'Add genre', loader: api.adminGenres,
      tile: (ctx, m, refresh) => ListTile(
        leading: const Icon(Icons.category),
        title: Text((m['name'] ?? '').toString()),
        subtitle: Text((m['slug'] ?? '').toString()),
      ),
      onAdd: (ctx, refresh) async {
        final v = await adminForm(ctx, 'Add genre', ['Name', 'Slug']);
        if (v != null && v['Name']!.isNotEmpty) {
          final slug = v['Slug']!.isEmpty ? v['Name']!.toLowerCase().replaceAll(' ', '-') : v['Slug']!;
          await adminDo(ctx, () => api.createGenre(v['Name']!, slug), refresh, 'Genre added');
        }
      },
    );
  }
}

// ── Admin: Promo codes ────────────────────────────────────────────────────────
class AdminPromosScreen extends StatelessWidget {
  const AdminPromosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminListScaffold(
      title: 'Promo codes', addLabel: 'Add promo', loader: api.adminPromos,
      tile: (ctx, m, refresh) => ListTile(
        leading: const Icon(Icons.local_offer),
        title: Text((m['code'] ?? '').toString()),
        subtitle: Text('${m['discountType'] ?? ''} • ${m['discountValue'] ?? ''}'),
      ),
      onAdd: (ctx, refresh) async {
        final v = await adminForm(ctx, 'Add promo', ['Code', 'Type (percentage/fixed)', 'Value']);
        if (v != null && v['Code']!.isNotEmpty) {
          await adminDo(ctx, () => api.createPromo({'code': v['Code'],
            'discountType': v['Type (percentage/fixed)']!.isEmpty ? 'percentage' : v['Type (percentage/fixed)'],
            'discountValue': double.tryParse(v['Value'] ?? '0') ?? 0}), refresh, 'Promo added');
        }
      },
    );
  }
}

// ── Admin: Branding ───────────────────────────────────────────────────────────
class AdminBrandingScreen extends StatefulWidget {
  const AdminBrandingScreen({super.key});
  @override
  State<AdminBrandingScreen> createState() => _AdminBrandingScreenState();
}

class _AdminBrandingScreenState extends State<AdminBrandingScreen> {
  final _fields = {
    'appName': TextEditingController(),
    'primaryColor': TextEditingController(),
    'secondaryColor': TextEditingController(),
    'accentColor': TextEditingController(),
    'logoUrl': TextEditingController(),
  };
  bool _loading = true, _saving = false;

  @override
  void initState() {
    super.initState();
    api.adminBranding().then((b) {
      if (!mounted) return;
      b ??= {};
      for (final k in _fields.keys) {
        _fields[k]!.text = (b[k] ?? '').toString();
      }
      setState(() => _loading = false);
    }).catchError((_) { if (mounted) setState(() => _loading = false); });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await api.updateBranding({for (final e in _fields.entries) e.key: e.value.text.trim()});
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Branding saved')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendly(e))));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Branding')),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: _red))
          : ListView(padding: const EdgeInsets.all(16), children: [
              for (final e in _fields.entries)
                Padding(padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(controller: e.value, decoration: InputDecoration(labelText: e.key))),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _saving ? null : _save,
                style: FilledButton.styleFrom(backgroundColor: _red, minimumSize: const Size.fromHeight(48)),
                child: _saving
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Save branding'),
              ),
            ]),
    );
  }
}

// ── Plans / Subscription ─────────────────────────────────────────────────────
class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});
  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  late final Future<List<dynamic>> _plans = api.plans();
  late final Future<Map<String, dynamic>?> _sub = api.mySubscription();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription & Plans')),
      body: FutureBuilder<List<dynamic>>(
        future: _plans,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: _red));
          }
          if (snap.hasError) {
            return ErrorView(message: friendly(snap.error!), onRetry: () => setState(() {}));
          }
          final plans = snap.data ?? [];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              FutureBuilder<Map<String, dynamic>?>(
                future: _sub,
                builder: (_, s) {
                  final sub = s.data;
                  return Card(
                    color: const Color(0xFF1A1A1A),
                    child: ListTile(
                      leading: Icon(sub != null ? Icons.check_circle : Icons.info_outline,
                          color: sub != null ? Colors.green : Colors.white54),
                      title: Text(sub != null
                          ? 'Active: ${sub['plan']?['name'] ?? 'Subscribed'}'
                          : 'No active subscription'),
                      subtitle: sub != null && sub['endDate'] != null
                          ? Text('Renews/ends: ${sub['endDate'].toString().split('T').first}')
                          : const Text('Choose a plan below'),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              if (plans.isEmpty)
                const Padding(padding: EdgeInsets.all(24),
                    child: Center(child: Text('No plans configured yet.', style: TextStyle(color: Colors.white54)))),
              ...plans.map((p) => _PlanCard(p as Map<String, dynamic>)),
            ],
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final Map<String, dynamic> plan;
  const _PlanCard(this.plan);
  @override
  Widget build(BuildContext context) {
    final features = (plan['features'] is List) ? (plan['features'] as List) : const [];
    final popular = plan['isPopular'] == true;
    return Card(
      color: const Color(0xFF181818),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: popular ? _red : Colors.transparent, width: popular ? 1.5 : 0),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text((plan['name'] ?? '').toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              if (popular) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: _red, borderRadius: BorderRadius.circular(10)),
                  child: const Text('POPULAR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ]),
            const SizedBox(height: 4),
            Text('${plan['currency'] ?? ''} ${plan['price'] ?? ''} / ${plan['billingCycle'] ?? 'month'}',
                style: const TextStyle(color: _red, fontSize: 16, fontWeight: FontWeight.w600)),
            if ((plan['description'] ?? '').toString().isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(plan['description'].toString(), style: const TextStyle(color: Colors.white60, fontSize: 13)),
            ],
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(children: [
                    const Icon(Icons.check, size: 16, color: Colors.green),
                    const SizedBox(width: 6),
                    Expanded(child: Text(f.toString(), style: const TextStyle(fontSize: 13))),
                  ]),
                )),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected "${plan['name']}". Payment checkout is coming next.'))),
              style: FilledButton.styleFrom(backgroundColor: _red, minimumSize: const Size.fromHeight(44)),
              child: const Text('Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Settings ─────────────────────────────────────────────────────────────────
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('App'),
            subtitle: Text('OTT Platform • v1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.cloud_outlined),
            title: const Text('API server'),
            subtitle: Text(_apiBase),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Signed in as'),
            subtitle: Text(api.email.isEmpty ? '—' : api.email),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bookmark_remove_outlined),
            title: const Text('Clear My List'),
            onTap: () async {
              final items = await api.watchlist();
              for (final m in items) {
                await api.removeFromWatchlist((m as Map)['id'].toString());
              }
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('My List cleared')));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () async {
              await api.logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}

// ── Notifications ────────────────────────────────────────────────────────────
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: api.notifications(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: _red));
          }
          final items = (snap.data?['items'] is List) ? snap.data!['items'] as List : const [];
          if (items.isEmpty) {
            return const Center(child: Text('No notifications yet.', style: TextStyle(color: Colors.white38)));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final n = items[i] as Map<String, dynamic>;
              final unread = n['isRead'] == false;
              return ListTile(
                leading: Icon(unread ? Icons.circle : Icons.circle_outlined, size: 12, color: unread ? _red : Colors.white24),
                title: Text((n['title'] ?? '').toString()),
                subtitle: Text((n['body'] ?? '').toString()),
              );
            },
          );
        },
      ),
    );
  }
}

// ── Genre browse ─────────────────────────────────────────────────────────────
class _GenreBrowse extends StatelessWidget {
  const _GenreBrowse();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: api.genres(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator(color: _red));
        }
        final genres = snap.data ?? [];
        if (genres.isEmpty) {
          return const Center(child: Text('Type a title and press enter.', style: TextStyle(color: Colors.white38)));
        }
        return SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Browse by genre', style: TextStyle(fontWeight: FontWeight.w700))),
            Wrap(spacing: 8, runSpacing: 8, children: genres.map((g) {
              final m = g as Map<String, dynamic>;
              return ActionChip(
                label: Text((m['name'] ?? '').toString()),
                backgroundColor: const Color(0xFF1A1A1A),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => GenreScreen(genreId: m['id'].toString(), genreName: (m['name'] ?? '').toString()))),
              );
            }).toList()),
          ]),
        );
      },
    );
  }
}

class GenreScreen extends StatelessWidget {
  final String genreId, genreName;
  const GenreScreen({super.key, required this.genreId, required this.genreName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(genreName)),
      body: FutureBuilder<List<dynamic>>(
        future: api.byGenre(genreId),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: _red));
          }
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No titles in this genre yet.', style: TextStyle(color: Colors.white38)));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120, childAspectRatio: 2 / 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemCount: items.length,
            itemBuilder: (_, i) => PosterTile(items[i] as Map<String, dynamic>),
          );
        },
      ),
    );
  }
}

// ── Shared ───────────────────────────────────────────────────────────────────
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorView({super.key, required this.message, required this.onRetry});
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

String friendly(Object e) {
  if (e is DioException) {
    if (e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout) {
      return 'Cannot reach the backend at $_apiBase.\nIs the API running?';
    }
    final code = e.response?.statusCode;
    if (code == 401) return 'Invalid email or password.';
    if (code == 403) return 'Admin access required.';
    return 'Request failed${code != null ? ' ($code)' : ''}.';
  }
  return e.toString();
}
