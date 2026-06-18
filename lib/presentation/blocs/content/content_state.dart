part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();
  @override
  List<Object?> get props => [];
}

class ContentInitial extends ContentState {}
class ContentLoading extends ContentState {}

class ContentError extends ContentState {
  final String message;
  const ContentError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ContentHomeLoaded2 extends ContentState {
  final List<Banner> banners;
  final List<ContentRow> rows;
  final List<Content> featured;
  const ContentHomeLoaded2({required this.banners, required this.rows, required this.featured});
  @override
  List<Object?> get props => [banners, rows, featured];
}

class ContentDetailLoaded2 extends ContentState {
  final Content content;
  final List<Content> related;
  const ContentDetailLoaded2({required this.content, required this.related});

  ContentDetailLoaded2 copyWith({Content? content, List<Content>? related}) {
    return ContentDetailLoaded2(content: content ?? this.content, related: related ?? this.related);
  }

  @override
  List<Object?> get props => [content, related];
}

class ContentGenreLoaded2 extends ContentState {
  final String genreName;
  final List<Content> items;
  final bool hasMore;
  final int page;
  const ContentGenreLoaded2({required this.genreName, required this.items, required this.hasMore, required this.page});
  @override
  List<Object?> get props => [genreName, items, hasMore, page];
}
