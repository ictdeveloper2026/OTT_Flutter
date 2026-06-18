part of 'profile_bloc.dart';

// EVENTS
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ProfilesLoaded extends ProfileEvent {}

class ProfileSelected extends ProfileEvent {
  final String profileId;
  const ProfileSelected({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}

class ProfileCreated extends ProfileEvent {
  final String name;
  final String? avatarUrl;
  final bool isKid;
  const ProfileCreated({required this.name, this.avatarUrl, this.isKid = false});
  @override
  List<Object?> get props => [name, avatarUrl, isKid];
}

class ProfileUpdated extends ProfileEvent {
  final String profileId;
  final String? name;
  final String? avatarUrl;
  const ProfileUpdated({required this.profileId, this.name, this.avatarUrl});
  @override
  List<Object?> get props => [profileId, name, avatarUrl];
}

class ProfileDeleted extends ProfileEvent {
  final String profileId;
  const ProfileDeleted({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}

class ProfilePinSet extends ProfileEvent {
  final String profileId;
  final String pin;
  const ProfilePinSet({required this.profileId, required this.pin});
  @override
  List<Object?> get props => [profileId, pin];
}

class ProfilePinVerified extends ProfileEvent {
  final String profileId;
  final String pin;
  const ProfilePinVerified({required this.profileId, required this.pin});
  @override
  List<Object?> get props => [profileId, pin];
}

// STATES
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}

class ProfileListLoaded extends ProfileState {
  final List<UserProfile> profiles;
  const ProfileListLoaded({required this.profiles});
  @override
  List<Object?> get props => [profiles];
}

class ProfileActive extends ProfileState {
  final String profileId;
  const ProfileActive({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});
  @override
  List<Object?> get props => [message];
}
