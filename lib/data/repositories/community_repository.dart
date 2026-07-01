import '../models/community.dart';
import '../../core/network/api_service.dart';

/// Data access for the Community feature (suggestions + polls), user + admin.
class CommunityRepository {
  final ApiService _api;
  CommunityRepository(this._api);

  // ── User ──
  Future<List<Suggestion>> getSuggestions({String sort = 'top', String? status}) async {
    final raw = await _api.getSuggestions(sort: sort, status: status);
    return raw.map((e) => Suggestion.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<Suggestion> createSuggestion(String title, String? description) async =>
      Suggestion.fromJson(await _api.createSuggestion(title, description));

  Future<Suggestion> toggleUpvote(String id) async =>
      Suggestion.fromJson(await _api.toggleSuggestionUpvote(id));

  Future<List<Poll>> getPolls({String status = 'active'}) async {
    final raw = await _api.getPolls(status: status);
    return raw.map((e) => Poll.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<Poll> vote(String pollId, String optionId) async =>
      Poll.fromJson(await _api.votePoll(pollId, optionId));

  // ── Admin ──
  Future<List<Suggestion>> adminGetSuggestions({String? status}) async {
    final raw = await _api.adminGetSuggestions(status: status);
    return raw.map((e) => Suggestion.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> adminSetSuggestionStatus(String id, String status, {String? linkedContentId}) =>
      _api.adminUpdateSuggestionStatus(id, status, linkedContentId: linkedContentId);

  Future<void> adminDeleteSuggestion(String id) => _api.adminDeleteSuggestion(id);

  Future<Poll> adminPromoteSuggestion(String id, {String? question, List<String>? options, String? endsAt}) async =>
      Poll.fromJson(await _api.adminPromoteSuggestion(id, question: question, options: options, endsAt: endsAt));

  Future<Poll> adminCreatePoll({required String question, String? description, required List<String> options, String? endsAt}) async =>
      Poll.fromJson(await _api.adminCreatePoll(question: question, description: description, options: options, endsAt: endsAt));

  Future<void> adminUpdatePoll(String id, {String? question, String? status, String? endsAt}) =>
      _api.adminUpdatePoll(id, question: question, status: status, endsAt: endsAt);

  Future<void> adminDeletePoll(String id) => _api.adminDeletePoll(id);
}
