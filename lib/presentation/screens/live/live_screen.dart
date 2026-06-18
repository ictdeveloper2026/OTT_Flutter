import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/blocs/live/live_bloc.dart';
import '../../../data/models/content.dart';
import '../../../core/theme/app_theme.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});
  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LiveBloc>().add(LiveStreamsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text('Live', style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [
              IconButton(icon: const Icon(Icons.refresh), onPressed: () => context.read<LiveBloc>().add(LiveStreamRefreshed())),
            ],
          ),
          BlocBuilder<LiveBloc, LiveState>(
            builder: (context, state) {
              if (state is LiveLoading) return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              if (state is LiveError) return SliverFillRemaining(child: Center(child: Text(state.message)));
              if (state is LiveStreamsReady) {
                if (state.streams.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.live_tv_outlined, size: 64, color: ott.textSecondary),
                          const SizedBox(height: 16),
                          Text('No live streams right now', style: theme.textTheme.titleMedium?.copyWith(color: ott.textSecondary)),
                        ],
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _LiveCard(stream: state.streams[i]),
                      childCount: state.streams.length,
                    ),
                  ),
                );
              }
              return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}

class _LiveCard extends StatelessWidget {
  final LiveStream stream;
  const _LiveCard({required this.stream});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return GestureDetector(
      onTap: () => context.go('/live/play/${stream.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(color: ott.surface, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: stream.thumbnailUrl != null
                      ? Image.network(stream.thumbnailUrl!, height: 200, width: double.infinity, fit: BoxFit.cover)
                      : Container(height: 200, color: Colors.grey[900], child: const Icon(Icons.live_tv, size: 60, color: Colors.white24)),
                ),
                if (stream.status == 'live')
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                      child: const Row(children: [
                        Icon(Icons.circle, color: Colors.white, size: 8),
                        SizedBox(width: 4),
                        Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ]),
                    ),
                  ),
                if (stream.viewerCount != null)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                      child: Row(children: [
                        const Icon(Icons.remove_red_eye, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(_formatViewers(stream.viewerCount!), style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ]),
                    ),
                  ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 36),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stream.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  if (stream.description != null) ...[
                    const SizedBox(height: 4),
                    Text(stream.description!, style: TextStyle(color: ott.textSecondary, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatViewers(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return '$count';
  }
}
