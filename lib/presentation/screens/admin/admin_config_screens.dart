import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';

// ── Admin Banners Screen ───────────────────────────────────────────────────────

class AdminBannersScreen extends StatefulWidget {
  const AdminBannersScreen({super.key});

  @override
  State<AdminBannersScreen> createState() => _AdminBannersScreenState();
}

class _AdminBannersScreenState extends State<AdminBannersScreen> {
  final List<_Banner> _banners = [
    _Banner('Summer Blockbuster', 'Watch the hottest movies', true, 1),
    _Banner('New Series Drop', 'Season 2 is here', true, 2),
    _Banner('Live Event Tonight', 'Don\'t miss the game', false, 3),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBannerEditor(context, null),
        backgroundColor: colors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Banner', style: TextStyle(color: Colors.white)),
      ),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _banners.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = _banners.removeAt(oldIndex);
            _banners.insert(newIndex, item);
          });
        },
        itemBuilder: (context, i) {
          final banner = _banners[i];
          return _buildBannerCard(context, banner, colors, i);
        },
      ),
    );
  }

  Widget _buildBannerCard(BuildContext context, _Banner banner, OttColors colors, int index) {
    return Container(
      key: ValueKey(banner.title),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Banner preview
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary.withOpacity(0.6), colors.surface],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(banner.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(banner.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                Icon(Icons.drag_handle, color: Colors.white.withOpacity(0.6)),
              ],
            ),
          ),
          // Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Text('Order: ${banner.order}', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                const Spacer(),
                Switch(value: banner.isActive, onChanged: (v) => setState(() => banner.isActive = v), activeThumbColor: colors.primary),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.edit, color: colors.textSecondary, size: 20),
                  onPressed: () => _showBannerEditor(context, banner),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () => setState(() => _banners.removeAt(index)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBannerEditor(BuildContext context, _Banner? banner) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final titleCtrl = TextEditingController(text: banner?.title ?? '');
    final subtitleCtrl = TextEditingController(text: banner?.subtitle ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20, right: 20, top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(banner == null ? 'Add Banner' : 'Edit Banner',
              style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          TextField(controller: titleCtrl, style: TextStyle(color: colors.textPrimary),
              decoration: _inputDeco('Title', colors)),
          const SizedBox(height: 12),
          TextField(controller: subtitleCtrl, style: TextStyle(color: colors.textPrimary),
              decoration: _inputDeco('Subtitle', colors)),
          const SizedBox(height: 20),
          GradientButton(
            label: banner == null ? 'Add Banner' : 'Save',
            onPressed: () {
              if (banner == null) {
                setState(() => _banners.add(_Banner(titleCtrl.text, subtitleCtrl.text, true, _banners.length + 1)));
              }
              Navigator.pop(context);
            },
            width: double.infinity,
          ),
        ]),
      ),
    );
  }

  InputDecoration _inputDeco(String label, OttColors colors) => InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: colors.textSecondary),
    filled: true,
    fillColor: colors.background,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: colors.primary)),
  );
}

class _Banner {
  String title;
  String subtitle;
  bool isActive;
  int order;
  _Banner(this.title, this.subtitle, this.isActive, this.order);
}

// ── Admin Config Screen ────────────────────────────────────────────────────────

class AdminConfigScreen extends StatefulWidget {
  const AdminConfigScreen({super.key});

  @override
  State<AdminConfigScreen> createState() => _AdminConfigScreenState();
}

