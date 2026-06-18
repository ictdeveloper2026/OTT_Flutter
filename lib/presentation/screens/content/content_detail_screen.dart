import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../presentation/blocs/content/content_bloc.dart';
import '../../../data/models/content.dart';
import '../../../core/theme/app_theme.dart';

class ContentDetailScreen extends StatefulWidget {
  final String contentId;
  const ContentDetailScreen({super.key, required this.contentId});
  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<ContentBloc>().add(ContentDetailLoaded(contentId: widget.contentId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBloc, ContentState>(
      builder: (context, state) {
        if (state is ContentLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        if (state is ContentDetailLoaded2) return _buildDetail(context, state.content, state.related);
        if (state is ContentError) return Scaffold(body: Center(child: Text(state.message)));
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildDetail(BuildContext context, Content content, List<Content> related) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero banner
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (content.bannerUrl != null)
                    CachedNetworkImage(imageUrl: content.bannerUrl!, fit: BoxFit.cover)
                  else
                    Container(color: ott.surface),
                  // Gradient overlay
                  DecoratedBox(decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, theme.scaffoldBackgroundColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  )),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Title + meta
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (content.posterUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(imageUrl: content.posterUrl!, width: 100, height: 150, fit: BoxFit.cover),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(content.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              if (content.releaseYear != null) _chip(context, '${content.releaseYear}', ott),
                              if (content.ageRating != null) _chip(context, content.ageRating!, ott),
                              if (content.durationMinutes != null) _chip(context, '${content.durationMinutes}m', ott),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (content.genres != null)
                            Wrap(
                              spacing: 6,
                              children: content.genres!.map((g) => Chip(
                                label: Text(g, style: const TextStyle(fontSize: 11)),
                                padding: EdgeInsets.zero,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              )).toList(),
                            ),
                          const SizedBox(height: 8),
                          if (content.avgRating != null)
                            Row(children: [
                              const Icon(Icons.star, color: Colors.amber, size: 18),
                              const SizedBox(width: 4),
                              Text('${content.avgRating!.toStringAsFixed(1)} / 10', style: theme.textTheme.bodySmall),
                            ]),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Action buttons
                Row(children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.go('/play/${content.id}'),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play'),
                      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.read<ContentBloc>().add(ContentWatchlistToggled(contentId: content.id, isAdding: true)),
                      icon: const Icon(Icons.add),
                      label: const Text('Watchlist'),
                      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                    ),
                  ),
                ]),
                const SizedBox(height: 24),
                // Overview
                if (content.description != null) ...[
                  Text('Overview', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(content.description!, style: theme.textTheme.bodyMedium?.copyWith(color: ott.textSecondary, height: 1.5)),
                  const SizedBox(height: 24),
                ],
                // Tabs for episodes / cast / more
                if (content.contentType == 'series')
                  TabBar(
                    controller: _tabController,
                    tabs: const [Tab(text: 'Episodes'), Tab(text: 'Cast'), Tab(text: 'More Like This')],
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                if (content.contentType == 'series') ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildEpisodes(context, content, theme, ott),
                        _buildCast(context, content, theme, ott),
                        _buildRelated(context, related, theme, ott),
                      ],
                    ),
                  ),
                ] else ...[
                  Text('More Like This', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildRelated(context, related, theme, ott),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, String label, OttColors ott) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: ott.surface, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(fontSize: 12, color: ott.textSecondary)),
    );
  }

  Widget _buildEpisodes(BuildContext context, Content content, ThemeData theme, OttColors ott) {
    if (content.seasons == null || content.seasons!.isEmpty) {
      return const Center(child: Text('No episodes available'));
    }
    final episodes = content.seasons!.first.episodes ?? [];
    return ListView.separated(
      itemCount: episodes.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final ep = episodes[i];
        return ListTile(
          leading: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: ott.surface, borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text('${ep.episodeNumber}', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold))),
          ),
          title: Text(ep.title, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: ep.durationMinutes != null ? Text('${ep.durationMinutes}m', style: TextStyle(color: ott.textSecondary)) : null,
          trailing: const Icon(Icons.play_circle_outline),
          onTap: () => context.go('/play/${content.id}', extra: {'episodeId': ep.id}),
        );
      },
    );
  }

  Widget _buildCast(BuildContext context, Content content, ThemeData theme, OttColors ott) {
    if (content.cast == null || content.cast!.isEmpty) return const Center(child: Text('No cast info'));
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: content.cast!.length,
      itemBuilder: (context, i) {
        final member = content.cast![i];
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundImage: member.photoUrl != null ? NetworkImage(member.photoUrl!) : null,
                child: member.photoUrl == null ? Text(member.name[0]) : null,
              ),
              const SizedBox(height: 8),
              Text(member.name, style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
              if (member.character != null)
                Text(member.character!, style: TextStyle(fontSize: 11, color: ott.textSecondary), textAlign: TextAlign.center),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRelated(BuildContext context, List<Content> related, ThemeData theme, OttColors ott) {
    if (related.isEmpty) return const Center(child: Text('Nothing to show'));
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, childAspectRatio: 0.65, crossAxisSpacing: 8, mainAxisSpacing: 8,
      ),
      itemCount: related.length,
      itemBuilder: (context, i) {
        final c = related[i];
        return GestureDetector(
          onTap: () => context.go('/content/${c.id}'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: c.posterUrl != null ? CachedNetworkImage(imageUrl: c.posterUrl!, fit: BoxFit.cover) : Container(color: ott.surface),
          ),
        );
      },
    );
  }
}
