import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Bottom-sheet list of subtitle tracks (plus "Off") for the player.
///
/// Driven by the stream response (`streamInfo.subtitles`) so each entry carries
/// the real track URL/language the player needs to actually load it.
class SubtitleSelector extends StatelessWidget {
  /// Each map: { 'language', 'label', 'url', 'format' }.
  final List<Map<String, dynamic>> subtitles;

  /// URL of the currently-applied subtitle, or null when off.
  final String? selectedUrl;

  /// Called with the chosen subtitle map, or null for "Off".
  final ValueChanged<Map<String, dynamic>?> onSelect;

  const SubtitleSelector({
    super.key,
    required this.subtitles,
    required this.onSelect,
    this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('Subtitles', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            ListTile(
              title: Text('Off', style: TextStyle(color: colors.textPrimary)),
              trailing: selectedUrl == null ? Icon(Icons.check, color: colors.primary) : null,
              onTap: () => onSelect(null),
            ),
            ...subtitles.map((s) {
              final url = s['url'] as String?;
              final label = (s['label'] ?? s['language'] ?? 'Unknown').toString();
              final selected = url != null && url == selectedUrl;
              return ListTile(
                title: Text(label, style: TextStyle(color: colors.textPrimary)),
                trailing: selected ? Icon(Icons.check, color: colors.primary) : null,
                onTap: () => onSelect(s),
              );
            }),
          ],
        ),
      ),
    );
  }
}
