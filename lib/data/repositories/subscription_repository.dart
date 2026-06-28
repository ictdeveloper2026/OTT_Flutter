import '../models/content.dart';
import '../models/iptv_channel.dart';
import '../../core/network/api_service.dart';

class SubscriptionRepository {
  final ApiService _api;
  SubscriptionRepository(this._api);

  Future<List<SubscriptionPlan>> getPlans() async {
    final resp = await _api.getSubscriptionPlans();
    return resp.map((e) => SubscriptionPlan.fromJson(e)).toList();
  }

  Future<UserSubscription?> getCurrentSubscription() async {
    try {
      final resp = await _api.getMySubscription();
      return resp == null ? null : UserSubscription.fromJson(resp);
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> initiateSubscription({required String planId, String? promoCode}) async {
    return await _api.initiateSubscription(planId: planId, promoCode: promoCode);
  }

  Future<UserSubscription> confirmPayment({required String orderId, required String paymentId, required String signature}) async {
    final resp = await _api.confirmSubscription(orderId: orderId, paymentId: paymentId, signature: signature);
    return UserSubscription.fromJson(resp['subscription']);
  }

  Future<UserSubscription> verifyIap({required String productId, required String purchaseToken, required String platform}) async {
    final resp = await _api.verifyIap(productId: productId, purchaseToken: purchaseToken, platform: platform);
    return UserSubscription.fromJson(resp['subscription']);
  }

  Future<void> cancelSubscription() async {
    await _api.cancelSubscription();
  }

  Future<Map<String, dynamic>> validatePromo(String code, String planId) async {
    return await _api.validatePromo(code: code, planId: planId);
  }
}

class ProfileRepository {
  final ApiService _api;
  ProfileRepository(this._api);

  Future<List<UserProfile>> getProfiles() async {
    final resp = await _api.getProfiles();
    return resp.map((e) => UserProfile.fromJson(e)).toList();
  }

  Future<void> selectProfile(String profileId) async {
    await _api.selectProfile(profileId);
  }

  Future<void> createProfile({required String name, String? avatarUrl, bool isKid = false}) async {
    await _api.createProfile(name: name, avatarUrl: avatarUrl, isKid: isKid);
  }

  Future<void> updateProfile({required String profileId, String? name, String? avatarUrl}) async {
    await _api.updateProfile(profileId: profileId, name: name, avatarUrl: avatarUrl);
  }

  Future<void> deleteProfile(String profileId) async {
    await _api.deleteProfile(profileId);
  }

  Future<void> setPin({required String profileId, required String pin}) async {
    await _api.setProfilePin(profileId: profileId, pin: pin);
  }

  Future<bool> verifyPin({required String profileId, required String pin}) async {
    final resp = await _api.verifyProfilePin(profileId: profileId, pin: pin);
    return resp['valid'] ?? false;
  }
}

class LiveRepository {
  final ApiService _api;
  LiveRepository(this._api);

  Future<List<LiveStream>> getLiveStreams() async {
    final resp = await _api.getLiveStreams();
    return resp.map((e) => LiveStream.fromJson(e)).toList();
  }

  Future<LiveStream> getLiveStream(String streamId) async {
    final resp = await _api.getLiveStream(streamId);
    return LiveStream.fromJson(resp);
  }

  // ── Live TV (IPTV channels) ──
  Future<ChannelPage> getChannels({String? country, String? language, String? category, String? q, int page = 1}) async {
    final r = await _api.getLiveTvChannels(country: country, language: language, category: category, q: q, page: page);
    final items = ((r['items'] as List?) ?? const [])
        .map((e) => IptvChannel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
    return ChannelPage(
      items: items,
      total: (r['totalCount'] as num?)?.toInt() ?? items.length,
      page: (r['page'] as num?)?.toInt() ?? page,
    );
  }

  Future<ChannelFilters> getChannelFilters() async => ChannelFilters.fromJson(await _api.getLiveTvFilters());
}

class AdminRepository {
  final ApiService _api;
  AdminRepository(this._api);

  Future<Map<String, dynamic>> getDashboardStats() async {
    return await _api.getAdminStats();
  }

  Future<PagedResult<Content>> getContents({int page = 1, String? search}) async {
    final resp = await _api.adminGetContents(page: page, search: search);
    return PagedResult<Content>.of(resp, (e) => Content.fromJson(e));
  }

  Future<PagedResult<UserProfile>> getUsers({int page = 1, String? search}) async {
    final resp = await _api.adminGetUsers(page: page, search: search);
    return PagedResult<UserProfile>.of(resp, (e) => UserProfile.fromJson(e));
  }

  Future<List<LiveStream>> getLiveStreams() async {
    final resp = await _api.adminGetLiveStreams();
    return resp.map((e) => LiveStream.fromJson(e)).toList();
  }

  Future<String> syncLiveTv() async => _api.adminSyncLiveTv();

  Future<List<dynamic>> getAnalytics({String period = '30d'}) async => _api.getAdminAnalytics(period: period);

  Future<List<SubscriptionPlan>> getSubscriptionPlans() async {
    final resp = await _api.adminGetSubscriptionPlans();
    return resp.map((e) => SubscriptionPlan.fromJson(e)).toList();
  }

  Future<void> deleteContent(String contentId) async {
    await _api.adminDeleteContent(contentId);
  }

  Future<void> toggleContent(String contentId, bool isActive) async {
    await _api.adminToggleContent(contentId, isActive);
  }

  Future<void> changeUserStatus(String userId, String status) async {
    await _api.adminChangeUserStatus(userId, status);
  }
}
