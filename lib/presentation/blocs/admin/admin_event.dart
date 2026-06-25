part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
  @override
  List<Object?> get props => [];
}

class AdminDashboardLoaded extends AdminEvent {}
class AdminLiveStreamsLoaded extends AdminEvent {}

class AdminContentListLoaded extends AdminEvent {
  final int page;
  final String? search;
  const AdminContentListLoaded({this.page = 1, this.search});
  @override
  List<Object?> get props => [page, search];
}

class AdminUsersLoaded extends AdminEvent {
  final int page;
  final String? search;
  const AdminUsersLoaded({this.page = 1, this.search});
  @override
  List<Object?> get props => [page, search];
}

class AdminAnalyticsLoaded extends AdminEvent {
  final String period;
  const AdminAnalyticsLoaded({this.period = '30d'});
  @override
  List<Object?> get props => [period];
}

class AdminSubscriptionPlansLoaded extends AdminEvent {}

class AdminContentDeleted extends AdminEvent {
  final String contentId;
  const AdminContentDeleted({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

class AdminContentToggled extends AdminEvent {
  final String contentId;
  final bool isActive;
  const AdminContentToggled({required this.contentId, required this.isActive});
  @override
  List<Object?> get props => [contentId, isActive];
}

class AdminUserStatusChanged extends AdminEvent {
  final String userId;
  final String status;
  const AdminUserStatusChanged({required this.userId, required this.status});
  @override
  List<Object?> get props => [userId, status];
}

// STATES
abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}
class AdminLoading extends AdminState {}

class AdminError extends AdminState {
  final String message;
  const AdminError({required this.message});
  @override
  List<Object?> get props => [message];
}

class AdminDashboardReady extends AdminState {
  final Map<String, dynamic> stats;
  const AdminDashboardReady({required this.stats});
  @override
  List<Object?> get props => [stats];
}

class AdminContentListReady extends AdminState {
  final List<Content> contents;
  final bool hasMore;
  final int page;
  const AdminContentListReady({required this.contents, required this.hasMore, required this.page});
  @override
  List<Object?> get props => [contents, hasMore, page];
}

class AdminUsersReady extends AdminState {
  final List<UserProfile> users;
  final bool hasMore;
  const AdminUsersReady({required this.users, required this.hasMore});
  @override
  List<Object?> get props => [users, hasMore];
}

class AdminLiveStreamsReady extends AdminState {
  final List<LiveStream> streams;
  const AdminLiveStreamsReady({required this.streams});
  @override
  List<Object?> get props => [streams];
}

class AdminAnalyticsReady extends AdminState {
  final List<dynamic> data;
  const AdminAnalyticsReady({required this.data});
  @override
  List<Object?> get props => [data];
}

class AdminPlansReady extends AdminState {
  final List<SubscriptionPlan> plans;
  const AdminPlansReady({required this.plans});
  @override
  List<Object?> get props => [plans];
}
