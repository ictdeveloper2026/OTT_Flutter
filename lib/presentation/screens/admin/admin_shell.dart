import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Admin shell with nav drawer
class AdminShell extends StatelessWidget {
  final Widget child;
  const AdminShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;
    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            _AdminSideNav(),
            Expanded(child: child),
          ],
        ),
      );
    }
    return Scaffold(
      drawer: Drawer(child: _AdminSideNav()),
      body: child,
    );
  }
}

class _AdminSideNav extends StatelessWidget {
  final _items = const [
    _NavItem(icon: Icons.dashboard_outlined, label: 'Dashboard', route: '/admin/dashboard'),
    _NavItem(icon: Icons.movie_outlined, label: 'Content', route: '/admin/content'),
    _NavItem(icon: Icons.upload_file_outlined, label: 'Upload', route: '/admin/content/upload'),
    _NavItem(icon: Icons.live_tv_outlined, label: 'Live', route: '/admin/live'),
    _NavItem(icon: Icons.view_carousel_outlined, label: 'Banners', route: '/admin/banners'),
    _NavItem(icon: Icons.view_list_outlined, label: 'Content Rows', route: '/admin/rows'),
    _NavItem(icon: Icons.people_outline, label: 'Users', route: '/admin/users'),
    _NavItem(icon: Icons.subscriptions_outlined, label: 'Plans', route: '/admin/plans'),
    _NavItem(icon: Icons.local_offer_outlined, label: 'Promos', route: '/admin/promos'),
    _NavItem(icon: Icons.analytics_outlined, label: 'Analytics', route: '/admin/analytics'),
    _NavItem(icon: Icons.currency_rupee, label: 'Revenue', route: '/admin/revenue'),
    _NavItem(icon: Icons.palette_outlined, label: 'Branding', route: '/admin/branding'),
    _NavItem(icon: Icons.settings_outlined, label: 'Config', route: '/admin/config'),
  ];

  const _AdminSideNav();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRoute = GoRouterState.of(context).uri.toString();
    return Container(
      width: 220,
      color: const Color(0xFF0D0D0D),
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Text('Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _items.length,
              itemBuilder: (ctx, i) {
                final item = _items[i];
                final isActive = currentRoute.startsWith(item.route);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isActive ? theme.colorScheme.primary.withOpacity(0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    dense: true,
                    leading: Icon(item.icon, color: isActive ? theme.colorScheme.primary : Colors.white60, size: 20),
                    title: Text(item.label, style: TextStyle(color: isActive ? theme.colorScheme.primary : Colors.white70, fontSize: 13, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
                    onTap: () => context.go(item.route),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.arrow_back, color: Colors.white60, size: 20),
              title: const Text('Back to App', style: TextStyle(color: Colors.white70, fontSize: 13)),
              onTap: () => context.go('/home'),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;
  const _NavItem({required this.icon, required this.label, required this.route});
}
