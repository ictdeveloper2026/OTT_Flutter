import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/live_repository.dart';
import '../../../data/models/content.dart';

part 'live_event.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  final LiveRepository _repository;

  LiveBloc(this._repository) : super(LiveInitial()) {
    on<LiveStreamsLoaded>(_onLoaded);
    on<LiveStreamSelected>(_onSelected);
    on<LiveStreamRefreshed>(_onRefreshed);
  }

  Future<void> _onLoaded(LiveStreamsLoaded event, Emitter<LiveState> emit) async {
    emit(LiveLoading());
    try {
      final streams = await _repository.getLiveStreams();
      emit(LiveStreamsReady(streams: streams));
    } catch (e) {
      emit(LiveError(message: e.toString()));
    }
  }

  Future<void> _onSelected(LiveStreamSelected event, Emitter<LiveState> emit) async {
    emit(LiveLoading());
    try {
      final stream = await _repository.getLiveStream(event.streamId);
      emit(LiveStreamActive(stream: stream));
    } catch (e) {
      emit(LiveError(message: e.toString()));
    }
  }

  Future<void> _onRefreshed(LiveStreamRefreshed event, Emitter<LiveState> emit) async {
    try {
      final streams = await _repository.getLiveStreams();
      emit(LiveStreamsReady(streams: streams));
    } catch (_) {}
  }
}
