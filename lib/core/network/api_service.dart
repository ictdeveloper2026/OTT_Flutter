import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../../data/models/content.dart';

class ApiService {
  static ApiService? _instance;
  late final Dio _dio;
  final FlutterSecureStorage _storage;
  final Logger _logger;

  ApiService._(this._storage, this._logger) {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-App-Version': AppConstants.appVersion,
        'X-Platform': AppConstants.platform,
      },
    ));
    _dio.interceptors.addAll([
      _AuthInterceptor(_storage, _dio, _logger),
      _LoggingInterceptor(_logger),
      _RetryInterceptor(_dio),
    ]);
  }

  static ApiService get instance => _instance!;
  static void initialize(FlutterSecureStorage storage, Logger logger) {
    _instance ??= ApiService._(storage, logger);
  }

  Dio get dio => _dio;

  // ── Auth ──
  Future<Response> login(String email, String password, String? deviceId) =>
      _dio.post('/auth/login', data: {'email': email, 'password': password, 'deviceId': deviceId});

  Future<Response> register(Map<String, dynamic> data) => _dio.post('/auth/register', data: data);

  Future<Response> verifyOtp(String identifier, String otp, String purpose) =>
      _dio.post('/auth/verify-otp', data: {'identifier': identifier, 'otp': otp, 'purpose': purpose});

  Future<Response> refreshToken(String token) =>
      _dio.post('/auth/refresh', data: {'refreshToken': token});

  Future<Response> socialLogin(String provider, String accessToken) =>
      _dio.post('/auth/social', data: {'provider': provider, 'accessToken': accessToken});

  Future<Response> forgotPassword(String email) =>
      _dio.post('/auth/forgot-password', data: {'email': email});

  Future<Response> resetPassword(String token, String newPassword) =>
      _dio.post('/auth/reset-password', data: {'token': token, 'newPassword': newPassword});

  Future<Response> logout() => _dio.post('/auth/logout');

  // ── Branding & Config ──
  Future<Response> getBranding() => _dio.get('/config/branding');
  Future<Response> getPublicConfig() => _dio.get('/config/public');
  Future<Response> getNavigation() => _dio.get('/config/navigation');

  /// Typed branding fetch used by ThemeBloc. Pulls the `branding` block out of
  /// the /config/public bootstrap (ApiResponse-wrapped) and parses it.
  Future<BrandingConfig> getBrandingConfig() async {
    final res = await getPublicConfig();
    final body = (res.data is Map) ? Map<String, dynamic>.from(res.data) : <String, dynamic>{};
    final data = (body['data'] is Map) ? Map<String, dynamic>.from(body['data']) : body;
    final branding = (data['branding'] is Map) ? Map<String, dynamic>.from(data['branding']) : data;
    return BrandingConfig.fromJson(branding);
  }

  /// Persists branding changes via the admin endpoint.
  Future<void> updateBrandingConfig(BrandingConfig branding) =>
      adminUpdateBranding(branding.toJson());

  /// Full dynamic bootstrap (branding + feature flags + payments + social) as a raw map.
  Future<Map<String, dynamic>> getAppBootstrap() async {
    final res = await getPublicConfig();
    final body = (res.data is Map) ? Map<String, dynamic>.from(res.data) : <String, dynamic>{};
    return (body['data'] is Map) ? Map<String, dynamic>.from(body['data']) : body;
  }

  // ── Profiles ──
  Future<Response> getProfiles() => _dio.get('/profiles');
  Future<Response> createProfile(Map<String, dynamic> data) => _dio.post('/profiles', data: data);
  Future<Response> updateProfile(int id, Map<String, dynamic> data) => _dio.put('/profiles/$id', data: data);
  Future<Response> deleteProfile(int id) => _dio.delete('/profiles/$id');
  Future<Response> selectProfile(int id, String? pin) => _dio.post('/profiles/$id/select', data: {'pin': pin});

  // ── Contents ──
  Future<Response> getHomeRows() => _dio.get('/contents/home');
  Future<Response> getFeatured() => _dio.get('/contents/featured');
  Future<Response> getTrending({int page = 1}) => _dio.get('/contents/trending', queryParameters: {'page': page});
  Future<Response> getNewReleases({int page = 1}) => _dio.get('/contents/new-releases', queryParameters: {'page': page});
  Future<Response> getContent(int id) => _dio.get('/contents/$id');
  Future<Response> getContentsByGenre(String slug, {int page = 1}) => _dio.get('/genres/$slug/contents', queryParameters: {'page': page});
  Future<Response> searchContents(String q, {Map<String, dynamic>? filters, int page = 1}) =>
      _dio.get('/contents/search', queryParameters: {'q': q, 'page': page, ...?filters});
  Future<Response> getRelatedContents(int id) => _dio.get('/contents/$id/related');
  Future<Response> getSignedUrl(int contentId, String quality) =>
      _dio.get('/contents/$contentId/stream', queryParameters: {'quality': quality});

  // ── Series / Episodes ──
  Future<Response> getSeriesEpisodes(int seriesId, {int? season}) =>
      _dio.get('/series/$seriesId/episodes', queryParameters: season != null ? {'season': season} : null);

  // ── Watch History & Progress ──
  Future<Response> getWatchHistory({int page = 1}) => _dio.get('/watch-history', queryParameters: {'page': page});
  Future<Response> updateWatchProgress(int contentId, int watchedSeconds, int totalSeconds) =>
      _dio.post('/watch-history/$contentId/progress', data: {'watchedSeconds': watchedSeconds, 'totalSeconds': totalSeconds});
  Future<Response> getContinueWatching() => _dio.get('/watch-history/continue');

  // ── Watchlist ──
  Future<Response> getWatchlist({int page = 1}) => _dio.get('/watchlist', queryParameters: {'page': page});
  Future<Response> addToWatchlist(int contentId) => _dio.post('/watchlist', data: {'contentId': contentId});
  Future<Response> removeFromWatchlist(int contentId) => _dio.delete('/watchlist/$contentId');

  // ── Ratings ──
  Future<Response> rateContent(int contentId, String rating) =>
      _dio.post('/contents/$contentId/rate', data: {'rating': rating});

  // ── Live ──
  Future<Response> getLiveStreams({String? status}) =>
      _dio.get('/live', queryParameters: status != null ? {'status': status} : null);
  Future<Response> getLiveStream(int id) => _dio.get('/live/$id');
  Future<Response> getLiveSignedUrl(int id) => _dio.get('/live/$id/stream');
  Future<Response> joinLiveChat(int id) => _dio.post('/live/$id/chat/join');
  Future<Response> sendLiveChatMessage(int id, String message) =>
      _dio.post('/live/$id/chat', data: {'message': message});

  // ── Subscription & Payment ──
  Future<Response> getPlans() => _dio.get('/plans');
  Future<Response> initiateSubscription(int planId, {String? promoCode, String gateway = 'Razorpay'}) =>
      _dio.post('/subscriptions/initiate', data: {'planId': planId, 'promoCode': promoCode, 'gateway': gateway});
  Future<Response> confirmSubscription(Map<String, dynamic> data) =>
      _dio.post('/subscriptions/confirm', data: data);
  Future<Response> cancelSubscription(String reason) =>
      _dio.post('/subscriptions/cancel', data: {'reason': reason});
  Future<Response> getMySubscription() => _dio.get('/subscriptions/me');
  Future<Response> getInvoices({int page = 1}) => _dio.get('/invoices', queryParameters: {'page': page});
  Future<Response> validatePromoCode(String code, int planId) =>
      _dio.post('/promo/validate', data: {'code': code, 'planId': planId});

  // ── PPV ──
  Future<Response> initiatePPV(int contentId) => _dio.post('/ppv/$contentId/purchase');
  Future<Response> confirmPPV(Map<String, dynamic> data) => _dio.post('/ppv/confirm', data: data);

  // ── Notifications ──
  Future<Response> registerFCMToken(String token, String deviceType, String deviceId) =>
      _dio.post('/notifications/register', data: {'token': token, 'deviceType': deviceType, 'deviceId': deviceId});
  Future<Response> getNotifications({int page = 1}) => _dio.get('/notifications', queryParameters: {'page': page});
  Future<Response> markNotificationRead(int id) => _dio.put('/notifications/$id/read');
  Future<Response> markAllNotificationsRead() => _dio.put('/notifications/read-all');

  // ── Watch Party ──
  Future<Response> createWatchParty(int contentId) => _dio.post('/watch-party', data: {'contentId': contentId});
  Future<Response> joinWatchParty(String code) => _dio.post('/watch-party/$code/join');
  Future<Response> controlWatchParty(String code, String action, int? position) =>
      _dio.post('/watch-party/$code/control', data: {'action': action, 'position': position});

  // ── Admin ──
  Future<Response> adminGetStats() => _dio.get('/admin/stats');
  Future<Response> adminGetRevenue(String period) => _dio.get('/admin/revenue', queryParameters: {'period': period});
  Future<Response> adminGetContents({int page = 1, String? status, String? q}) =>
      _dio.get('/admin/contents', queryParameters: {'page': page, if (status != null) 'status': status, if (q != null) 'q': q});
  Future<Response> adminCreateContent(Map<String, dynamic> data) => _dio.post('/admin/contents', data: data);
  Future<Response> adminUpdateContent(int id, Map<String, dynamic> data) => _dio.put('/admin/contents/$id', data: data);
  Future<Response> adminDeleteContent(int id) => _dio.delete('/admin/contents/$id');
  Future<Response> adminUploadVideo(int contentId, String playerType, String? videoId, {FormData? formData}) {
    if (playerType == 'YouTube' || playerType == 'Vimeo') {
      return _dio.post('/admin/contents/$contentId/video-link', data: {'playerType': playerType, 'videoId': videoId});
    }
    return _dio.post('/admin/contents/$contentId/upload', data: formData, options: Options(receiveTimeout: const Duration(minutes: 30)));
  }
  Future<Response> adminGetBranding() => _dio.get('/admin/branding');
  Future<Response> adminUpdateBranding(Map<String, dynamic> data) => _dio.put('/admin/branding', data: data);
  Future<Response> adminGetBanners() => _dio.get('/admin/banners');
  Future<Response> adminSaveBanner(Map<String, dynamic> data, {int? id}) =>
      id == null ? _dio.post('/admin/banners', data: data) : _dio.put('/admin/banners/$id', data: data);
  Future<Response> adminDeleteBanner(int id) => _dio.delete('/admin/banners/$id');
  Future<Response> adminGetUsers({int page = 1, String? q}) =>
      _dio.get('/admin/users', queryParameters: {'page': page, if (q != null) 'q': q});
  Future<Response> adminCreateLiveStream(Map<String, dynamic> data) => _dio.post('/admin/live', data: data);
  Future<Response> adminUpdateLiveStream(int id, Map<String, dynamic> data) => _dio.put('/admin/live/$id', data: data);
  Future<Response> adminGetNavigation() => _dio.get('/admin/navigation');
  Future<Response> adminSaveNavigation(List<Map<String, dynamic>> items) => _dio.put('/admin/navigation', data: {'items': items});
  Future<Response> adminGetConfig() => _dio.get('/admin/config');
  Future<Response> adminUpdateConfig(String key, String value) => _dio.put('/admin/config/$key', data: {'value': value});
  Future<Response> adminGetContentRows() => _dio.get('/admin/content-rows');
  Future<Response> adminSaveContentRow(Map<String, dynamic> data, {int? id}) =>
      id == null ? _dio.post('/admin/content-rows', data: data) : _dio.put('/admin/content-rows/$id', data: data);
}

