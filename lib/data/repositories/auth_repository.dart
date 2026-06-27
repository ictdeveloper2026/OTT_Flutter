import '../models/content.dart';
import '../../core/network/api_service.dart';

class AuthRepository {
  final ApiService _api;
  AuthRepository(this._api);

  Future<AuthResult> login({required String email, required String password}) async {
    final resp = await _api.login(email: email, password: password);
    await _api.saveSession(resp);
    return AuthResult.fromJson(resp);
  }

  Future<AuthResult> register({required String name, required String email, required String password, String? phone}) async {
    final resp = await _api.register(name: name, email: email, password: password, phone: phone);
    await _api.saveSession(resp);
    return AuthResult.fromJson(resp);
  }

  Future<UserProfile> socialLogin({required String provider, required String token}) async {
    final resp = await _api.socialLogin(provider: provider, token: token);
    await _api.saveSession(resp);
    return UserProfile.fromJson(resp['user']);
  }

  Future<UserProfile> verifyOtp({required String email, required String otp}) async {
    final resp = await _api.verifyOtp(email: email, otp: otp);
    await _api.saveSession(resp);
    return UserProfile.fromJson(resp['user']);
  }

  Future<void> forgotPassword({required String email}) async {
    await _api.forgotPassword(email: email);
  }

  Future<void> resetPassword({required String token, required String password}) async {
    await _api.resetPassword(token: token, password: password);
  }

  Future<void> logout() async {
    await _api.logout();
    await _api.clearSession();
  }

  Future<UserProfile?> getCurrentUser() async {
    try {
      final resp = await _api.getMe();
      return resp == null ? null : UserProfile.fromJson(resp);
    } catch (_) {
      return null;
    }
  }
}

class AuthResult {
  final UserProfile? user;
  final bool requiresOtp;
  AuthResult({this.user, this.requiresOtp = false});
  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      user: json['user'] != null ? UserProfile.fromJson(json['user']) : null,
      requiresOtp: json['requiresOtp'] ?? false,
    );
  }
}
