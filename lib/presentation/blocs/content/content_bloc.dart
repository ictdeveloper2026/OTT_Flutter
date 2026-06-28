import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../data/repositories/content_repository.dart';
import '../../../data/models/content.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final ContentRepository _repository;

  ContentBloc(this._repository) : super(ContentInitial()) {
    on<ContentHomeLoaded>(_onHomeLoaded);
    on<ContentDetailLoaded>(_onDetailLoaded);
    on<ContentGenreLoaded>(_onGenreLoaded);
    on<ContentWatchlistToggled>(_onWatchlistToggled);
    on<ContentRated>(_onRated);
    on<ContentProgressUpdated>(_onProgressUpdated);
    on<ContentRelatedLoaded>(_onRelatedLoaded);
  }

  Future<void> _onHomeLoaded(ContentHomeLoaded event, Emitter<ContentState> emit) async {
    emit(ContentLoading());
    try {
      final banners = await _repository.getBanners();
      final rows = await _repository.getContentRows();
      final featured = await _repository.getFeatured();
      emit(ContentHomeLoaded2(banners: banners, rows: rows, featured: featured));
    } catch (e) {
      emit(ContentError(message: friendlyError(e)));
    }
  }

  Future<void> _onDetailLoaded(ContentDetailLoaded event, Emitter<ContentState> emit) async {
    emit(ContentLoading());
    try {
      final content = await _repository.getContent(event.contentId);
      final related = await _repository.getRelated(event.contentId);
      emit(ContentDetailLoaded2(content: content, related: related));
    } catch (e) {
      emit(ContentError(message: friendlyError(e)));
    }
  }

  Future<void> _onGenreLoaded(ContentGenreLoaded event, Emitter<ContentState> emit) async {
    // Capture the list BEFORE emitting loading so load-more (page>1) keeps the list on
    // screen and appends, instead of flashing a spinner and replacing it.
    final prevState = state;
    if (event.page <= 1) emit(ContentLoading());
    try {
      final result = await _repository.getByGenre(event.genreSlug, page: event.page);
      if (prevState is ContentGenreLoaded2 && event.page > 1) {
        final prev = prevState;
        emit(ContentGenreLoaded2(
          genreName: prev.genreName,
          items: [...prev.items, ...result.data],
          hasMore: result.hasNextPage,
          page: event.page,
        ));
      } else {
        emit(ContentGenreLoaded2(
          genreName: event.genreSlug,
          items: result.data,
          hasMore: result.hasNextPage,
          page: event.page,
        ));
      }
    } catch (e) {
      emit(ContentError(message: friendlyError(e)));
    }
  }

  Future<void> _onWatchlistToggled(ContentWatchlistToggled event, Emitter<ContentState> emit) async {
    try {
      if (event.isAdding) {
        await _repository.addToWatchlist(event.contentId);
      } else {
        await _repository.removeFromWatchlist(event.contentId);
      }
    } catch (_) {}
  }

  Future<void> _onRated(ContentRated event, Emitter<ContentState> emit) async {
    try {
      await _repository.rateContent(event.contentId, event.rating);
    } catch (_) {}
  }

  Future<void> _onProgressUpdated(ContentProgressUpdated event, Emitter<ContentState> emit) async {
    try {
      await _repository.updateProgress(
        contentId: event.contentId,
        episodeId: event.episodeId,
        position: event.position,
        duration: event.duration,
      );
    } catch (_) {}
  }

  Future<void> _onRelatedLoaded(ContentRelatedLoaded event, Emitter<ContentState> emit) async {
    try {
      final related = await _repository.getRelated(event.contentId);
      if (state is ContentDetailLoaded2) {
        final prev = state as ContentDetailLoaded2;
        emit(prev.copyWith(related: related));
      }
    } catch (_) {}
  }
}
