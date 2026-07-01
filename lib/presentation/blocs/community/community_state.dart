part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();
  @override
  List<Object?> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityError extends CommunityState {
  final String message;
  const CommunityError(this.message);
  @override
  List<Object?> get props => [message];
}

class CommunityLoaded extends CommunityState {
  final List<Suggestion> suggestions;
  final List<Poll> polls;
  final String sort; // top | new
  final String? actionError; // transient error from an upvote/vote/submit

  const CommunityLoaded({
    required this.suggestions,
    required this.polls,
    this.sort = 'top',
    this.actionError,
  });

  CommunityLoaded copyWith({
    List<Suggestion>? suggestions,
    List<Poll>? polls,
    String? sort,
    String? actionError,
    bool clearError = false,
  }) =>
      CommunityLoaded(
        suggestions: suggestions ?? this.suggestions,
        polls: polls ?? this.polls,
        sort: sort ?? this.sort,
        actionError: clearError ? null : (actionError ?? this.actionError),
      );

  @override
  List<Object?> get props => [suggestions, polls, sort, actionError];
}
