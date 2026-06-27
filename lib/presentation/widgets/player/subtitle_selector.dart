import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/content.dart';

/// Bottom-sheet list of subtitle tracks (plus "Off") for the player.
class SubtitleSelector extends StatelessWidget {
  final List<Subtitle> subtitles;
  final String? selectedId;
  final ValueChanged<String?> onSelect;

  const SubtitleSelector({
    super.key,
    required this.subtitles,
    required this.onSelect,
    this.selectedId,
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
              trailing: selectedId == null ? Icon(Icons.check, color: colors.primary) : null,
              onTap: () => onSelect(null),
            ),
            ...subtitles.map((s) {
              final selected = s.id == selectedId;
              return ListTile(
                title: Text(s.label, style: TextStyle(color: colors.textPrimary)),
                trailing: selected ? Icon(Icons.check, color: colors.primary) : null,
                onTap: () => onSelect(s.id),
              );
            }),
          ],
        ),
      ),
    );
  }
}
