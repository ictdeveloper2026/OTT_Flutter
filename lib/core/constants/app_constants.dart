import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  AppConstants._();

  static const String appName = 'StreamVault';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;
  static const String platform = 'flutter';

  // API
  // One codebase, both environments — resolved at runtime so no code edits when switching:
  //   1. An explicit --dart-define=API_BASE_URL=... always wins (CI, release, or forcing a host).
  //   2. Otherwise on web, auto-detect: served from localhost/127.0.0.1 -> local backend;
  //      any real domain -> production. (Production deploys to a real domain, so it self-selects.)
  //   3. Otherwise (mobile/desktop, no override) -> production.
  // Backend routes are mounted at /api (NOT /api/v1).
  static const String _envBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String prodBaseUrl = 'https://api.streamvault.app';
  static const String localBaseUrl = 'http://localhost:50664';

  static String get baseUrl {
    if (_envBaseUrl.isNotEmpty) return _envBaseUrl;
    if (kIsWeb) {
      final host = Uri.base.host;
      if (host == 'localhost' || host == '127.0.0.1') return localBaseUrl;
    }
    return prodBaseUrl;
  }

  static String get wsBaseUrl => baseUrl;
  static const String apiPrefix = '/api';
  static String get apiBaseUrl => '$baseUrl$apiPrefix';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 60000;

  // Storage keys
  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String brandingKey = 'branding_config';
  static const String profileKey = 'active_profile';
  static const String onboardingKey = 'onboarding_done';
  static const String themeKey = 'theme_mode';

  // Pagination
  static const int pageSize = 20;
  static const int searchDebounce = 400;

  // Player
  static const int progressSyncInterval = 15; // seconds
  static const int skipIntroSeconds = 85;
  static const int skipOutroSeconds = 30;
  static const double skipForwardSeconds = 10.0;
  static const double skipBackwardSeconds = 10.0;

  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double tvBreakpoint = 1800;

  // Image sizes
  static const String posterAspect = '2:3';
  static const String bannerAspect = '16:9';
  static const String thumbnailAspect = '16:9';

  // Cache durations
  static const Duration brandingCacheDuration = Duration(hours: 1);
  static const Duration contentCacheDuration = Duration(minutes: 15);

  // Download
  static const int maxDownloads = 25;
  static const int downloadExpireDays = 30;

  // Profiles
  static const int maxProfiles = 5;

  // Hive boxes
  static const String settingsBox = 'settings';
  static const String cacheBox = 'cache';
  static const String downloadsBox = 'downloads';
}