class _AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;
  final Logger _logger;
  bool _isRefreshing = false;
  final List<RequestOptions> _pendingRequests = [];

  _AuthInterceptor(this._storage, this._dio, this._logger);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _storage.read(key: 'access_token');
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !err.requestOptions.path.contains('/auth/')) {
      if (_isRefreshing) {
        _pendingRequests.add(err.requestOptions);
        return;
      }
      _isRefreshing = true;
      try {
        final refreshToken = await _storage.read(key: 'refresh_token');
        if (refreshToken == null) { handler.next(err); return; }
        final res = await _dio.post('/auth/refresh', data: {'refreshToken': refreshToken});
        final newToken = res.data['accessToken'];
        await _storage.write(key: 'access_token', value: newToken);
        for (final pending in _pendingRequests) {
          pending.headers['Authorization'] = 'Bearer $newToken';
          await _dio.fetch(pending);
        }
        _pendingRequests.clear();
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        handler.resolve(await _dio.fetch(err.requestOptions));
      } catch (e) {
        await _storage.deleteAll();
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }
}

class _LoggingInterceptor extends Interceptor {
  final Logger _logger;
  _LoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('→ ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('✕ ${err.requestOptions.path}: ${err.response?.statusCode} ${err.message}');
    handler.next(err);
  }
}

class _RetryInterceptor extends Interceptor {
  final Dio _dio;
  _RetryInterceptor(this._dio);

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
    if (retryCount < 2 && err.type == DioExceptionType.connectionError) {
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      await Future.delayed(Duration(seconds: retryCount + 1));
      try {
        handler.resolve(await _dio.fetch(err.requestOptions));
        return;
      } catch (_) {}
    }
    handler.next(err);
  }
}
