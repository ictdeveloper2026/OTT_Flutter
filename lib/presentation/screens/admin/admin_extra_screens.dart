import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/theme/app_theme.dart';
import 'plan_edit_screen.dart';

// Formats a number as an Indian-style ₹ amount with thousands separators.
String _money(num? v) {
  final n = (v ?? 0).round();
  final s = n.abs().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return '${n < 0 ? '-' : ''}₹$buf';
}

// ── Admin Users Screen ─────────────────────────────────────────────────────────
class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});
  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final _api = sl<ApiService>();
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _users = [];
  Map<String, dynamic> _stats = {};
  String _role = 'all';
  int _page = 1;
  bool _hasMore = false;
  bool _loading = true;
  bool _loadingMore = false;
  String? _error;

  String? get _search => _searchController.text.trim().isEmpty ? null : _searchController.text.trim();

  @override
  void initState() {
    super.initState();
    _load();
  }

  // Loads page 1 (replaces the list). Also refreshes header stats.
  Future<void> _load() async {
    setState(() { _loading = true; _error = null; _page = 1; });
    try {
      final results = await Future.wait([
        _api.adminGetUsers(page: 1, search: _search, role: _role),
        _api.getAdminStats(),
      ]);
      if (!mounted) return;
      final paged = results[0];
      setState(() {
        _users = ((paged['data'] ?? const []) as List).map((e) => Map<String, dynamic>.from(e)).toList();
        _hasMore = paged['hasNextPage'] == true;
        _stats = results[1];
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore) return;
    setState(() => _loadingMore = true);
    try {
      final paged = await _api.adminGetUsers(page: _page + 1, search: _search, role: _role);
      if (!mounted) return;
      setState(() {
        _page += 1;
        _users.addAll(((paged['data'] ?? const []) as List).map((e) => Map<String, dynamic>.from(e)));
        _hasMore = paged['hasNextPage'] == true;
        _loadingMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loadingMore = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _setStatus(Map<String, dynamic> user, String status) async {
    try {
      await _api.adminChangeUserStatus(user['id'].toString(), status);
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(16),
        color: colors.surface,
        child: Row(children: [
          Text('Users', style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          _statChip('Total', '${_stats['totalUsers'] ?? '—'}', colors),
          const SizedBox(width: 8),
          _statChip('Subscribers', '${_stats['activeSubscriptions'] ?? '—'}', colors, color: colors.primary),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search by name or email…',
                hintStyle: TextStyle(color: colors.textSecondary),
                prefixIcon: Icon(Icons.search, color: colors.textSecondary),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              onSubmitted: (_) => _load(),
            ),
          ),
          const SizedBox(width: 12),
          DropdownButton<String>(
            value: _role,
            dropdownColor: colors.surface,
            style: TextStyle(color: colors.textPrimary),
            underline: const SizedBox.shrink(),
            items: const [
              DropdownMenuItem(value: 'all', child: Text('All')),
              DropdownMenuItem(value: 'viewer', child: Text('Viewers')),
              DropdownMenuItem(value: 'creator', child: Text('Creators')),
              DropdownMenuItem(value: 'admin', child: Text('Admins')),
            ],
            onChanged: (v) { setState(() => _role = v ?? 'all'); _load(); },
          ),
        ]),
      ),
      Expanded(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? _ErrorView(message: _error!, onRetry: _load)
                : _users.isEmpty
                    ? Center(child: Text('No users found', style: TextStyle(color: colors.textSecondary)))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _users.length + (_hasMore ? 1 : 0),
                        separatorBuilder: (_, __) => Divider(color: colors.divider, height: 1),
                        itemBuilder: (_, i) {
                          if (i >= _users.length) {
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Center(
                                child: _loadingMore
                                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                    : TextButton(onPressed: _loadMore, child: const Text('Load more')),
                              ),
                            );
                          }
                          return _userTile(colors, _users[i]);
                        },
                      ),
      ),
    ]);
  }

  Widget _statChip(String label, String value, OttColors colors, {Color? color}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: (color ?? colors.textSecondary).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Text(value, style: TextStyle(color: color ?? colors.textSecondary, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 10)),
        ]),
      );

  Widget _userTile(OttColors colors, Map<String, dynamic> u) {
    final name = [u['firstName'], u['lastName']].where((e) => e != null && '$e'.isNotEmpty).join(' ');
    final blocked = u['isBlocked'] == true;
    final role = (u['role'] ?? 'viewer').toString();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: CircleAvatar(
        backgroundColor: blocked ? colors.textSecondary : colors.primary,
        child: Text((name.isNotEmpty ? name[0] : (u['email'] ?? '?').toString()[0]).toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 14)),
      ),
      title: Text(name.isEmpty ? (u['email'] ?? '').toString() : name, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
      subtitle: Text('${u['email'] ?? ''} · $role', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: (blocked ? Colors.red : Colors.green).withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
          child: Text(blocked ? 'Blocked' : 'Active', style: TextStyle(color: blocked ? Colors.red : Colors.green, fontSize: 11)),
        ),
        PopupMenuButton<String>(
          color: colors.surface,
          icon: Icon(Icons.more_vert, color: colors.textSecondary),
          onSelected: (a) => _setStatus(u, a == 'block' ? 'blocked' : 'active'),
          itemBuilder: (_) => [
            if (!blocked) PopupMenuItem(value: 'block', child: Text('Block user', style: TextStyle(color: Colors.orange)))
            else PopupMenuItem(value: 'unblock', child: Text('Unblock user', style: TextStyle(color: Colors.green))),
          ],
        ),
      ]),
    );
  }
}

