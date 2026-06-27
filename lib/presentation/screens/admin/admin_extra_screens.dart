import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../blocs/admin/admin_bloc.dart';

// ── Admin Users Screen ─────────────────────────────────────────────────────────

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});
  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final _searchController = TextEditingController();
  String _roleFilter = 'all';
  int _page = 1;

  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(AdminUsersLoaded(page: _page));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Column(
      children: [
        _buildHeader(colors),
        _buildFilters(colors),
        Expanded(
          child: BlocBuilder<AdminBloc, dynamic>(
            builder: (context, state) {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 20,
                separatorBuilder: (_, __) => Divider(color: colors.divider, height: 1),
                itemBuilder: (context, i) => _buildUserTile(context, colors, i),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: colors.surface,
      child: Row(
        children: [
          Text('Users', style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          _buildStatChip('Total', '12,430', colors),
          const SizedBox(width: 8),
          _buildStatChip('Active', '9,821', colors, color: Colors.green),
          const SizedBox(width: 8),
          _buildStatChip('Subscribers', '3,241', colors, color: colors.primary),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String value, OttColors colors, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (color ?? colors.textSecondary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: color ?? colors.textSecondary, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildFilters(OttColors colors) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search users...',
                hintStyle: TextStyle(color: colors.textSecondary),
                prefixIcon: Icon(Icons.search, color: colors.textSecondary),
                filled: true,
                fillColor: colors.surface,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              onChanged: (q) => context.read<AdminBloc>().add(AdminUsersLoaded(page: 1, search: q)),
            ),
          ),
          const SizedBox(width: 12),
          DropdownButton<String>(
            value: _roleFilter,
            dropdownColor: colors.surface,
            style: TextStyle(color: colors.textPrimary),
            underline: const SizedBox.shrink(),
            items: const [
              DropdownMenuItem(value: 'all', child: Text('All')),
              DropdownMenuItem(value: 'viewer', child: Text('Viewers')),
              DropdownMenuItem(value: 'creator', child: Text('Creators')),
              DropdownMenuItem(value: 'admin', child: Text('Admins')),
            ],
            onChanged: (v) => setState(() => _roleFilter = v ?? 'all'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(BuildContext context, OttColors colors, int i) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: colors.primary,
        child: Text('U${i + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
      ),
      title: Text('User ${i + 1}', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
      subtitle: Text('user${i + 1}@example.com', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('Active', style: TextStyle(color: colors.primary, fontSize: 11)),
          ),
          PopupMenuButton<String>(
            color: colors.surface,
            icon: Icon(Icons.more_vert, color: colors.textSecondary),
            itemBuilder: (_) => [
              PopupMenuItem(value: 'view', child: Text('View Details', style: TextStyle(color: colors.textPrimary))),
              PopupMenuItem(value: 'block', child: Text('Block User', style: TextStyle(color: Colors.orange))),
              PopupMenuItem(value: 'delete', child: Text('Delete User', style: const TextStyle(color: Colors.red))),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// ── Admin Analytics Screen ─────────────────────────────────────────────────────

class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});
  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Column(
      children: [
        Container(
          color: colors.surface,
          child: TabBar(
            controller: _tabs,
            labelColor: colors.primary,
            unselectedLabelColor: colors.textSecondary,
            indicatorColor: colors.primary,
            tabs: const [Tab(text: 'Overview'), Tab(text: 'Content'), Tab(text: 'Users')],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: [
              _buildOverviewTab(colors),
              _buildContentTab(colors),
              _buildUsersTab(colors),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab(OttColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildMetricCards(colors),
          const SizedBox(height: 24),
          _buildChartCard('Views Over Time (Last 30 Days)', colors),
          const SizedBox(height: 16),
          _buildChartCard('Revenue (Last 12 Months)', colors),
        ],
      ),
    );
  }

  Widget _buildMetricCards(OttColors colors) {
    final metrics = [
      ('Total Views', '4.2M', Icons.play_circle_outline, Colors.blue, '+12%'),
      ('Watch Time', '890K hrs', Icons.access_time, Colors.green, '+8%'),
      ('Avg Session', '47 min', Icons.timer_outlined, Colors.orange, '+3%'),
      ('Completion', '72%', Icons.check_circle_outline, colors.primary, '+5%'),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: metrics.map((m) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(m.$3, color: m.$4, size: 20),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                  child: Text(m.$5, style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Spacer(),
            Text(m.$2, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(m.$1, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildChartCard(String title, OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('Chart Placeholder\n(Use fl_chart in production)', textAlign: TextAlign.center, style: TextStyle(color: colors.textSecondary))),
          ),
        ],
      ),
    );
  }

  Widget _buildContentTab(OttColors colors) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, i) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.movie, color: colors.textSecondary)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Content Title ${i + 1}', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
                  Text('${(12345 - i * 432).toString()} views · ${(72 - i).toStringAsFixed(0)}% completion', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            Column(
              children: [
                Text('#${i + 1}', style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold)),
                Icon(i == 0 ? Icons.trending_up : Icons.trending_down, color: i == 0 ? Colors.green : Colors.red, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersTab(OttColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildChartCard('User Growth (Last 12 Months)', colors),
          const SizedBox(height: 16),
          _buildChartCard('Subscriber vs Free Users', colors),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top Regions', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ...['India', 'USA', 'UAE', 'UK', 'Singapore'].indexed.map((entry) {
                  final (i, region) = entry;
                  final pct = [42, 24, 12, 8, 5][i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(region, style: TextStyle(color: colors.textPrimary, fontSize: 13)),
                          const Spacer(),
                          Text('$pct%', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                        ]),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(value: pct / 100, backgroundColor: colors.background, color: colors.primary, minHeight: 4,
                          borderRadius: BorderRadius.circular(2)),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Admin Revenue Screen ───────────────────────────────────────────────────────

class AdminRevenueScreen extends StatelessWidget {
  const AdminRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRevenueCards(colors),
          const SizedBox(height: 24),
          _buildRecentTransactions(colors),
        ],
      ),
    );
  }

  Widget _buildRevenueCards(OttColors colors) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _revenueCard('Monthly Revenue', '₹4,82,340', '+18%', colors.primary, colors),
        _revenueCard('Annual Revenue', '₹52,40,800', '+22%', Colors.green, colors),
        _revenueCard('Active Subs', '3,241', '+9%', Colors.blue, colors),
        _revenueCard('Churn Rate', '2.4%', '-0.3%', Colors.orange, colors),
      ],
    );
  }

  Widget _revenueCard(String label, String value, String change, Color color, OttColors colors) {
    final isPositive = change.startsWith('+');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isPositive ? Colors.green : Colors.red, size: 14),
                  Text(change, style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 12)),
                  Text(' vs last month', style: TextStyle(color: colors.textSecondary, fontSize: 10)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions(OttColors colors) {
    return Container(
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text('Recent Transactions', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
                const Spacer(),
                Text('View all', style: TextStyle(color: colors.primary, fontSize: 13)),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            separatorBuilder: (_, __) => Divider(color: colors.divider, height: 1),
            itemBuilder: (context, i) => ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 18,
                backgroundColor: colors.primary.withOpacity(0.15),
                child: Icon(Icons.person, color: colors.primary, size: 18),
              ),
              title: Text('User ${i + 1}', style: TextStyle(color: colors.textPrimary, fontSize: 13)),
              subtitle: Text('Premium Plan · Razorpay', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${299 + i * 100}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                  Text('${i + 1}h ago', style: TextStyle(color: colors.textSecondary, fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Admin Plans Screen ─────────────────────────────────────────────────────────

class AdminPlansScreen extends StatelessWidget {
  const AdminPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: colors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Plan', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, i) {
          final plans = [
            ('Basic', 99, 1, 1, false, false),
            ('Standard', 249, 2, 2, false, true),
            ('Premium', 499, 5, 4, true, true),
          ];
          final p = plans[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12),
              border: p.$2 == 249 ? Border.all(color: colors.primary, width: 2) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(p.$1, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(width: 8),
                    if (p.$2 == 249)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(12)),
                        child: const Text('POPULAR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit, color: colors.textSecondary, size: 20)),
                  ],
                ),
                Text('₹${p.$2}/month', style: TextStyle(color: colors.primary, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _featureRow('Profiles', '${p.$3}', colors),
                _featureRow('Streams', '${p.$4}', colors),
                _featureRow('Downloads', p.$5 ? 'Yes' : 'No', colors),
                _featureRow('4K UHD', p.$6 ? 'Yes' : 'No', colors),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('Active: 1,234 users', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                    const Spacer(),
                    Switch(value: true, onChanged: (_) {}, activeThumbColor: colors.primary),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _featureRow(String label, String value, OttColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 13)),
          const Spacer(),
          Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
