import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/models/content.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthSocialLoginRequested>(_onSocialLogin);
    on<AuthOtpVerifyRequested>(_onOtpVerify);
    on<AuthForgotPasswordRequested>(_onForgotPassword);
    on<AuthResetPasswordRequested>(_onResetPassword);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthRefreshRequested>(_onRefresh);
  }

  Future<void> _onCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authRepository.login(email: event.email, password: event.password);
      if (result.requiresOtp) {
        emit(AuthOtpRequired(email: event.email));
      } else {
        emit(AuthAuthenticated(user: result.user!));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
      );
      if (result.requiresOtp) {
        emit(AuthOtpRequired(email: event.email));
      } else {
        emit(AuthAuthenticated(user: result.user!));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSocialLogin(AuthSocialLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.socialLogin(
        provider: event.provider,
        token: event.token,
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onOtpVerify(AuthOtpVerifyRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.verifyOtp(email: event.email, otp: event.otp);
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onForgotPassword(AuthForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.forgotPassword(email: event.email);
      emit(AuthPasswordResetSent(email: event.email));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onResetPassword(AuthResetPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.resetPassword(token: event.token, password: event.password);
      emit(AuthPasswordResetSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onRefresh(AuthRefreshRequested event, Emitter<AuthState> emit) async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) emit(AuthAuthenticated(user: user));
    } catch (_) {}
  }
}
