import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/otp_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/home/main_shell.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/live/live_screen.dart';
import '../../presentation/screens/live/live_tv_channels_screen.dart';
import '../../presentation/screens/live/channel_player_screen.dart';
import '../../presentation/screens/downloads/downloads_screen.dart';
import '../../presentation/screens/content/content_detail_screen.dart';
import '../../presentation/screens/player/video_player_screen.dart';
import '../../presentation/screens/profiles/profiles_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/subscription/plans_screen.dart';
import '../../presentation/screens/subscription/billing_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/parental_control/parental_control_screen.dart';
import '../../presentation/screens/creator/creator_portal_screen.dart';
import '../../presentation/screens/admin/admin_shell.dart';
import '../../presentation/screens/admin/admin_dashboard_screen.dart';
import '../../presentation/screens/admin/admin_content_screen.dart';
import '../../presentation/screens/admin/content_upload_screen.dart';
import '../../presentation/screens/admin/content_tracks_screen.dart';
import '../../presentation/screens/admin/community_admin_screen.dart';
import '../../presentation/screens/admin/admin_config_screens.dart';
import '../../presentation/screens/admin/admin_extra_screens.dart';
import '../../presentation/screens/admin/admin_promos_rows_screens.dart';
import '../../presentation/screens/community/community_screen.dart';
import '../../presentation/screens/admin/branding_screen.dart';

/// Simple placeholder for screens that are not built yet.
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Text('$title\n(coming soon)', textAlign: TextAlign.center),
        ),
      );
}

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static final _adminShellKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isAuthenticated = authState is AuthAuthenticated;
      final isOnAuthPage = state.matchedLocation.startsWith('/auth') || state.matchedLocation == '/splash';

      if (!isAuthenticated && !isOnAuthPage) return '/auth/login';
      if (isAuthenticated && isOnAuthPage && state.matchedLocation != '/splash') return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(
        path: '/auth',
        builder: (_, __) => const PlaceholderScreen('Welcome'),
        routes: [
          GoRoute(path: 'login',    builder: (_, __) => const LoginScreen()),
          GoRoute(path: 'register', builder: (_, __) => const RegisterScreen()),
          GoRoute(path: 'otp',      builder: (_, state) => OtpScreen(email: state.uri.queryParameters['identifier'] ?? state.uri.queryParameters['email'] ?? '')),
          GoRoute(path: 'forgot',   builder: (_, __) => const PlaceholderScreen('Forgot password')),
        ],
      ),

      // ── Main App Shell ──
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, __, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
          GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
          GoRoute(path: '/live', builder: (_, __) => const LiveScreen()),
          GoRoute(path: '/livetv', builder: (_, __) => const LiveTvChannelsScreen()),
          GoRoute(path: '/downloads', builder: (_, __) => const DownloadsScreen()),
          GoRoute(path: '/community', builder: (_, __) => const CommunityScreen()),
          GoRoute(path: '/watchlist', builder: (_, __) => const PlaceholderScreen('My list')),
        ],
      ),

      // ── Full-screen routes ──
      GoRoute(path: '/content/:id', builder: (_, state) => ContentDetailScreen(contentId: state.pathParameters['id']!)),
      GoRoute(path: '/play/:id', builder: (_, state) => VideoPlayerScreen(contentId: state.pathParameters['id'] ?? '', startPosition: int.tryParse(state.uri.queryParameters['t'] ?? '0') ?? 0)),
      GoRoute(path: '/live/play/:id', builder: (_, __) => const PlaceholderScreen('Live player')),
      GoRoute(path: '/livetv/play', builder: (_, state) {
        final extra = (state.extra as Map?) ?? const {};
        return ChannelPlayerScreen(url: (extra['url'] ?? '').toString(), title: (extra['title'] ?? 'Live TV').toString());
      }),
      GoRoute(path: '/genre/:slug', builder: (_, __) => const PlaceholderScreen('Genre')),
      GoRoute(path: '/watch-history', builder: (_, __) => const PlaceholderScreen('Watch history')),
      GoRoute(path: '/watch-party/:code', builder: (_, __) => const PlaceholderScreen('Watch party')),

      // ── Profile ──
      GoRoute(path: '/profiles', builder: (_, __) => const ProfilesScreen()),
      GoRoute(path: '/profiles/edit', builder: (_, __) => const EditProfileScreen()),
      GoRoute(path: '/profile', builder: (_, __) => const PlaceholderScreen('Profile')),

      // ── Subscription ──
      GoRoute(path: '/subscribe', builder: (_, __) => const PlansScreen()),
      GoRoute(path: '/checkout/:planId', builder: (_, __) => const PlaceholderScreen('Checkout')),
      GoRoute(path: '/billing', builder: (_, __) => const BillingScreen()),

      // ── Settings ──
      GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      GoRoute(path: '/parental-control', builder: (_, __) => const ParentalControlScreen()),

      // ── Creator ──
      GoRoute(path: '/creator', builder: (_, __) => const CreatorPortalScreen()),

      // ── Admin Shell ──
      ShellRoute(
        navigatorKey: _adminShellKey,
        builder: (_, __, child) => AdminShell(child: child),
        routes: [
          GoRoute(path: '/admin',               builder: (_, __) => const AdminDashboardScreen()),
          GoRoute(path: '/admin/dashboard',     builder: (_, __) => const AdminDashboardScreen()),
          GoRoute(path: '/admin/content',       builder: (_, __) => const AdminContentScreen()),
          GoRoute(
            path: '/admin/content/upload',
            builder: (_, state) {
              // "Edit" passes the existing title's id via extra so the form prefills
              // and updates (instead of creating a duplicate).
              final extra = state.extra is Map ? state.extra as Map : const {};
              return ContentUploadScreen(contentId: extra['contentId'] as String?);
            },
          ),
          GoRoute(
            path: '/admin/content/tracks',
            builder: (_, state) {
              final extra = state.extra is Map ? state.extra as Map : const {};
              return ContentTracksScreen(
                contentId: (extra['contentId'] ?? '').toString(),
                title: extra['title'] as String?,
              );
            },
          ),
          GoRoute(path: '/admin/branding',      builder: (_, __) => const BrandingScreen()),
          GoRoute(path: '/admin/community',     builder: (_, __) => const CommunityAdminScreen()),
          GoRoute(path: '/admin/live',          builder: (_, __) => const LiveTvChannelsScreen()),
          GoRoute(path: '/admin/banners',       builder: (_, __) => const AdminBannersScreen()),
          GoRoute(path: '/admin/rows',          builder: (_, __) => const AdminRowsScreen()),
          GoRoute(path: '/admin/users',         builder: (_, __) => const AdminUsersScreen()),
          GoRoute(path: '/admin/plans',         builder: (_, __) => const AdminPlansScreen()),
          GoRoute(path: '/admin/promos',        builder: (_, __) => const AdminPromosScreen()),
          GoRoute(path: '/admin/analytics',     builder: (_, __) => const AdminAnalyticsScreen()),
          GoRoute(path: '/admin/subscriptions', builder: (_, __) => const AdminPlansScreen()),
          GoRoute(path: '/admin/revenue',       builder: (_, __) => const AdminRevenueScreen()),
          GoRoute(path: '/admin/navigation',    builder: (_, __) => const PlaceholderScreen('Navigation')),
          GoRoute(path: '/admin/config',        builder: (_, __) => const AdminConfigScreen()),
          GoRoute(path: '/admin/creators',      builder: (_, __) => const PlaceholderScreen('Creators')),
        ],
      ),
    ],
    errorBuilder: (_, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.error}')),
    ),
  );
}
