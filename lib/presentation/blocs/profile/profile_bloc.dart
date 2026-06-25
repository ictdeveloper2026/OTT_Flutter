import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../data/models/content.dart';

part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<ProfilesLoaded>(_onLoaded);
    on<ProfileSelected>(_onSelected);
    on<ProfileCreated>(_onCreated);
    on<ProfileUpdated>(_onUpdated);
    on<ProfileDeleted>(_onDeleted);
    on<ProfilePinSet>(_onPinSet);
    on<ProfilePinVerified>(_onPinVerified);
  }

  Future<void> _onLoaded(ProfilesLoaded event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profiles = await _repository.getProfiles();
      emit(ProfileListLoaded(profiles: profiles));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onSelected(ProfileSelected event, Emitter<ProfileState> emit) async {
    try {
      await _repository.selectProfile(event.profileId);
      emit(ProfileActive(profileId: event.profileId));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onCreated(ProfileCreated event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await _repository.createProfile(name: event.name, avatarUrl: event.avatarUrl, isKid: event.isKid);
      final profiles = await _repository.getProfiles();
      emit(ProfileListLoaded(profiles: profiles));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onUpdated(ProfileUpdated event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await _repository.updateProfile(profileId: event.profileId, name: event.name, avatarUrl: event.avatarUrl);
      final profiles = await _repository.getProfiles();
      emit(ProfileListLoaded(profiles: profiles));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onDeleted(ProfileDeleted event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await _repository.deleteProfile(event.profileId);
      final profiles = await _repository.getProfiles();
      emit(ProfileListLoaded(profiles: profiles));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onPinSet(ProfilePinSet event, Emitter<ProfileState> emit) async {
    try {
      await _repository.setPin(profileId: event.profileId, pin: event.pin);
    } catch (_) {}
  }

  Future<void> _onPinVerified(ProfilePinVerified event, Emitter<ProfileState> emit) async {
    try {
      final valid = await _repository.verifyPin(profileId: event.profileId, pin: event.pin);
      if (valid) {
        emit(ProfileActive(profileId: event.profileId));
      } else {
        emit(ProfileError(message: 'Invalid PIN'));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
