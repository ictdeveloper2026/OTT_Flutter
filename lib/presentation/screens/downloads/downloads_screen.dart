import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    // In production this would load from local DB / Hive
    return Scaffold(
      appBar: AppBar(title: const Text('Downloads')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download_done_outlined, size: 72, color: ott.textSecondary),
            const SizedBox(height: 16),
            Text('No downloads yet', style: theme.textTheme.titleMedium?.copyWith(color: ott.textSecondary)),
            const SizedBox(height: 8),
            Text('Download titles to watch offline', style: theme.textTheme.bodySmall?.copyWith(color: ott.textSecondary)),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => context.go('/home'), child: const Text('Browse titles')),
          ],
        ),
      ),
    );
  }
}

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('My Watchlist')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_border_outlined, size: 72, color: ott.textSecondary),
            const SizedBox(height: 16),
            Text('Your watchlist is empty', style: theme.textTheme.titleMedium?.copyWith(color: ott.textSecondary)),
            const SizedBox(height: 8),
            Text('Save titles to watch later', style: theme.textTheme.bodySmall?.copyWith(color: ott.textSecondary)),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => context.go('/home'), child: const Text('Browse titles')),
          ],
        ),
      ),
    );
  }
}
