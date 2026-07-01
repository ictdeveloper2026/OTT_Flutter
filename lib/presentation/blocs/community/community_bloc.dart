import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../data/models/community.dart';
import '../../../data/repositories/community_repository.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final CommunityRepository _repo;

  CommunityBloc(this._repo) : super(CommunityInitial()) {
    on<CommunityLoadRequested>(_onLoad);
    on<CommunitySortChanged>(_onSortChanged);
    on<SuggestionSubmitted>(_onSubmit);
    on<SuggestionUpvoteToggled>(_onUpvote);
    on<PollVoted>(_onVote);
  }

  CommunityLoaded get _loaded => state as CommunityLoaded;

  Future<void> _load(Emitter<CommunityState> emit, String sort) async {
    emit(CommunityLoading());
    try {
      final results = await Future.wait([
        _repo.getSuggestions(sort: sort),
        _repo.getPolls(status: 'active'),
      ]);
      emit(CommunityLoaded(
        suggestions: results[0] as List<Suggestion>,
        polls: results[1] as List<Poll>,
        sort: sort,
      ));
    } catch (e) {
      emit(CommunityError(friendlyError(e)));
    }
  }

  Future<void> _onLoad(CommunityLoadRequested e, Emitter<CommunityState> emit) => _load(emit, 'top');

  Future<void> _onSortChanged(CommunitySortChanged e, Emitter<CommunityState> emit) => _load(emit, e.sort);

  Future<void> _onSubmit(SuggestionSubmitted e, Emitter<CommunityState> emit) async {
    if (state is! CommunityLoaded) return;
    try {
      final created = await _repo.createSuggestion(e.title, e.description);
      emit(_loaded.copyWith(suggestions: [created, ..._loaded.suggestions], clearError: true));
    } catch (err) {
      emit(_loaded.copyWith(actionError: friendlyError(err)));
    }
  }

  Future<void> _onUpvote(SuggestionUpvoteToggled e, Emitter<CommunityState> emit) async {
    if (state is! CommunityLoaded) return;
    try {
      final updated = await _repo.toggleUpvote(e.id);
      emit(_loaded.copyWith(
        suggestions: [for (final s in _loaded.suggestions) if (s.id == updated.id) updated else s],
        clearError: true,
      ));
    } catch (err) {
      emit(_loaded.copyWith(actionError: friendlyError(err)));
    }
  }

  Future<void> _onVote(PollVoted e, Emitter<CommunityState> emit) async {
    if (state is! CommunityLoaded) return;
    try {
      final updated = await _repo.vote(e.pollId, e.optionId);
      emit(_loaded.copyWith(
        polls: [for (final p in _loaded.polls) if (p.id == updated.id) updated else p],
        clearError: true,
      ));
    } catch (err) {
      emit(_loaded.copyWith(actionError: friendlyError(err)));
    }
  }
}
