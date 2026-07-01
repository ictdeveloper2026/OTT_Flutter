import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// Bottom-sheet list of video qualities for the player.
///
/// Driven by the stream response (`streamInfo.qualities`) so each entry carries
/// the per-quality playlist URL. "Auto" falls back to the master manifest.
class QualitySelector extends StatelessWidget {
  /// Each map: { 'quality', 'url' }.
  final List<Map<String, dynamic>> qualities;

  /// Master manifest URL, used for the "Auto" option.
  final String masterUrl;

  /// Currently-selected quality label, or null/"Auto".
  final String? selectedQuality;

  /// Called with (label, url) for the chosen quality.
  final void Function(String label, String url) onSelect;

  const QualitySelector({
    super.key,
    required this.qualities,
    required this.masterUrl,
    required this.onSelect,
    this.selectedQuality,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final current = selectedQuality ?? 'Auto';
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
              child: Text('Quality', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            ListTile(
              title: Text('Auto', style: TextStyle(color: colors.textPrimary)),
              trailing: current == 'Auto' ? Icon(Icons.check, color: colors.primary) : null,
              onTap: () => onSelect('Auto', masterUrl),
            ),
            ...qualities.map((q) {
              final label = (q['quality'] ?? '').toString();
              final url = (q['url'] ?? '').toString();
              final selected = label == current;
              return ListTile(
                title: Text(label, style: TextStyle(color: colors.textPrimary)),
                trailing: selected ? Icon(Icons.check, color: colors.primary) : null,
                onTap: () => onSelect(label, url),
              );
            }),
          ],
        ),
      ),
    );
  }
}
