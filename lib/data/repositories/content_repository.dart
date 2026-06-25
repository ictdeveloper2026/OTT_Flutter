import '../models/content.dart';
import '../models/stream_info.dart';
import '../../core/network/api_service.dart';

class ContentRepository {
  final ApiService _api;
  ContentRepository(this._api);

  Future<List<Banner>> getBanners() async {
    final resp = await _api.getBanners();
    return resp.map((e) => Banner.fromJson(e)).toList();
  }

  Future<List<ContentRow>> getContentRows() async {
    final resp = await _api.getContentRows();
    return resp.map((e) => ContentRow.fromJson(e)).toList();
  }

  Future<List<Content>> getFeatured() async {
    final resp = await _api.getFeatured();
    return resp.map((e) => Content.fromJson(e)).toList();
  }

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
