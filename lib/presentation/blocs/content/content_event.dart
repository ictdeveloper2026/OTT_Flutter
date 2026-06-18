part of 'content_bloc.dart';

// EVENTS
abstract class ContentEvent extends Equatable {
  const ContentEvent();
  @override
  List<Object?> get props => [];
}

class ContentHomeLoaded extends ContentEvent {}

class ContentDetailLoaded extends ContentEvent {
  final String contentId;
  const ContentDetailLoaded({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

class ContentGenreLoaded extends ContentEvent {
  final String genreSlug;
  final int page;
  const ContentGenreLoaded({required this.genreSlug, this.page = 1});
  @override
  List<Object?> get props => [genreSlug, page];
}

class ContentWatchlistToggled extends ContentEvent {
  final String contentId;
  final bool isAdding;
  const ContentWatchlistToggled({required this.contentId, required this.isAdding});
  @override
  List<Object?> get props => [contentId, isAdding];
}

class ContentRated extends ContentEvent {
  final String contentId;
  final double rating;
  const ContentRated({required this.contentId, required this.rating});
  @override
  List<Object?> get props => [contentId, rating];
}

class ContentProgressUpdated extends ContentEvent {
  final String contentId;
  final String? episodeId;
  final int position;
  final int duration;
  const ContentProgressUpdated({required this.contentId, this.episodeId, required this.position, required this.duration});
  @override
  List<Object?> get props => [contentId, episodeId, position, duration];
}

class ContentRelatedLoaded extends ContentEvent {
  final String contentId;
  const ContentRelatedLoaded({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}
