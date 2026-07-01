import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/theme/app_theme.dart';
import '../shared_widgets.dart';

/// Admin panel: upload/declare subtitle & audio (language) tracks for a title.
/// Subtitles are uploaded as .vtt/.srt files; audio tracks are declared with a
/// language + label + manifest index (the rendition itself lives in the HLS).
class TrackManager extends StatefulWidget {
  final String contentId;
  const TrackManager({super.key, required this.contentId});

  @override
  State<TrackManager> createState() => _TrackManagerState();
}

class _TrackManagerState extends State<TrackManager> {
  final _api = sl<ApiService>();
  List<Map<String, dynamic>> _subtitles = [];
  List<Map<String, dynamic>> _audioTracks = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final data = await _api.adminGetTracks(widget.contentId);
      if (!mounted) return;
      setState(() {
        _subtitles = List<Map<String, dynamic>>.from((data['subtitles'] ?? const []).map((e) => Map<String, dynamic>.from(e)));
        _audioTracks = List<Map<String, dynamic>>.from((data['audioTracks'] ?? const []).map((e) => Map<String, dynamic>.from(e)));
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  void _toast(String msg) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _addSubtitle() async {
    final result = await showDialog<_SubtitleInput>(context: context, builder: (_) => const _AddSubtitleDialog());
    if (result == null) return;
    try {
      final form = FormData.fromMap({
        'file': await MultipartFile.fromFile(result.path, filename: result.fileName),
        'language': result.language,
        if (result.label.isNotEmpty) 'label': result.label,
        'format': result.format,
      });
      await _api.adminAddSubtitle(widget.contentId, form);
      _toast('Subtitle added');
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  Future<void> _deleteSubtitle(String id) async {
    try {
      await _api.adminDeleteSubtitle(widget.contentId, id);
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  Future<void> _addAudioTrack() async {
    final result = await showDialog<Map<String, dynamic>>(context: context, builder: (_) => const _AddAudioDialog());
    if (result == null) return;
    try {
      await _api.adminAddAudioTrack(widget.contentId, result);
      _toast('Audio track added');
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  Future<void> _deleteAudioTrack(String id) async {
    try {
      await _api.adminDeleteAudioTrack(widget.contentId, id);
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;

    if (_loading) {
      return const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Expanded(child: Text('Could not load tracks: $_error', style: TextStyle(color: colors.textSecondary))),
          TextButton(onPressed: _load, child: const Text('Retry')),
        ]),
      );
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // ── Subtitles ──
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Subtitles', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600, fontSize: 15)),
        TextButton.icon(onPressed: _addSubtitle, icon: const Icon(Icons.add, size: 18), label: const Text('Add subtitle')),
      ]),
      if (_subtitles.isEmpty)
        Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text('No subtitles yet', style: TextStyle(color: colors.textSecondary, fontSize: 13))),
      ..._subtitles.map((s) => _TrackTile(
            icon: Icons.closed_caption_outlined,
            title: (s['label'] ?? s['language'] ?? '').toString(),
            subtitle: '${s['language'] ?? ''} · ${(s['format'] ?? '').toString().toUpperCase()}',
            onDelete: () => _deleteSubtitle(s['id'].toString()),
          )),
      const SizedBox(height: 16),

      // ── Audio tracks ──
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Audio tracks', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600, fontSize: 15)),
        TextButton.icon(onPressed: _addAudioTrack, icon: const Icon(Icons.add, size: 18), label: const Text('Add audio')),
      ]),
      Text('Declares manifest audio renditions so the player shows language names.',
          style: TextStyle(color: colors.textSecondary, fontSize: 11)),
      if (_audioTracks.isEmpty)
        Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text('No audio tracks yet', style: TextStyle(color: colors.textSecondary, fontSize: 13))),
      ..._audioTracks.map((a) => _TrackTile(
            icon: Icons.multitrack_audio_rounded,
            title: '${a['label'] ?? a['language'] ?? ''}${a['isDefault'] == true ? '  (default)' : ''}',
            subtitle: '${a['language'] ?? ''} · track #${a['trackIndex'] ?? 0}',
            onDelete: () => _deleteAudioTrack(a['id'].toString()),
          )),
    ]);
  }
}

