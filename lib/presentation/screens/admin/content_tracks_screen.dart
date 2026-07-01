import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../widgets/admin/track_manager.dart';

/// Admin screen for managing a single title's subtitle & audio tracks.
/// Hosts only the [TrackManager] — no content form, so there's no risk of
/// accidentally overwriting the title's metadata.
class ContentTracksScreen extends StatelessWidget {
  final String contentId;
  final String? title;
  const ContentTracksScreen({super.key, required this.contentId, this.title});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(title: Text(title == null ? 'Subtitles & Audio' : 'Tracks · $title')),
      body: contentId.isEmpty
          ? Center(child: Text('No title selected', style: TextStyle(color: colors.textSecondary)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: TrackManager(contentId: contentId),
            ),
    );
  }
}