// ── Admin Analytics Screen ─────────────────────────────────────────────────────
class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});
  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  final _api = sl<ApiService>();
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _revenue = [];
  List<Map<String, dynamic>> _topContent = [];
  List<Map<String, dynamic>> _regions = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final results = await Future.wait([
        _api.getAdminStats(),
        _api.getAdminAnalytics(period: '30d'),
        _api.adminGetTopContent(limit: 10),
        _api.adminGetRegions(),
      ]);
      if (!mounted) return;
      setState(() {
        _stats = results[0] as Map<String, dynamic>;
        _revenue = (results[1] as List).map((e) => Map<String, dynamic>.from(e)).toList();
        _topContent = (results[2] as List).map((e) => Map<String, dynamic>.from(e)).toList();
        _regions = (results[3] as List).map((e) => Map<String, dynamic>.from(e)).toList();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return _ErrorView(message: _error!, onRetry: _load);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.7,
          children: [
            _metric('Total Users', '${_stats['totalUsers'] ?? 0}', Icons.people_outline, Colors.blue, colors),
            _metric('Active Subs', '${_stats['activeSubscriptions'] ?? 0}', Icons.card_membership, Colors.green, colors),
            _metric('Content', '${_stats['totalContent'] ?? 0}', Icons.movie_outlined, Colors.orange, colors),
            _metric('Live Now', '${_stats['liveStreams'] ?? 0}', Icons.live_tv, colors.primary, colors),
          ],
        ),
        const SizedBox(height: 20),
        Text('Revenue (last 30 days)', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text('This month so far: ${_money(_stats['monthlyRevenue'])}', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        const SizedBox(height: 12),
        _RevenueBars(data: _revenue),
        const SizedBox(height: 20),
        Text('Top content by views', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        if (_topContent.isEmpty)
          Text('No view data yet', style: TextStyle(color: colors.textSecondary, fontSize: 12))
        else
          ..._topContent.asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(children: [
                  SizedBox(width: 24, child: Text('#${e.key + 1}', style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold))),
                  Expanded(child: Text((e.value['title'] ?? '').toString(), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: colors.textPrimary))),
                  Text('${e.value['views'] ?? 0} views', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                ]),
              )),
        const SizedBox(height: 20),
        Text('Top regions', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        if (_regions.isEmpty)
          Text('No regional data yet', style: TextStyle(color: colors.textSecondary, fontSize: 12))
        else
          ..._regions.map((r) {
            final total = _regions.fold<num>(0, (s, x) => s + ((x['count'] ?? 0) as num));
            final pct = total == 0 ? 0.0 : ((r['count'] ?? 0) as num) / total;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text((r['country'] ?? 'Unknown').toString(), style: TextStyle(color: colors.textPrimary, fontSize: 13))),
                  Text('${((pct) * 100).round()}%', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                ]),
                const SizedBox(height: 4),
                LinearProgressIndicator(value: pct.toDouble(), backgroundColor: colors.background, color: colors.primary, minHeight: 4, borderRadius: BorderRadius.circular(2)),
              ]),
            );
          }),
      ]),
    );
  }

  Widget _metric(String label, String value, IconData icon, Color color, OttColors colors) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 20),
          const Spacer(),
          Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
        ]),
      );
}

// ── Admin Revenue Screen ───────────────────────────────────────────────────────
class AdminRevenueScreen extends StatefulWidget {
  const AdminRevenueScreen({super.key});
  @override
  State<AdminRevenueScreen> createState() => _AdminRevenueScreenState();
}

