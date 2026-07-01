import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

/// A selectable audio (language) track surfaced to the player UI. [id] is the
/// media_kit track id used to switch; [label] is the human-readable language.
class AudioOption {
  final String id;
  final String label;
  const AudioOption({required this.id, required this.label});
}

/// Bottom-sheet list of audio (language) tracks for the player.
class AudioSelector extends StatelessWidget {
  final List<AudioOption> options;
  final String? selectedId;
  final ValueChanged<String> onSelect;

  const AudioSelector({
    super.key,
    required this.options,
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
              child: Text('Audio', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            if (options.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('No alternate audio tracks', style: TextStyle(color: colors.textSecondary)),
              ),
            ...options.map((o) {
              final selected = o.id == selectedId;
              return ListTile(
                title: Text(o.label, style: TextStyle(color: colors.textPrimary)),
                trailing: selected ? Icon(Icons.check, color: colors.primary) : null,
                onTap: () => onSelect(o.id),
              );
            }),
          ],
        ),
      ),
    );
  }
}
