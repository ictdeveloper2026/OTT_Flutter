import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/content_repository.dart';
import '../../../data/models/content.dart';
import '../../../core/constants/app_constants.dart';
import 'dart:async';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ContentRepository _repository;
  Timer? _debounce;

  SearchBloc(this._repository) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onQueryChanged);
    on<SearchSubmitted>(_onSubmitted);
    on<SearchCleared>(_onCleared);
    on<SearchFilterChanged>(_onFilterChanged);
  }

  Future<void> _onQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) async {
    _debounce?.cancel();
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading(query: event.query));
    _debounce = Timer(const Duration(milliseconds: AppConstants.searchDebounce), () {
      add(SearchSubmitted(query: event.query));
    });
  }

  Future<void> _onSubmitted(SearchSubmitted event, Emitter<SearchState> emit) async {
    emit(SearchLoading(query: event.query));
    try {
      final result = await _repository.search(event.query, genre: event.genre, type: event.type);
      emit(SearchLoaded(query: event.query, results: result.data, hasMore: result.hasNextPage));
    } catch (e) {
      emit(SearchError(message: e.toString()));
    }
  }

  void _onCleared(SearchCleared event, Emitter<SearchState> emit) {
    _debounce?.cancel();
    emit(SearchInitial());
  }

  Future<void> _onFilterChanged(SearchFilterChanged event, Emitter<SearchState> emit) async {
    if (state is SearchLoaded) {
      final prev = state as SearchLoaded;
      add(SearchSubmitted(query: prev.query, genre: event.genre, type: event.type));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
