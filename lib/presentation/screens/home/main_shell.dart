import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../../core/theme/app_theme.dart';

enum AppDevice { phone, tablet, tv, web }

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  AppDevice _detectDevice(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1280) return AppDevice.web;
    if (width >= 768) return AppDevice.tablet;
    return AppDevice.phone;
  }

  int _currentIndex(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    if (loc.startsWith('/home')) return 0;
    if (loc.startsWith('/search')) return 1;
    if (loc.startsWith('/livetv')) return 3; // must precede '/live' (shared prefix)
    if (loc.startsWith('/live')) return 2;
    if (loc.startsWith('/downloads')) return 4;
    if (loc.startsWith('/community')) return 5;
    if (loc.startsWith('/watchlist')) return 6;
    return 0;
  }

  void _onNavTap(BuildContext context, int index) {
    switch (index) {
      case 0: context.go('/home'); break;
      case 1: context.go('/search'); break;
      case 2: context.go('/live'); break;
      case 3: context.go('/livetv'); break;
      case 4: context.go('/downloads'); break;
      case 5: context.go('/community'); break;
      case 6: context.go('/watchlist'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final device = _detectDevice(context);
    final colors = Theme.of(context).extension<OttColors>()!;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final navItems = [
          _NavItem(Icons.home_rounded, Icons.home_outlined, 'Home'),
          _NavItem(Icons.search_rounded, Icons.search_outlined, 'Search'),
          _NavItem(Icons.live_tv_rounded, Icons.live_tv_outlined, 'Live'),
          _NavItem(Icons.tv_rounded, Icons.tv_outlined, 'Live TV'),
          _NavItem(Icons.download_done_rounded, Icons.download_outlined, 'Downloads'),
          _NavItem(Icons.forum_rounded, Icons.forum_outlined, 'Community'),
          _NavItem(Icons.bookmark_rounded, Icons.bookmark_border_rounded, 'My List'),
        ];

        switch (device) {
          case AppDevice.web:
          case AppDevice.tablet:
            return _TabletLayout(child: child, navItems: navItems, colors: colors, currentIndex: _currentIndex(context), onTap: (i) => _onNavTap(context, i));
          default:
            return _PhoneLayout(child: child, navItems: navItems, colors: colors, currentIndex: _currentIndex(context), onTap: (i) => _onNavTap(context, i));
        }
      },
    );
  }
}

class _PhoneLayout extends StatelessWidget {
  final Widget child;
  final List<_NavItem> navItems;
  final OttColors colors;
  final int currentIndex;
  final void Function(int) onTap;
  const _PhoneLayout({required this.child, required this.navItems, required this.colors, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          border: Border(top: BorderSide(color: colors.textSecondary.withOpacity(0.08), width: 0.5)),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              children: List.generate(navItems.length, (i) {
                final item = navItems[i];
                final selected = i == currentIndex;
                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: selected ? BoxDecoration(
                            color: colors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ) : null,
                          child: Icon(selected ? item.selectedIcon : item.icon, color: selected ? colors.primary : colors.textSecondary, size: 22),
                        ),
                        const SizedBox(height: 2),
                        Text(item.label, style: TextStyle(fontSize: 10, fontWeight: selected ? FontWeight.w600 : FontWeight.w400, color: selected ? colors.primary : colors.textSecondary)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final Widget child;
  final List<_NavItem> navItems;
  final OttColors colors;
  final int currentIndex;
  final void Function(int) onTap;
  const _TabletLayout({required this.child, required this.navItems, required this.colors, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 1280;
    return Scaffold(
      backgroundColor: colors.bg,
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: const Color(0xFF0D0D0D),
            selectedIndex: currentIndex,
            onDestinationSelected: onTap,
            extended: isWide,
            minWidth: 60,
            minExtendedWidth: 200,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: isWide
                  ? Row(children: [
                      const SizedBox(width: 8),
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(8))),
                      const SizedBox(width: 8),
                      Text('StreamFlix', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w800, fontSize: 16)),
                    ])
                  : Container(width: 36, height: 36, decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(8))),
            ),
            destinations: navItems.map((item) => NavigationRailDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: Text(item.label),
            )).toList(),
          ),
          VerticalDivider(thickness: 0.5, width: 0.5, color: colors.textSecondary.withOpacity(0.08)),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData selectedIcon;
  final IconData icon;
  final String label;
  const _NavItem(this.selectedIcon, this.icon, this.label);
}
