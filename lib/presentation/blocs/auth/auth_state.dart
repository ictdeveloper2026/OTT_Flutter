part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthUnauthenticated extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserProfile user;
  const AuthAuthenticated({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthOtpRequired extends AuthState {
  final String email;
  const AuthOtpRequired({required this.email});
  @override
  List<Object?> get props => [email];
}

class AuthPasswordResetSent extends AuthState {
  final String email;
  const AuthPasswordResetSent({required this.email});
  @override
  List<Object?> get props => [email];
}

class AuthPasswordResetSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
  @override
  List<Object?> get props => [message];
}
