class AppConstants {
  AppConstants._();

  static const String appName = 'StreamVault';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  // API
  // NOTE: backend routes are mounted at /api (NOT /api/v1). Override host with
  // --dart-define=API_BASE_URL=http://localhost:8080 for local development.
  static const String baseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'https://api.streamvault.app');
  static const String apiPrefix = '/api';
  static const String apiBaseUrl = '$baseUrl$apiPrefix';
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
