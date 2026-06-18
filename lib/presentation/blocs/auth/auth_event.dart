part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String? phone;
  const AuthRegisterRequested({required this.name, required this.email, required this.password, this.phone});
  @override
  List<Object?> get props => [name, email, password, phone];
}

class AuthSocialLoginRequested extends AuthEvent {
  final String provider;
  final String token;
  const AuthSocialLoginRequested({required this.provider, required this.token});
  @override
  List<Object?> get props => [provider, token];
}

class AuthOtpVerifyRequested extends AuthEvent {
  final String email;
  final String otp;
  const AuthOtpVerifyRequested({required this.email, required this.otp});
  @override
  List<Object?> get props => [email, otp];
}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;
  const AuthForgotPasswordRequested({required this.email});
  @override
  List<Object?> get props => [email];
}

class AuthResetPasswordRequested extends AuthEvent {
  final String token;
  final String password;
  const AuthResetPasswordRequested({required this.token, required this.password});
  @override
  List<Object?> get props => [token, password];
}

class AuthLogoutRequested extends AuthEvent {}
class AuthRefreshRequested extends AuthEvent {}
