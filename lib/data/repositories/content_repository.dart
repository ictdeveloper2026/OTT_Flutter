import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/content.dart';
import '../models/stream_info.dart';
import '../../core/network/api_service.dart';

class ContentRepository {
  final ApiService _api;
  final Box? _cache; // optional Hive cache for offline-resilient catalog reads
  ContentRepository(this._api, [this._cache]);

  // Cache-aside: fetch from the API and cache the raw JSON; on failure (offline) fall back to the
  // last cached copy so the home catalog still renders instantly / offline.
  Future<List<T>> _cachedList<T>(String key, Future<List<dynamic>> Function() fetch, T Function(Map<String, dynamic>) parse) async {
    try {
      final raw = await fetch();
      await _cache?.put(key, jsonEncode(raw));
      return raw.map((e) => parse(Map<String, dynamic>.from(e))).toList();
    } catch (e) {
      final cached = _cache?.get(key);
      if (cached is String) {
        return (jsonDecode(cached) as List).map((e) => parse(Map<String, dynamic>.from(e))).toList();
      }
      rethrow;
    }
  }

  Future<List<Banner>> getBanners() => _cachedList('home_banners', _api.getBanners, Banner.fromJson);

  Future<List<ContentRow>> getContentRows() => _cachedList('home_rows', _api.getContentRows, ContentRow.fromJson);

  Future<List<Content>> getFeatured() => _cachedList('featured', _api.getFeatured, Content.fromJson);

  Future<PagedResult<Content>> search(String query, {String? genre, String? type, int page = 1}) async {
    final resp = await _api.search(query: query, genre: genre, type: type, page: page);
    return PagedResult<Content>.of(resp, (e) => Content.fromJson(e));
  }

  Future<Content> getContent(String contentId) async {
    final resp = await _api.getContent(contentId);
    return Content.fromJson(resp);
  }

  Future<List<Content>> getRelated(String contentId) async {
    final resp = await _api.getRelated(contentId);
    return resp.map((e) => Content.fromJson(e)).toList();
  }

  Future<StreamInfo> getStreamUrl({required String contentId, String? episodeId}) async {
    final resp = await _api.getStreamUrl(contentId: contentId, episodeId: episodeId);
    return StreamInfo.fromJson(resp);
  }

  Future<PagedResult<Content>> getByGenre(String genreSlug, {int page = 1}) async {
    final resp = await _api.getByGenre(genreSlug, page: page);
    return PagedResult<Content>.of(resp, (e) => Content.fromJson(e));
  }

  Future<void> addToWatchlist(String contentId) async {
    await _api.addToWatchlist(contentId);
  }

  Future<void> removeFromWatchlist(String contentId) async {
    await _api.removeFromWatchlist(contentId);
  }

  Future<void> rateContent(String contentId, double rating) async {
    await _api.rateContent(contentId, rating);
  }

  Future<void> updateProgress({
    required String contentId,
    String? episodeId,
    required int position,
    required int duration,
  }) async {
    await _api.updateWatchHistory(
      contentId: contentId,
      episodeId: episodeId,
      positionSeconds: position,
      durationSeconds: duration,
    );
  }

  Future<List<Content>> getContinueWatching() async {
    final resp = await _api.getContinueWatching();
    return resp.map((e) => Content.fromJson(e)).toList();
  }

  Future<List<Content>> getWatchlist() async {
    final resp = await _api.getWatchlist();
    return resp.map((e) => Content.fromJson(e)).toList();
  }
}
