import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../data/repositories/content_repository.dart';
import '../../../data/models/content.dart';
import '../../../data/models/stream_info.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final ContentRepository _repository;

  PlayerBloc(this._repository) : super(PlayerInitial()) {
    on<PlayerInitialized>(_onInit);
    on<PlayerPlayed>(_onPlay);
    on<PlayerPaused>(_onPause);
    on<PlayerSeeked>(_onSeek);
    on<PlayerQualityChanged>(_onQualityChanged);
    on<PlayerSubtitleChanged>(_onSubtitleChanged);
    on<PlayerSpeedChanged>(_onSpeedChanged);
    on<PlayerEpisodeChanged>(_onEpisodeChanged);
    on<PlayerProgressSynced>(_onProgressSync);
    on<PlayerFullscreenToggled>(_onFullscreen);
    on<PlayerControlsToggled>(_onControlsToggle);
  }

  Future<void> _onInit(PlayerInitialized event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading());
    try {
      final streamInfo = await _repository.getStreamUrl(
        contentId: event.contentId,
        episodeId: event.episodeId,
      );
      final content = await _repository.getContent(event.contentId);
      emit(PlayerReady(
        content: content,
        streamInfo: streamInfo,
        position: event.startPosition,
        episodeId: event.episodeId,
      ));
    } catch (e) {
      emit(PlayerError(message: friendlyError(e)));
    }
  }

  void _onPlay(PlayerPlayed event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(isPlaying: true));
    }
  }

  void _onPause(PlayerPaused event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(isPlaying: false));
    }
  }

  void _onSeek(PlayerSeeked event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(position: event.position));
    }
  }

  void _onQualityChanged(PlayerQualityChanged event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(selectedQuality: event.quality));
    }
  }

  void _onSubtitleChanged(PlayerSubtitleChanged event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(selectedSubtitle: event.subtitle));
    }
  }

  void _onSpeedChanged(PlayerSpeedChanged event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(playbackSpeed: event.speed));
    }
  }

  Future<void> _onEpisodeChanged(PlayerEpisodeChanged event, Emitter<PlayerState> emit) async {
    emit(PlayerLoading());
    try {
      final streamInfo = await _repository.getStreamUrl(
        contentId: event.contentId,
        episodeId: event.episodeId,
      );
      final content = await _repository.getContent(event.contentId);
      emit(PlayerReady(content: content, streamInfo: streamInfo, episodeId: event.episodeId));
    } catch (e) {
      emit(PlayerError(message: friendlyError(e)));
    }
  }

  Future<void> _onProgressSync(PlayerProgressSynced event, Emitter<PlayerState> emit) async {
    try {
      await _repository.updateProgress(
        contentId: event.contentId,
        episodeId: event.episodeId,
        position: event.position,
        duration: event.duration,
      );
    } catch (_) {}
  }

  void _onFullscreen(PlayerFullscreenToggled event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(isFullscreen: event.isFullscreen));
    }
  }

  void _onControlsToggle(PlayerControlsToggled event, Emitter<PlayerState> emit) {
    if (state is PlayerReady) {
      emit((state as PlayerReady).copyWith(showControls: event.show));
    }
  }
}