class _AdminRevenueScreenState extends State<AdminRevenueScreen> {
  final _api = sl<ApiService>();
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _revenue = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final results = await Future.wait([_api.getAdminStats(), _api.getAdminAnalytics(period: '90d')]);
      if (!mounted) return;
      setState(() {
        _stats = results[0] as Map<String, dynamic>;
        _revenue = (results[1] as List).map((e) => Map<String, dynamic>.from(e)).toList();
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return _ErrorView(message: _error!, onRetry: _load);
    final total90 = _revenue.fold<num>(0, (s, r) => s + (r['amount'] ?? 0));
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.6,
          children: [
            _card('This Month', _money(_stats['monthlyRevenue']), colors.primary, colors),
            _card('Last 90 Days', _money(total90), Colors.green, colors),
            _card('Active Subs', '${_stats['activeSubscriptions'] ?? 0}', Colors.blue, colors),
            _card('Content', '${_stats['totalContent'] ?? 0}', Colors.orange, colors),
          ],
        ),
        const SizedBox(height: 20),
        Text('Daily revenue (last 90 days)', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _RevenueBars(data: _revenue),
        const SizedBox(height: 12),
        if (_revenue.isEmpty)
          Text('No successful payments in this period yet.', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
      ]),
    );
  }

  Widget _card(String label, String value, Color color, OttColors colors) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
          Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
      );
}

// Simple bar chart from [{label, amount}] with no external chart dependency.
class _RevenueBars extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const _RevenueBars({required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    if (data.isEmpty) {
      return Container(
        height: 140,
        decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center,
        child: Text('No revenue data', style: TextStyle(color: colors.textSecondary)),
      );
    }
    final maxAmount = data.map((r) => (r['amount'] ?? 0) as num).fold<num>(1, (a, b) => a > b ? a : b);
    return Container(
      height: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((r) {
          final amount = (r['amount'] ?? 0) as num;
          final h = (amount / maxAmount * 120).clamp(2.0, 120.0);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: Tooltip(
                message: '${r['label']}: ${_money(amount)}',
                child: Container(height: h.toDouble(), decoration: BoxDecoration(
                  color: colors.primary, borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                )),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Admin Plans Screen ─────────────────────────────────────────────────────────
class AdminPlansScreen extends StatefulWidget {
  const AdminPlansScreen({super.key});
  @override
  State<AdminPlansScreen> createState() => _AdminPlansScreenState();
}

class _AdminPlansScreenState extends State<AdminPlansScreen> {
  final _api = sl<ApiService>();
  List<Map<String, dynamic>> _plans = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final raw = await _api.adminGetPlans();
      if (!mounted) return;
      setState(() { _plans = raw.map((e) => Map<String, dynamic>.from(e)).toList(); _loading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditor(),
        icon: const Icon(Icons.add),
        label: const Text('New plan'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(message: _error!, onRetry: _load)
              : _plans.isEmpty
                  ? Center(child: Text('No subscription plans yet', style: TextStyle(color: colors.textSecondary)))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _plans.length,
                      itemBuilder: (_, i) => _planCard(colors, _plans[i]),
                    ),
    );
  }

  Future<void> _openEditor([Map<String, dynamic>? plan]) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => PlanEditScreen(plan: plan)),
    );
    if (saved == true) await _load();
  }

  Widget _planCard(OttColors colors, Map<String, dynamic> p) {
    final popular = p['isPopular'] == true;
    final active = p['isActive'] == true;
    final currency = (p['currency'] ?? 'INR').toString();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: popular ? Border.all(color: colors.primary, width: 2) : null,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text((p['name'] ?? '').toString(), style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(width: 8),
          if (popular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(12)),
              child: const Text('POPULAR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          const Spacer(),
          Icon(active ? Icons.check_circle : Icons.cancel, color: active ? Colors.green : colors.textSecondary, size: 18),
          IconButton(icon: Icon(Icons.edit, color: colors.textSecondary, size: 18), onPressed: () => _openEditor(p)),
        ]),
        Text('$currency ${p['price'] ?? 0}/${p['billingCycle'] ?? 'month'}', style: TextStyle(color: colors.primary, fontSize: 22, fontWeight: FontWeight.bold)),
        if ((p['description'] ?? '').toString().isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(p['description'].toString(), style: TextStyle(color: colors.textSecondary, fontSize: 13)),
        ],
        const SizedBox(height: 12),
        _feature('Profiles', '${p['maxProfiles'] ?? 1}', colors),
        _feature('Streams', '${p['maxStreams'] ?? 1}', colors),
        _feature('Downloads', p['allowDownloads'] == true ? 'Yes' : 'No', colors),
        _feature('4K UHD', p['allowUhd'] == true ? 'Yes' : 'No', colors),
      ]),
    );
  }

  Widget _feature(String label, String value, OttColors colors) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(children: [
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 13)),
          const Spacer(),
          Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
        ]),
      );
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.cloud_off, color: colors.textSecondary, size: 44),
        const SizedBox(height: 12),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Text(message, textAlign: TextAlign.center, style: TextStyle(color: colors.textSecondary))),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
      ]),
    );
  }
}