class _TrackTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onDelete;
  const _TrackTile({required this.icon, required this.title, required this.subtitle, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(icon, color: colors.textSecondary, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 14)),
          Text(subtitle, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        ])),
        IconButton(icon: const Icon(Icons.delete_outline, size: 20), color: Colors.redAccent, onPressed: onDelete),
      ]),
    );
  }
}

class _SubtitleInput {
  final String path, fileName, language, label, format;
  _SubtitleInput({required this.path, required this.fileName, required this.language, required this.label, required this.format});
}

class _AddSubtitleDialog extends StatefulWidget {
  const _AddSubtitleDialog();
  @override
  State<_AddSubtitleDialog> createState() => _AddSubtitleDialogState();
}

class _AddSubtitleDialogState extends State<_AddSubtitleDialog> {
  final _langCtrl = TextEditingController(text: 'en');
  final _labelCtrl = TextEditingController();
  String? _path, _fileName, _format;

  @override
  void dispose() {
    _langCtrl.dispose();
    _labelCtrl.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final res = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['vtt', 'srt']);
    final f = res?.files.single;
    if (f?.path != null) {
      setState(() {
        _path = f!.path;
        _fileName = f.name;
        _format = (f.extension ?? 'vtt').toLowerCase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return AlertDialog(
      backgroundColor: colors.surface,
      title: const Text('Add subtitle'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        OutlinedButton.icon(
          onPressed: _pick,
          icon: const Icon(Icons.upload_file),
          label: Text(_fileName ?? 'Choose .vtt / .srt file', overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(height: 12),
        TextField(controller: _langCtrl, decoration: const InputDecoration(labelText: 'Language code *', hintText: 'en, hi, ta…')),
        const SizedBox(height: 8),
        TextField(controller: _labelCtrl, decoration: const InputDecoration(labelText: 'Label', hintText: 'English (CC)')),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        GradientButton(
          label: 'Add',
          onPressed: () {
            if (_path == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pick a file'))); return; }
            if (_langCtrl.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language is required'))); return; }
            Navigator.pop(context, _SubtitleInput(
              path: _path!,
              fileName: _fileName ?? _path!.split(RegExp(r'[\\/]')).last,
              language: _langCtrl.text.trim(),
              label: _labelCtrl.text.trim(),
              format: _format ?? 'vtt',
            ));
          },
        ),
      ],
    );
  }
}

class _AddAudioDialog extends StatefulWidget {
  const _AddAudioDialog();
  @override
  State<_AddAudioDialog> createState() => _AddAudioDialogState();
}

class _AddAudioDialogState extends State<_AddAudioDialog> {
  final _langCtrl = TextEditingController(text: 'en');
  final _labelCtrl = TextEditingController();
  final _indexCtrl = TextEditingController(text: '0');
  bool _isDefault = false;

  @override
  void dispose() {
    _langCtrl.dispose();
    _labelCtrl.dispose();
    _indexCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return AlertDialog(
      backgroundColor: colors.surface,
      title: const Text('Add audio track'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: _langCtrl, decoration: const InputDecoration(labelText: 'Language code *', hintText: 'en, hi, ta…')),
        const SizedBox(height: 8),
        TextField(controller: _labelCtrl, decoration: const InputDecoration(labelText: 'Label', hintText: 'Hindi')),
        const SizedBox(height: 8),
        TextField(controller: _indexCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Manifest track index', hintText: '0')),
        const SizedBox(height: 4),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Default track', style: TextStyle(color: colors.textPrimary, fontSize: 14)),
          value: _isDefault,
          onChanged: (v) => setState(() => _isDefault = v),
        ),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        GradientButton(
          label: 'Add',
          onPressed: () {
            if (_langCtrl.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language is required'))); return; }
            Navigator.pop(context, {
              'language': _langCtrl.text.trim(),
              'label': _labelCtrl.text.trim(),
              'trackIndex': int.tryParse(_indexCtrl.text.trim()) ?? 0,
              'isDefault': _isDefault,
            });
          },
        ),
      ],
    );
  }
}
