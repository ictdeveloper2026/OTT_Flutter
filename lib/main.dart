// Clean, self-contained OTT app wired to the .NET backend.
// Login -> Home (banner + rows) -> Detail -> Video player, plus Search, Profile, and an Admin panel.
// Independent of the older half-built screens/blocs (still in lib/, not imported).
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
      home: api.isLoggedIn ? const HomeShell() : const LoginScreen(),
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
      if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomeShell()));
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

// ── Shell with bottom navigation ─────────────────────────────────────────────
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  late final List<Widget> _tabs = const [HomeTab(), SearchTab(), MyListTab(), ProfileTab()];

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
  Future<List<List<dynamic>>> _fetch() async => Future.wait([api.featured(), api.trending(), api.newReleases()]);

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
            return ErrorView(message: friendly(snap.error!), onRetry: () => setState(() => _load = _fetch()));
          }
          final featured = snap.data![0], trending = snap.data![1], fresh = snap.data![2];
          if (featured.isEmpty && trending.isEmpty && fresh.isEmpty) {
            return const Center(child: Text('No content yet.', style: TextStyle(color: Colors.white54)));
          }
          return ListView(
            children: [
              if (featured.isNotEmpty) _Banner(featured.first as Map<String, dynamic>),
              _Row('Featured', featured),
              _Row('Trending', trending),
              _Row('New Releases', fresh),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  final Map<String, dynamic> item;
  const _Banner(this.item);
  @override
  Widget build(BuildContext context) {
    final img = posterOf(item);
    return GestureDetector(
      onTap: () => openDetail(context, item),
      child: Container(
        height: 220,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          image: img.isEmpty ? null : DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
          color: const Color(0xFF1A1A1A),
        ),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87]),
          ),
          child: Text((item['title'] ?? '').toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        ),
      ),
    );
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
  late final Future<Map<String, dynamic>> _load = api.detail(widget.id);

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
                                      builder: (_) => PlayerScreen(url: video, title: (d['title'] ?? '').toString())));
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
  const PlayerScreen({super.key, required this.url, required this.title});
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final VideoPlayerController _c;
  bool _ready = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _c.initialize().then((_) {
      if (!mounted) return;
      setState(() => _ready = true);
      _c.play();
    }).catchError((Object e) {
      if (mounted) setState(() => _error = 'Could not play this video.');
    });
  }

  @override
  void dispose() { _c.dispose(); super.dispose(); }

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
                ? const Center(child: Text('Type a title and press enter.', style: TextStyle(color: Colors.white38)))
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

class MyListTab extends StatelessWidget {
  const MyListTab({super.key});
  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Your saved titles will appear here.', style: TextStyle(color: Colors.white38)));
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
        if (api.isAdmin)
          ListTile(
            leading: const Icon(Icons.admin_panel_settings, color: _red),
            title: const Text('Admin panel'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminScreen())),
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

// ── Admin panel ──────────────────────────────────────────────────────────────
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late Future<List<dynamic>> _load = api.adminContents();

  Future<void> _refresh() async => setState(() => _load = api.adminContents());

  Future<void> _addDialog() async {
    final title = TextEditingController();
    final desc = TextEditingController();
    final poster = TextEditingController(text: 'https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/300/450');
    bool featured = true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: const Text('Add title'),
          content: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
              const SizedBox(height: 8),
              TextField(controller: desc, decoration: const InputDecoration(labelText: 'Description'), maxLines: 2),
              const SizedBox(height: 8),
              TextField(controller: poster, decoration: const InputDecoration(labelText: 'Poster URL')),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: featured, onChanged: (v) => setS(() => featured = v ?? true),
                title: const Text('Featured'),
              ),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Add')),
          ],
        ),
      ),
    );
    if (ok == true && title.text.trim().isNotEmpty) {
      try {
        await api.createAndPublish(title.text.trim(), desc.text.trim(), poster.text.trim(), featured);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title added & published')));
          _refresh();
        }
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendly(e))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin panel')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _red, onPressed: _addDialog,
        icon: const Icon(Icons.add), label: const Text('Add title'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _load,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator(color: _red));
          }
          if (snap.hasError) {
            return ErrorView(message: friendly(snap.error!), onRetry: _refresh);
          }
          final items = snap.data ?? [];
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              children: [
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
                const Padding(padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Text('Content', style: TextStyle(fontWeight: FontWeight.w700))),
                ...items.map((c) {
                  final m = c as Map<String, dynamic>;
                  return ListTile(
                    leading: ClipRRect(borderRadius: BorderRadius.circular(4),
                        child: SizedBox(width: 38, height: 56,
                            child: posterOf(m).isEmpty ? const ColoredBox(color: Color(0xFF1A1A1A))
                                : Image.network(posterOf(m), fit: BoxFit.cover, errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF1A1A1A))))),
                    title: Text((m['title'] ?? '').toString()),
                    subtitle: Text('${m['type'] ?? ''} • ${m['isFeatured'] == true ? 'featured' : 'standard'}'),
                  );
                }),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _stat(String label, dynamic value) => Expanded(
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
