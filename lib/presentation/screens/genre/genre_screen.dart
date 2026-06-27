import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../blocs/content/content_bloc.dart';
import '../../widgets/shared_widgets.dart';

class GenreScreen extends StatefulWidget {
  final String genreId;
  final String genreName;
  const GenreScreen({super.key, required this.genreId, required this.genreName});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final _scrollController = ScrollController();
  String _sortBy = 'views';

  @override
  void initState() {
    super.initState();
    _loadContent();
    _scrollController.addListener(_onScroll);
  }

  void _loadContent() {
    context.read<ContentBloc>().add(ContentGenreLoaded(
      genreSlug: widget.genreId,
      page: 1,
    ));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 400) {
      final state = context.read<ContentBloc>().state;
      if (state is ContentGenreLoaded2 && state.hasMore) {
        context.read<ContentBloc>().add(ContentGenreLoaded(genreSlug: widget.genreId, page: state.page + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(colors),
          _buildFilters(colors),
          _buildContentGrid(colors),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(OttColors colors) {
    return SliverAppBar(
      expandedHeight: 160,
      floating: false,
      pinned: true,
      backgroundColor: colors.surface,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colors.textPrimary),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.genreName, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colors.primary.withOpacity(0.4), colors.surface],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters(OttColors colors) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Row(
          children: [
            BlocBuilder<ContentBloc, ContentState>(
              builder: (context, state) {
                int count = 0;
                if (state is ContentGenreLoaded2) count = state.items.length;
                return Text('$count titles', style: TextStyle(color: colors.textSecondary, fontSize: 13));
              },
            ),
            const Spacer(),
            _buildSortDropdown(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown(OttColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          dropdownColor: colors.surface,
          style: TextStyle(color: colors.textPrimary, fontSize: 13),
          isDense: true,
          icon: Icon(Icons.sort, color: colors.textSecondary, size: 16),
          items: const [
            DropdownMenuItem(value: 'views', child: Text('Most Watched')),
            DropdownMenuItem(value: 'rating', child: Text('Top Rated')),
            DropdownMenuItem(value: 'newest', child: Text('Newest')),
            DropdownMenuItem(value: 'az', child: Text('A - Z')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _sortBy = value);
              context.read<ContentBloc>().add(ContentGenreLoaded(
                genreSlug: widget.genreId,
                page: 1,
              ));
            }
          },
        ),
      ),
    );
  }

  Widget _buildContentGrid(OttColors colors) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoading) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator(color: colors.primary)),
          );
        }

        if (state is ContentError) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: colors.textSecondary, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message, style: TextStyle(color: colors.textSecondary)),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: _loadContent, child: const Text('Retry')),
                ],
              ),
            ),
          );
        }

        if (state is ContentGenreLoaded2) {
          if (state.items.isEmpty) {
            return SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.movie_filter_outlined, color: colors.textSecondary, size: 64),
                    const SizedBox(height: 16),
                    Text('No content found', style: TextStyle(color: colors.textSecondary, fontSize: 16)),
                  ],
                ),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 900 ? 5 :
                               MediaQuery.of(context).size.width > 600 ? 4 : 3,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == state.items.length) {
                    return false
                        ? Center(child: CircularProgressIndicator(color: colors.primary, strokeWidth: 2))
                        : const SizedBox.shrink();
                  }
                  return ContentCard(content: state.items[index]);
                },
                childCount: state.items.length + (false ? 1 : 0),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
