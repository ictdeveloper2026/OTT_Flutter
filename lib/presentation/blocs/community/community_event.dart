part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();
  @override
  List<Object?> get props => [];
}

class CommunityLoadRequested extends CommunityEvent {}

class CommunitySortChanged extends CommunityEvent {
  final String sort; // top | new
  const CommunitySortChanged(this.sort);
  @override
  List<Object?> get props => [sort];
}

class SuggestionSubmitted extends CommunityEvent {
  final String title;
  final String? description;
  const SuggestionSubmitted({required this.title, this.description});
  @override
  List<Object?> get props => [title, description];
}

class SuggestionUpvoteToggled extends CommunityEvent {
  final String id;
  const SuggestionUpvoteToggled(this.id);
  @override
  List<Object?> get props => [id];
}

class PollVoted extends CommunityEvent {
  final String pollId;
  final String optionId;
  const PollVoted({required this.pollId, required this.optionId});
  @override
  List<Object?> get props => [pollId, optionId];
}
