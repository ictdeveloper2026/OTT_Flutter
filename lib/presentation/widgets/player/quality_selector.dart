import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/content.dart';

/// Bottom-sheet list of video qualities for the player.
class QualitySelector extends StatelessWidget {
  final List<VideoQuality> qualities;
  final String? selectedQuality;
  final ValueChanged<String> onSelect;

  const QualitySelector({
    super.key,
    required this.qualities,
    required this.onSelect,
    this.selectedQuality,
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
              child: Text('Quality', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            ...['Auto', ...qualities.map((q) => q.resolution)].map((res) {
              final selected = res == (selectedQuality ?? 'Auto');
              return ListTile(
                title: Text(res, style: TextStyle(color: colors.textPrimary)),
                trailing: selected ? Icon(Icons.check, color: colors.primary) : null,
                onTap: () => onSelect(res),
              );
            }),
          ],
        ),
      ),
    );
  }
}
