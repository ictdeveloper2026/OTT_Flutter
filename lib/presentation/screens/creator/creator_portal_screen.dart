import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class CreatorPortalScreen extends StatefulWidget {
  const CreatorPortalScreen({super.key});

  @override
  State<CreatorPortalScreen> createState() => _CreatorPortalScreenState();
}

class _CreatorPortalScreenState extends State<CreatorPortalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Row(children: [
          Icon(Icons.video_camera_front, color: colors.primary),
          const SizedBox(width: 8),
          Text('Creator Studio', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        ]),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: colors.textPrimary), onPressed: () => context.pop()),
        elevation: 0,
        bottom: TabBar(
          controller: _tabs,
          labelColor: colors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: colors.primary,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Dashboard'),
            Tab(text: 'My Content'),
            Tab(text: 'Analytics'),
            Tab(text: 'Earnings'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/upload'),
        backgroundColor: colors.primary,
        icon: const Icon(Icons.upload, color: Colors.white),
        label: const Text('Upload', style: TextStyle(color: Colors.white)),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _buildDashboard(colors),
          _buildContentTab(colors),
          _buildAnalyticsTab(colors),
          _buildEarningsTab(colors),
        ],
      ),
    );
  }

  Widget _buildDashboard(OttColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _statCard('Total Views', '124.5K', Icons.visibility, Colors.blue, colors),
              _statCard('Watch Time', '8.2K hrs', Icons.access_time, Colors.green, colors),
              _statCard('Subscribers', '3,421', Icons.people, colors.primary, colors),
              _statCard('Earnings', '₹12,450', Icons.currency_rupee, Colors.amber, colors),
            ],
          ),
          const SizedBox(height: 24),
          // Recent activity
          Text('Recent Activity', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...List.generate(3, (i) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.movie, color: colors.textSecondary)),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Video Title ${i + 1}', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
                Text('${(4200 - i * 312)} views · Published ${i + 1} days ago',
                    style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              ])),
              Icon(Icons.trending_up, color: Colors.green, size: 20),
            ]),
          )),
          const SizedBox(height: 80), // FAB padding
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color, OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(icon, color: color, size: 22),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 11)),
        ]),
      ]),
    );
  }

  Widget _buildContentTab(OttColors colors) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, i) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.movie, color: colors.textSecondary),
          ),
          title: Text('My Video ${i + 1}', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
          subtitle: Text('${(1200 - i * 80)}K views · ${i == 0 ? "Processing" : "Published"}',
              style: TextStyle(color: colors.textSecondary, fontSize: 12)),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: i == 0 ? Colors.orange.withOpacity(0.15) : Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(i == 0 ? 'Processing' : 'Live',
                  style: TextStyle(color: i == 0 ? Colors.orange : Colors.green, fontSize: 11)),
            ),
            PopupMenuButton<String>(
              color: colors.surface,
              icon: Icon(Icons.more_vert, color: colors.textSecondary, size: 20),
              itemBuilder: (_) => [
                PopupMenuItem(value: 'edit', child: Text('Edit', style: TextStyle(color: colors.textPrimary))),
                PopupMenuItem(value: 'stats', child: Text('Analytics', style: TextStyle(color: colors.textPrimary))),
                const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab(OttColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Views Last 30 Days', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: Center(child: Text('Chart Placeholder\n(Integrate fl_chart)',
                  textAlign: TextAlign.center, style: TextStyle(color: colors.textSecondary))),
            ),
          ]),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Top Content', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...List.generate(5, (i) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(children: [
                Text('#${i + 1}', style: TextStyle(color: colors.primary, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(width: 12),
                Container(width: 36, height: 36, decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(6)),
                    child: Icon(Icons.movie, color: colors.textSecondary, size: 18)),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Video ${i + 1}', style: TextStyle(color: colors.textPrimary, fontSize: 13)),
                  Text('${(52000 - i * 8200)} views', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
                ])),
              ]),
            )),
          ]),
        ),
      ]),
    );
  }

  Widget _buildEarningsTab(OttColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [colors.primary, colors.primary.withRed(160)]),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: [
            const Text('Total Earnings', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const Text('₹ 12,450', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _earningsChip('This Month', '₹2,840', colors),
              _earningsChip('Pending', '₹1,200', colors),
              _earningsChip('Paid Out', '₹9,410', colors),
            ]),
          ]),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Payout History', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...List.generate(4, (i) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.green, size: 18)),
              title: Text('Payout #${4 - i}', style: TextStyle(color: colors.textPrimary, fontSize: 13)),
              subtitle: Text('${['Jun', 'May', 'Apr', 'Mar'][i]} 1, 2026', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              trailing: Text('₹${[3200, 2840, 2100, 1270][i]}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            )),
          ]),
        ),
        const SizedBox(height: 80),
      ]),
    );
  }

  Widget _earningsChip(String label, String value, OttColors colors) {
    return Column(children: [
      Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
    ]);
  }
}
