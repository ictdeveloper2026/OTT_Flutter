import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import '../constants/app_constants.dart';
import '../../data/models/content.dart';

/// The single canonical API client (Path B). Returns already-unwrapped JSON data (the `data` field
/// of the backend ApiResponse envelope) so repositories stay thin. Ids are GUID strings. Auth +
/// refresh + retry are handled by interceptors; the JWT lives in flutter_secure_storage.
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
      _AuthInterceptor(_storage, _dio),
      _LoggingInterceptor(_logger),
      _RetryInterceptor(_dio),
    ]);
  }

  static ApiService get instance => _instance!;
  static void initialize(FlutterSecureStorage storage, Logger logger) {
    _instance ??= ApiService._(storage, logger);
  }

  factory ApiService(FlutterSecureStorage storage, Logger logger) {
    initialize(storage, logger);
    return _instance!;
  }

  Dio get dio => _dio;

  // Unwraps the {success, message, data} envelope; falls back to the raw body.
  dynamic _data(Response r) {
    final body = r.data;
    if (body is Map && body.containsKey('data')) return body['data'];
    return body;
  }

  Map<String, dynamic> _map(Response r) {
    final d = _data(r);
    return d is Map ? Map<String, dynamic>.from(d) : <String, dynamic>{};
  }

  List<dynamic> _list(Response r) {
    final d = _data(r);
    return d is List ? d : const [];
  }

  // Normalizes a backend PagedResultDto ({items,totalCount,page,pageSize}) to the
  // {data,total,hasNextPage} shape the repositories consume.
  Map<String, dynamic> _paged(Response r) {
    final d = _map(r);
    final items = d['items'] ?? d['data'] ?? const [];
    final total = (d['totalCount'] ?? d['total'] ?? (items as List).length) as int;
    final page = (d['page'] ?? 1) as int;
    final pageSize = (d['pageSize'] ?? (items as List).length) as int;
    return {'data': items, 'total': total, 'hasNextPage': page * pageSize < total};
  }

  // ── Auth ──
  Future<Map<String, dynamic>> login({required String email, required String password}) async =>
      _map(await _dio.post('/auth/login', data: {'email': email, 'password': password}));

  Future<Map<String, dynamic>> register({required String name, required String email, required String password, String? phone}) async {
    final parts = name.trim().split(' ');
    return _map(await _dio.post('/auth/register', data: {
      'email': email, 'password': password,
      'firstName': parts.first,
      'lastName': parts.length > 1 ? parts.sublist(1).join(' ') : '',
      'phone': phone,
    }));
  }

  Future<Map<String, dynamic>> socialLogin({required String provider, required String token}) async =>
      _map(await _dio.post('/auth/social', data: {'provider': provider, 'token': token}));

  Future<Map<String, dynamic>> verifyOtp({required String email, required String otp}) async =>
      _map(await _dio.post('/auth/verify-otp', data: {'email': email, 'otp': otp}));

  Future<void> forgotPassword({required String email}) =>
      _dio.post('/auth/forgot-password', data: {'email': email});

  Future<void> resetPassword({required String token, required String password}) =>
      _dio.post('/auth/reset-password', data: {'token': token, 'newPassword': password});

  Future<void> logout() => _dio.post('/auth/logout');

  // Persists the JWT so the auth interceptor can attach it; matches the keys it reads.
  Future<void> saveSession(Map<String, dynamic> data) async {
    final access = data['accessToken'] as String?;
    final refresh = data['refreshToken'] as String?;
    if (access != null) await _storage.write(key: 'access_token', value: access);
    if (refresh != null) await _storage.write(key: 'refresh_token', value: refresh);
  }
  Future<void> clearSession() => _storage.deleteAll();

  Future<Map<String, dynamic>?> getMe() async {
    final r = await _dio.get('/profiles/me');
    final d = _data(r);
    return d is Map ? Map<String, dynamic>.from(d) : null;
  }

  // ── Branding / Config ──
  Future<Response> getPublicConfig() => _dio.get('/config/public');

  Future<BrandingConfig> getBrandingConfig() async {
    final res = await getPublicConfig();
    final data = _map(res);
    final branding = (data['branding'] is Map) ? Map<String, dynamic>.from(data['branding']) : data;
    return BrandingConfig.fromJson(branding);
  }

  Future<void> updateBrandingConfig(BrandingConfig branding) =>
      _dio.put('/admin/branding', data: branding.toJson());

  Future<Map<String, dynamic>> getAppBootstrap() async => _map(await getPublicConfig());

  // ── Profiles ──
  Future<List<dynamic>> getProfiles() async => _list(await _dio.get('/profiles'));

  Future<Map<String, dynamic>> createProfile({required String name, String? avatarUrl, bool isKid = false}) async =>
      _map(await _dio.post('/profiles', data: {'name': name, 'avatarUrl': avatarUrl, 'isKids': isKid}));

  Future<Map<String, dynamic>> updateProfile({required String profileId, String? name, String? avatarUrl}) async =>
      _map(await _dio.put('/profiles/$profileId', data: {'name': name, 'avatarUrl': avatarUrl}));

  Future<void> deleteProfile(String profileId) => _dio.delete('/profiles/$profileId');

  Future<Map<String, dynamic>> selectProfile(String profileId) async {
    final data = _map(await _dio.post('/profiles/$profileId/select'));
    // The select response carries a NEW access token with the profile_id claim — persist it,
    // or every profile-scoped call (watchlist, watch-history, rate) would fail "no active profile".
    await saveSession(data);
    return data;
  }

  Future<void> setProfilePin({required String profileId, required String pin}) =>
      _dio.put('/profiles/$profileId/pin', data: {'pin': pin});

  Future<Map<String, dynamic>> verifyProfilePin({required String profileId, required String pin}) async =>
      _map(await _dio.post('/profiles/$profileId/pin/verify', data: {'pin': pin}));

  // ── Catalog ──
  Future<List<dynamic>> getBanners() async => (_map(await _dio.get('/contents/home'))['banners'] as List?) ?? const [];
  Future<List<dynamic>> getContentRows() async => (_map(await _dio.get('/contents/home'))['rows'] as List?) ?? const [];
  Future<List<dynamic>> getFeatured() async => _list(await _dio.get('/contents/featured'));
  Future<Map<String, dynamic>> getContent(String contentId) async => _map(await _dio.get('/contents/$contentId'));
  Future<List<dynamic>> getRelated(String contentId) async => _list(await _dio.get('/contents/$contentId/related'));

  Future<Map<String, dynamic>> search({required String query, String? genre, String? type, int page = 1}) async =>
      _paged(await _dio.get('/contents/search', queryParameters: {
        'q': query, if (type != null) 'type': type, if (genre != null) 'genre': genre, 'page': page,
      }));

  Future<Map<String, dynamic>> getByGenre(String genreId, {int page = 1}) async =>
      _paged(await _dio.get('/contents/genre/$genreId', queryParameters: {'page': page}));

  // Backend returns {stream: StreamUrlsDto, streamSessionId, ...}; normalize the nested
  // StreamUrlsDto (hls/streamProvider/youtubeId/…) into the flat shape StreamInfo.fromJson reads.
  Future<Map<String, dynamic>> getStreamUrl({required String contentId, String? episodeId}) async {
    final data = _map(await _dio.get('/contents/$contentId/stream',
        queryParameters: {if (episodeId != null) 'episodeId': episodeId}));
    final s = data['stream'] is Map ? Map<String, dynamic>.from(data['stream']) : data;
    return {
      'url': s['hls'] ?? s['youtubeUrl'] ?? s['vimeoUrl'] ?? '',
      'type': s['streamProvider'] ?? 'hls',
      'youtubeVideoId': s['youtubeId'],
      'vimeoVideoId': s['vimeoId'],
      'isDrm': s['drmLicenseUrl'] != null,
      'drmLicenseUrl': s['drmLicenseUrl'],
      'qualities': s['qualities'] is Map
          ? (s['qualities'] as Map).entries.map((e) => {'quality': e.key, 'url': e.value}).toList()
          : (s['qualities'] ?? const []),
      'subtitles': s['subtitles'] ?? const [],
      'streamSessionId': data['streamSessionId'],
    };
  }

  // ── Watch history / list / ratings ──
  Future<List<dynamic>> getContinueWatching() async => _list(await _dio.get('/watch-history/continue'));
  Future<List<dynamic>> getWatchlist() async => _list(await _dio.get('/watchlist'));
  Future<void> addToWatchlist(String contentId) => _dio.post('/watchlist', data: {'contentId': contentId});
  Future<void> removeFromWatchlist(String contentId) => _dio.delete('/watchlist/$contentId');
  Future<void> rateContent(String contentId, double rating) =>
      _dio.post('/contents/$contentId/rate', data: {'rating': rating});

  Future<void> updateWatchHistory({
    required String contentId, String? episodeId, required int positionSeconds, required int durationSeconds,
  }) =>
      _dio.post('/watch-history/$contentId/progress', data: {
        'watchedSeconds': positionSeconds, 'totalSeconds': durationSeconds, 'episodeId': episodeId,
      });

  // ── Live ──
  Future<List<dynamic>> getLiveStreams() async => (_map(await _dio.get('/live'))['items'] as List?) ?? const [];
  Future<Map<String, dynamic>> getLiveStream(String streamId) async => _map(await _dio.get('/live/$streamId'));

  // ── Subscriptions / billing ──
  Future<List<dynamic>> getSubscriptionPlans() async => _list(await _dio.get('/plans'));
  Future<Map<String, dynamic>?> getMySubscription() async {
    final r = await _dio.get('/subscriptions/me');
    final d = _data(r);
    return d is Map ? Map<String, dynamic>.from(d) : null;
  }

  Future<Map<String, dynamic>> initiateSubscription({required String planId, String? promoCode}) async =>
      _map(await _dio.post('/subscriptions/order', data: {'planId': planId, 'promoCode': promoCode}));

  Future<Map<String, dynamic>> confirmSubscription({required String orderId, required String paymentId, String? signature}) async =>
      _map(await _dio.post('/subscriptions/verify', data: {'orderId': orderId, 'paymentId': paymentId, 'signature': signature}));

  Future<void> cancelSubscription() => _dio.post('/subscriptions/cancel');

  Future<Map<String, dynamic>> validatePromo({required String code, required String planId}) async =>
      _map(await _dio.post('/promo/validate', data: {'code': code, 'planId': planId}));

  Future<Map<String, dynamic>> verifyIap({required String productId, required String purchaseToken, required String platform}) async =>
      _map(await _dio.post('/subscriptions/iap/verify', data: {'productId': productId, 'purchaseToken': purchaseToken, 'platform': platform}));

  // ── Admin ──
  Future<Map<String, dynamic>> getAdminStats() async => _map(await _dio.get('/admin/stats'));
  Future<List<dynamic>> getAdminAnalytics({String period = '30d'}) async => _list(await _dio.get('/admin/revenue', queryParameters: {'period': period}));
  Future<Map<String, dynamic>> adminGetContents({int page = 1, String? search}) async =>
      _paged(await _dio.get('/admin/contents', queryParameters: {'page': page, if (search != null) 'q': search}));
  Future<void> adminDeleteContent(String contentId) => _dio.delete('/admin/contents/$contentId');
  Future<void> adminToggleContent(String contentId, bool isActive) =>
      _dio.put('/admin/contents/$contentId', data: {'status': isActive ? 'published' : 'draft'});
  Future<Map<String, dynamic>> adminGetUsers({int page = 1, String? search}) async =>
      _paged(await _dio.get('/admin/users', queryParameters: {'page': page, if (search != null) 'q': search}));
  Future<void> adminChangeUserStatus(String userId, String status) =>
      _dio.put('/admin/users/$userId/status', data: {'status': status});
  Future<List<dynamic>> adminGetLiveStreams() async => (_map(await _dio.get('/admin/live'))['items'] as List?) ?? const [];
  Future<List<dynamic>> adminGetSubscriptionPlans() async => _list(await _dio.get('/plans'));
  Future<Map<String, dynamic>> adminCreateContent(Map<String, dynamic> data) async => _map(await _dio.post('/admin/contents', data: data));
  Future<Map<String, dynamic>> adminUpdateContent(String id, Map<String, dynamic> data) async => _map(await _dio.put('/admin/contents/$id', data: data));
  Future<void> adminUploadVideo(String contentId, String playerType, String? videoId, {FormData? formData}) =>
      formData != null
          ? _dio.post('/admin/contents/$contentId/video', data: formData)
          : _dio.post('/admin/contents/$contentId/video', data: {'playerType': playerType, 'videoId': videoId});
}

class _AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;
  final Dio _dio;
  bool _isRefreshing = false;
  final List<RequestOptions> _pendingRequests = [];

  _AuthInterceptor(this._storage, this._dio);

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
        final newToken = res.data['accessToken'] ?? (res.data['data']?['accessToken']);
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
