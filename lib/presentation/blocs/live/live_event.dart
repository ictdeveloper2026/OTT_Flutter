part of 'live_bloc.dart';

abstract class LiveEvent extends Equatable {
  const LiveEvent();
  @override
  List<Object?> get props => [];
}

class LiveStreamsLoaded extends LiveEvent {}
class LiveStreamRefreshed extends LiveEvent {}

class LiveStreamSelected extends LiveEvent {
  final String streamId;
  const LiveStreamSelected({required this.streamId});
  @override
  List<Object?> get props => [streamId];
}

abstract class LiveState extends Equatable {
  const LiveState();
  @override
  List<Object?> get props => [];
}

class LiveInitial extends LiveState {}
class LiveLoading extends LiveState {}

class LiveError extends LiveState {
  final String message;
  const LiveError({required this.message});
  @override
  List<Object?> get props => [message];
}

class LiveStreamsReady extends LiveState {
  final List<LiveStream> streams;
  const LiveStreamsReady({required this.streams});
  @override
  List<Object?> get props => [streams];
}

class LiveStreamActive extends LiveState {
  final LiveStream stream;
  const LiveStreamActive({required this.stream});
  @override
  List<Object?> get props => [stream];
}
