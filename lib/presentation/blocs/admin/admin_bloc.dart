import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/admin_repository.dart';
import '../../../data/models/content.dart';

part 'admin_event.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _repository;

  AdminBloc(this._repository) : super(AdminInitial()) {
    on<AdminDashboardLoaded>(_onDashboard);
    on<AdminContentListLoaded>(_onContentList);
    on<AdminUsersLoaded>(_onUsers);
    on<AdminLiveStreamsLoaded>(_onLive);
    on<AdminAnalyticsLoaded>(_onAnalytics);
    on<AdminSubscriptionPlansLoaded>(_onPlans);
    on<AdminContentDeleted>(_onDelete);
    on<AdminContentToggled>(_onToggle);
    on<AdminUserStatusChanged>(_onUserStatus);
  }

  Future<void> _onDashboard(AdminDashboardLoaded event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final stats = await _repository.getDashboardStats();
      emit(AdminDashboardReady(stats: stats));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onContentList(AdminContentListLoaded event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final result = await _repository.getContents(page: event.page, search: event.search);
      emit(AdminContentListReady(contents: result.data, hasMore: result.hasNextPage, page: event.page));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onUsers(AdminUsersLoaded event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final result = await _repository.getUsers(page: event.page, search: event.search);
      emit(AdminUsersReady(users: result.data, hasMore: result.hasNextPage));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onLive(AdminLiveStreamsLoaded event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final streams = await _repository.getLiveStreams();
      emit(AdminLiveStreamsReady(streams: streams));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onAnalytics(AdminAnalyticsLoaded event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final analytics = await _repository.getAnalytics(period: event.period);
      emit(AdminAnalyticsReady(data: analytics));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onPlans(AdminSubscriptionPlansLoaded event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final plans = await _repository.getSubscriptionPlans();
      emit(AdminPlansReady(plans: plans));
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onDelete(AdminContentDeleted event, Emitter<AdminState> emit) async {
    try {
      await _repository.deleteContent(event.contentId);
      add(AdminContentListLoaded());
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onToggle(AdminContentToggled event, Emitter<AdminState> emit) async {
    try {
      await _repository.toggleContent(event.contentId, event.isActive);
      add(AdminContentListLoaded());
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }

  Future<void> _onUserStatus(AdminUserStatusChanged event, Emitter<AdminState> emit) async {
    try {
      await _repository.changeUserStatus(event.userId, event.status);
      add(AdminUsersLoaded());
    } catch (e) {
      emit(AdminError(message: e.toString()));
    }
  }
}
