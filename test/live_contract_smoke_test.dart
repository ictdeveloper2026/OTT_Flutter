@Tags(['live'])
library;

// Live contract smoke test: hits the running API and runs each model's fromJson, so any
// JSON shape mismatch (the kind the analyzer can't catch) fails here with the offending field.
// Run with the API up:  flutter test test/live_contract_smoke_test.dart
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streamflix/data/models/content.dart';

void main() {
  const base = 'http://localhost:50664/api';
  const tenant = '11111111-1111-1111-1111-111111111111';
  late Dio dio;

  setUpAll(() async {
    dio = Dio(BaseOptions(baseUrl: base, headers: {'X-Tenant-ID': tenant}));
    final r = await dio.post('/auth/login', data: {'email': 'admin@ott.local', 'password': 'Admin@123'});
    dio.options.headers['Authorization'] = 'Bearer ${r.data['accessToken']}';
  });

  List _list(dynamic data) => (data is Map ? data['data'] : data) as List;
  Map<String, dynamic> _map(dynamic data) => Map<String, dynamic>.from(data is Map && data.containsKey('data') ? data['data'] : data);

  test('login: user + profiles parse', () async {
    final r = await dio.post('/auth/login', data: {'email': 'admin@ott.local', 'password': 'Admin@123'});
    UserProfile.fromJson(Map<String, dynamic>.from(r.data['user']));
    for (final p in (r.data['profiles'] as List)) {
      UserProfile.fromJson(Map<String, dynamic>.from(p));
    }
  });

  test('config: branding parses', () async {
    final r = await dio.get('/config/public');
    BrandingConfig.fromJson(_map(r.data['data']['branding']));
  });

  test('featured list parses', () async {
    final r = await dio.get('/contents/featured');
    for (final c in _list(r.data)) {
      Content.fromJson(Map<String, dynamic>.from(c));
    }
  });

  test('content detail parses (cast/seasons/watchProgress)', () async {
    final f = await dio.get('/contents/featured');
    final id = _list(f.data).first['id'];
    final r = await dio.get('/contents/$id');
    final c = Content.fromJson(_map(r.data));
    expect(c.id, id);
  });

  test('profiles parse', () async {
    final r = await dio.get('/profiles');
    for (final p in _list(r.data)) {
      UserProfile.fromJson(Map<String, dynamic>.from(p));
    }
  });

  test('plans parse', () async {
    final r = await dio.get('/plans');
    for (final p in _list(r.data)) {
      SubscriptionPlan.fromJson(Map<String, dynamic>.from(p));
    }
  });

  test('live streams parse', () async {
    final r = await dio.get('/live');
    for (final l in (_map(r.data)['items'] as List)) {
      LiveStream.fromJson(Map<String, dynamic>.from(l));
    }
  });
}
