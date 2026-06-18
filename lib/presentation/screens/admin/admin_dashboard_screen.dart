import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../presentation/blocs/admin/admin_bloc.dart';
import '../../../core/theme/app_theme.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});
  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(AdminDashboardLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), actions: [
        IconButton(icon: const Icon(Icons.refresh), onPressed: () => context.read<AdminBloc>().add(AdminDashboardLoaded())),
      ]),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) return const Center(child: CircularProgressIndicator());
          if (state is AdminDashboardReady) return _buildDashboard(context, state.stats, theme, ott);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, Map<String, dynamic> stats, ThemeData theme, OttColors ott) {
    final totalUsers = stats['totalUsers'] ?? 0;
    final activeSubscriptions = stats['activeSubscriptions'] ?? 0;
    final totalRevenue = stats['totalRevenue'] ?? 0.0;
    final totalContent = stats['totalContent'] ?? 0;
    final liveStreams = stats['liveStreams'] ?? 0;
    final dailyActiveUsers = stats['dailyActiveUsers'] ?? 0;

    return RefreshIndicator(
      onRefresh: () async => context.read<AdminBloc>().add(AdminDashboardLoaded()),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Stats grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _StatCard(label: 'Total Users', value: _fmt(totalUsers), icon: Icons.people_outline, color: Colors.blue),
                _StatCard(label: 'Subscriptions', value: _fmt(activeSubscriptions), icon: Icons.subscriptions_outlined, color: Colors.green),
                _StatCard(label: 'Revenue', value: '₹${_fmt(totalRevenue.toInt())}', icon: Icons.currency_rupee, color: Colors.amber),
                _StatCard(label: 'Content', value: _fmt(totalContent), icon: Icons.movie_outlined, color: Colors.purple),
                _StatCard(label: 'Live Streams', value: _fmt(liveStreams), icon: Icons.live_tv_outlined, color: Colors.red),
                _StatCard(label: 'DAU', value: _fmt(dailyActiveUsers), icon: Icons.trending_up, color: Colors.teal),
              ],
            ),
            const SizedBox(height: 24),
            // Quick actions
            Text('Quick Actions', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _ActionChip(icon: Icons.upload, label: 'Upload Content', onTap: () => context.go('/admin/content/upload')),
                _ActionChip(icon: Icons.live_tv, label: 'Go Live', onTap: () => context.go('/admin/live')),
                _ActionChip(icon: Icons.palette, label: 'Branding', onTap: () => context.go('/admin/branding')),
                _ActionChip(icon: Icons.people, label: 'Users', onTap: () => context.go('/admin/users')),
                _ActionChip(icon: Icons.analytics, label: 'Analytics', onTap: () => context.go('/admin/analytics')),
                _ActionChip(icon: Icons.view_list, label: 'Content Rows', onTap: () => context.go('/admin/rows')),
              ],
            ),
            const SizedBox(height: 24),
            // Revenue chart placeholder
            if (stats['revenueChart'] != null) ...[
              Text('Revenue (30 days)', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                height: 180,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: ott.surface, borderRadius: BorderRadius.circular(16)),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _buildSpots(stats['revenueChart']),
                        isCurved: true,
                        color: theme.colorScheme.primary,
                        barWidth: 2.5,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: theme.colorScheme.primary.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<FlSpot> _buildSpots(dynamic data) {
    if (data is List) {
      return data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value as num).toDouble())).toList();
    }
    return const [FlSpot(0, 0)];
  }

  String _fmt(int value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return '$value';
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: ott.surface, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(color: ott.textSecondary, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500, fontSize: 13)),
        ]),
      ),
    );
  }
}
