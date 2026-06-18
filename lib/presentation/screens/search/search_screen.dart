import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../presentation/blocs/search/search_bloc.dart';
import '../../../data/models/content.dart';
import '../../../core/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchCtrl,
          focusNode: _focusNode,
          onChanged: (v) => context.read<SearchBloc>().add(SearchQueryChanged(query: v)),
          decoration: InputDecoration(
            hintText: 'Search movies, shows...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: ott.textSecondary),
          ),
          style: theme.textTheme.bodyLarge,
        ),
        actions: [
          BlocBuilder<SearchBloc, SearchState>(
            builder: (_, state) => state is SearchInitial
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchCtrl.clear();
                      context.read<SearchBloc>().add(SearchCleared());
                    },
                  ),
          ),
        ],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) return _buildSuggestions(context, theme, ott);
          if (state is SearchLoading) return _buildShimmer(context);
          if (state is SearchLoaded) return _buildResults(context, state.results, theme, ott);
          if (state is SearchError) return Center(child: Text(state.message));
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context, ThemeData theme, OttColors ott) {
    final genres = ['Action', 'Comedy', 'Drama', 'Horror', 'Romance', 'Sci-Fi', 'Thriller', 'Documentary'];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Browse by Genre', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2.5),
            itemCount: genres.length,
            itemBuilder: (ctx, i) {
              final colors = [Colors.blue, Colors.red, Colors.purple, Colors.green, Colors.pink, Colors.indigo, Colors.orange, Colors.teal];
              return GestureDetector(
                onTap: () => context.go('/genre/${genres[i].toLowerCase()}'),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors[i % colors.length].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colors[i % colors.length].withOpacity(0.4)),
                  ),
                  child: Center(
                    child: Text(genres[i], style: TextStyle(color: colors[i % colors.length], fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.65),
        itemCount: 12,
        itemBuilder: (_, __) => Container(color: Colors.white, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }

  Widget _buildResults(BuildContext context, List<Content> results, ThemeData theme, OttColors ott) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 64, color: ott.textSecondary),
            const SizedBox(height: 16),
            Text('No results found', style: theme.textTheme.titleMedium?.copyWith(color: ott.textSecondary)),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.65),
      itemCount: results.length,
      itemBuilder: (context, i) {
        final c = results[i];
        return GestureDetector(
          onTap: () => context.go('/content/${c.id}'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (c.posterUrl != null)
                  CachedNetworkImage(imageUrl: c.posterUrl!, fit: BoxFit.cover)
                else
                  Container(color: ott.surface, child: Icon(Icons.movie, color: ott.textSecondary)),
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                    child: Text(c.title, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
