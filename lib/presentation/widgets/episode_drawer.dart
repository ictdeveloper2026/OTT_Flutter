import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/content.dart';

class EpisodeDrawer extends StatefulWidget {
  final List<Season> seasons;
  final Guid? currentEpisodeId;
  final Function(Episode episode) onEpisodeSelected;

  const EpisodeDrawer({
    super.key,
    required this.seasons,
    this.currentEpisodeId,
    required this.onEpisodeSelected,
  });

  @override
  State<EpisodeDrawer> createState() => _EpisodeDrawerState();
}

class _EpisodeDrawerState extends State<EpisodeDrawer> {
  int _selectedSeason = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHandle(colors),
          _buildHeader(colors),
          _buildSeasonTabs(colors),
          Expanded(child: _buildEpisodeList(colors)),
        ],
      ),
    );
  }

  Widget _buildHandle(OttColors colors) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: colors.divider,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(OttColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          Text(
            'Episodes',
            style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.close, color: colors.textSecondary),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonTabs(OttColors colors) {
    if (widget.seasons.length <= 1) return const SizedBox.shrink();
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.seasons.length,
        itemBuilder: (context, i) {
          final isSelected = _selectedSeason == i;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedSeason = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : colors.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Season ${widget.seasons[i].seasonNumber}',
                  style: TextStyle(
                    color: isSelected ? Colors.white : colors.textSecondary,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEpisodeList(OttColors colors) {
    final season = widget.seasons.isNotEmpty ? widget.seasons[_selectedSeason] : null;
    if (season == null || (season.episodes?.isEmpty ?? true)) {
      return Center(
        child: Text('No episodes available', style: TextStyle(color: colors.textSecondary)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: season.episodes!.length,
      itemBuilder: (context, i) => _buildEpisodeTile(season.episodes![i], colors),
    );
  }

  Widget _buildEpisodeTile(Episode episode, OttColors colors) {
    final isCurrent = episode.id == widget.currentEpisodeId;
    return GestureDetector(
      onTap: () {
        widget.onEpisodeSelected(episode);
        Navigator.pop(context);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCurrent ? colors.primary.withOpacity(0.12) : colors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCurrent ? colors.primary : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 112,
                height: 63,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    episode.thumbnailUrl != null
                        ? CachedNetworkImage(imageUrl: episode.thumbnailUrl!, fit: BoxFit.cover)
                        : Container(
                            color: colors.surface,
                            child: Icon(Icons.movie, color: colors.textSecondary),
                          ),
                    if (isCurrent)
                      Container(
                        color: colors.primary.withOpacity(0.6),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
                      ),
                    if (!isCurrent)
                      Center(
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                          child: const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'E${episode.episodeNumber}',
                        style: TextStyle(
                          color: isCurrent ? colors.primary : colors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    episode.title,
                    style: TextStyle(
                      color: isCurrent ? colors.primary : colors.textPrimary,
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (episode.durationSeconds != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      _formatDuration(episode.durationSeconds!),
                      style: TextStyle(color: colors.textSecondary, fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    if (m >= 60) {
      final h = m ~/ 60;
      final mins = m % 60;
      return '${h}h ${mins}m';
    }
    return '${m}m ${s}s';
  }
}

typedef Guid = String; // Placeholder; use actual Uuid type in production