class _AdminConfigScreenState extends State<AdminConfigScreen> with SingleTickerProviderStateMixin {
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
    return Column(children: [
      Container(
        color: colors.surface,
        child: TabBar(
          controller: _tabs,
          labelColor: colors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: colors.primary,
          tabs: const [Tab(text: 'General'), Tab(text: 'Features'), Tab(text: 'Integrations')],
        ),
      ),
      Expanded(
        child: TabBarView(controller: _tabs, children: [
          _buildGeneralTab(colors),
          _buildFeaturesTab(colors),
          _buildIntegrationsTab(colors),
        ]),
      ),
    ]);
  }

  Widget _buildGeneralTab(OttColors colors) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        _configSection('App Info', [
          _configField('App Name', 'OTT Platform', colors),
          _configField('Support Email', 'support@yourapp.com', colors),
          _configField('Contact Phone', '+91 9876543210', colors),
          _configField('Terms URL', 'https://yourapp.com/terms', colors),
          _configField('Privacy URL', 'https://yourapp.com/privacy', colors),
        ], colors),
        const SizedBox(height: 16),
        _configSection('Content Settings', [
          _configField('Default Language', 'English (en)', colors),
          _configField('Max Upload Size (MB)', '5000', colors),
          _configField('Free Trial Days', '7', colors),
        ], colors),
        const SizedBox(height: 24),
        GradientButton(label: 'Save Configuration', onPressed: () {}, width: double.infinity),
      ]),
    );
  }

  Widget _buildFeaturesTab(OttColors colors) {
    final features = [
      ('Watch Party', true, 'Allow users to watch together in real-time'),
      ('Downloads', true, 'Enable offline downloads for subscribers'),
      ('Live Streaming', true, 'Allow live stream creation'),
      ('Creator Portal', false, 'Enable creator uploads and monetization'),
      ('Social Login', true, 'Google and Facebook sign-in'),
      ('Push Notifications', true, 'FCM push notifications'),
      ('DRM Protection', false, 'Widevine/FairPlay DRM for content'),
      ('Ad Integration', false, 'AVOD ad-supported content'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...features.map((f) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(f.$1, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
              Text(f.$3, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
            ])),
            Switch(value: f.$2, onChanged: (_) {}, activeThumbColor: colors.primary),
          ]),
        )),
      ],
    );
  }

  Widget _buildIntegrationsTab(OttColors colors) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _integrationCard('Razorpay', 'Payment Gateway', Icons.payment, true, colors),
        _integrationCard('Stripe', 'International Payments', Icons.credit_card, false, colors),
        _integrationCard('SendGrid', 'Email Delivery', Icons.email, true, colors),
        _integrationCard('Firebase FCM', 'Push Notifications', Icons.notifications, true, colors),
        _integrationCard('AWS S3', 'Media Storage', Icons.cloud, true, colors),
        _integrationCard('Ant Media', 'Live Streaming', Icons.live_tv, false, colors),
        _integrationCard('Elasticsearch', 'Search Engine', Icons.search, false, colors),
        _integrationCard('Cloudflare', 'CDN & DDoS', Icons.security, false, colors),
      ],
    );
  }

  Widget _integrationCard(String name, String desc, IconData icon, bool connected, OttColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: colors.primary, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
          Text(desc, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: connected ? Colors.green.withOpacity(0.1) : colors.background,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(connected ? 'Connected' : 'Configure',
              style: TextStyle(color: connected ? Colors.green : colors.primary, fontSize: 12, fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  Widget _configSection(String title, List<Widget> fields, OttColors colors) {
    return Container(
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
          child: Text(title, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        ),
        ...fields,
      ]),
    );
  }

  Widget _configField(String label, String value, OttColors colors) {
    return ListTile(
      dense: true,
      title: Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 13)),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(value, style: TextStyle(color: colors.textPrimary, fontSize: 13)),
        const SizedBox(width: 8),
        Icon(Icons.edit, color: colors.textSecondary, size: 16),
      ]),
    );
  }
}

// ── Admin Live Streams Screen ─────────────────────────────────────────────────

class AdminLiveScreen extends StatefulWidget {
  const AdminLiveScreen({super.key});

  @override
  State<AdminLiveScreen> createState() => _AdminLiveScreenState();
}

class _AdminLiveScreenState extends State<AdminLiveScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: colors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Stream', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          // Live now banner
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFE50914), Color(0xFFB71C1C)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(children: [
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              const Text('1 Stream Live Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Text('234 viewers', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
              itemCount: 5,
              itemBuilder: (context, i) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(color: colors.background, borderRadius: BorderRadius.circular(8)),
                    child: Stack(children: [
                      Center(child: Icon(Icons.live_tv, color: colors.textSecondary)),
                      if (i == 0)
                        Positioned(top: 4, right: 4, child: Container(
                          width: 8, height: 8,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        )),
                    ]),
                  ),
                  title: Text('Stream ${i + 1}', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500)),
                  subtitle: Text(i == 0 ? '234 viewers · 1h 23m' : 'Scheduled · ${['Today 8PM', 'Tomorrow 3PM', 'Jun 15', 'Jun 18'][i - 1]}',
                      style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                  trailing: _streamStatusChip(i, colors),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _streamStatusChip(int i, OttColors colors) {
    final label = i == 0 ? 'LIVE' : 'Scheduled';
    final color = i == 0 ? Colors.red : Colors.blue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}
