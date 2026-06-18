part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
  @override
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {}
class PlayerLoading extends PlayerState {}

class PlayerError extends PlayerState {
  final String message;
  const PlayerError({required this.message});
  @override
  List<Object?> get props => [message];
}

class PlayerReady extends PlayerState {
  final Content content;
  final StreamInfo streamInfo;
  final String? episodeId;
  final int position;
  final int duration;
  final bool isPlaying;
  final bool isFullscreen;
  final bool showControls;
  final String? selectedQuality;
  final String? selectedSubtitle;
  final double playbackSpeed;

  const PlayerReady({
    required this.content,
    required this.streamInfo,
    this.episodeId,
    this.position = 0,
    this.duration = 0,
    this.isPlaying = true,
    this.isFullscreen = false,
    this.showControls = true,
    this.selectedQuality,
    this.selectedSubtitle,
    this.playbackSpeed = 1.0,
  });

  PlayerReady copyWith({
    Content? content,
    StreamInfo? streamInfo,
    String? episodeId,
    int? position,
    int? duration,
    bool? isPlaying,
    bool? isFullscreen,
    bool? showControls,
    String? selectedQuality,
    String? selectedSubtitle,
    double? playbackSpeed,
  }) {
    return PlayerReady(
      content: content ?? this.content,
      streamInfo: streamInfo ?? this.streamInfo,
      episodeId: episodeId ?? this.episodeId,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      isFullscreen: isFullscreen ?? this.isFullscreen,
      showControls: showControls ?? this.showControls,
      selectedQuality: selectedQuality ?? this.selectedQuality,
      selectedSubtitle: selectedSubtitle ?? this.selectedSubtitle,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
    );
  }

  @override
  List<Object?> get props => [content, streamInfo, episodeId, position, duration, isPlaying, isFullscreen, showControls, selectedQuality, selectedSubtitle, playbackSpeed];
}
