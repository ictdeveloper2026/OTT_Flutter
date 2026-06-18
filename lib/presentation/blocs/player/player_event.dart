part of 'player_bloc.dart';

// EVENTS
abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
  @override
  List<Object?> get props => [];
}

class PlayerInitialized extends PlayerEvent {
  final String contentId;
  final String? episodeId;
  final int startPosition;
  const PlayerInitialized({required this.contentId, this.episodeId, this.startPosition = 0});
  @override
  List<Object?> get props => [contentId, episodeId, startPosition];
}

class PlayerPlayed extends PlayerEvent {}
class PlayerPaused extends PlayerEvent {}

class PlayerSeeked extends PlayerEvent {
  final int position;
  const PlayerSeeked({required this.position});
  @override
  List<Object?> get props => [position];
}

class PlayerQualityChanged extends PlayerEvent {
  final String quality;
  const PlayerQualityChanged({required this.quality});
  @override
  List<Object?> get props => [quality];
}

class PlayerSubtitleChanged extends PlayerEvent {
  final String? subtitle;
  const PlayerSubtitleChanged({this.subtitle});
  @override
  List<Object?> get props => [subtitle];
}

class PlayerSpeedChanged extends PlayerEvent {
  final double speed;
  const PlayerSpeedChanged({required this.speed});
  @override
  List<Object?> get props => [speed];
}

class PlayerEpisodeChanged extends PlayerEvent {
  final String contentId;
  final String episodeId;
  const PlayerEpisodeChanged({required this.contentId, required this.episodeId});
  @override
  List<Object?> get props => [contentId, episodeId];
}

class PlayerProgressSynced extends PlayerEvent {
  final String contentId;
  final String? episodeId;
  final int position;
  final int duration;
  const PlayerProgressSynced({required this.contentId, this.episodeId, required this.position, required this.duration});
  @override
  List<Object?> get props => [contentId, episodeId, position, duration];
}

class PlayerFullscreenToggled extends PlayerEvent {
  final bool isFullscreen;
  const PlayerFullscreenToggled({required this.isFullscreen});
  @override
  List<Object?> get props => [isFullscreen];
}

class PlayerControlsToggled extends PlayerEvent {
  final bool show;
  const PlayerControlsToggled({required this.show});
  @override
  List<Object?> get props => [show];
}
