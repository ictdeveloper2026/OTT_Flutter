part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;
  const SearchQueryChanged({required this.query});
  @override
  List<Object?> get props => [query];
}

class SearchSubmitted extends SearchEvent {
  final String query;
  final String? genre;
  final String? type;
  const SearchSubmitted({required this.query, this.genre, this.type});
  @override
  List<Object?> get props => [query, genre, type];
}

class SearchCleared extends SearchEvent {}

class SearchFilterChanged extends SearchEvent {
  final String? genre;
  final String? type;
  const SearchFilterChanged({this.genre, this.type});
  @override
  List<Object?> get props => [genre, type];
}

// STATES
abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final String query;
  const SearchLoading({required this.query});
  @override
  List<Object?> get props => [query];
}

class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});
  @override
  List<Object?> get props => [message];
}

class SearchLoaded extends SearchState {
  final String query;
  final List<Content> results;
  final bool hasMore;
  const SearchLoaded({required this.query, required this.results, required this.hasMore});
  @override
  List<Object?> get props => [query, results, hasMore];
}
