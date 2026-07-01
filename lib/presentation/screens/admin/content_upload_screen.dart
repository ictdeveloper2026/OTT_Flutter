import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../widgets/shared_widgets.dart';
import '../../widgets/admin/track_manager.dart';

enum VideoSourceType { hls, youtube, vimeo }

class ContentUploadScreen extends StatefulWidget {
  final String? contentId;
  const ContentUploadScreen({super.key, this.contentId});

  @override
  State<ContentUploadScreen> createState() => _ContentUploadScreenState();
}

class _ContentUploadScreenState extends State<ContentUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _shortDescCtrl = TextEditingController();
  final _ytIdCtrl = TextEditingController();
  final _vimeoIdCtrl = TextEditingController();
  final _trailerYtCtrl = TextEditingController();

  // Values match the backend contract (CreateContentDto) directly.
  String _type = 'movie';
  String _monetization = 'svod';
  String _rating = 'PG';
  VideoSourceType _videoSource = VideoSourceType.youtube;

  File? _thumbnailFile, _posterFile, _bannerFile, _videoFile;
  String? _thumbnailUrl, _posterUrl, _bannerUrl; // already-persisted images (edit mode / after upload)
  final double _uploadProgress = 0; // reserved for future determinate progress
  bool _uploading = false;
  bool _saving = false;
  bool _loadingForm = false;
  String? _createdContentId;
  String? _uploadStatus;
  final Set<String> _selectedGenreIds = {};
  List<Map<String, dynamic>> _genres = []; // {id, name} fetched from the API

  final _types = ['movie', 'series', 'short', 'documentary'];
  final _models = ['free', 'avod', 'svod', 'tvod'];
  final _ratings = ['G', 'PG', 'PG13', 'R', 'NC17', 'U', 'UA', 'A'];

  @override
  void initState() {
    super.initState();
    _loadGenres();
    if (widget.contentId != null) {
      _createdContentId = widget.contentId;
      _loadContent();
    }
  }

  Future<void> _loadGenres() async {
    try {
      final genres = await sl<ApiService>().adminGetGenres();
      if (mounted) setState(() => _genres = genres.map((e) => Map<String, dynamic>.from(e)).toList());
    } catch (_) { /* genres optional; chips simply won't render */ }
  }

  Future<void> _loadContent() async {
    setState(() => _loadingForm = true);
    try {
      final c = await sl<ApiService>().adminGetContent(widget.contentId!);
      if (!mounted) return;
      setState(() {
        _titleCtrl.text = (c['title'] ?? '').toString();
        _descCtrl.text = (c['description'] ?? '').toString();
        _shortDescCtrl.text = (c['shortDescription'] ?? '').toString();
        _thumbnailUrl = c['thumbnailUrl'] as String?;
        _posterUrl = c['posterUrl'] as String?;
        _bannerUrl = c['bannerUrl'] as String?;
        final t = (c['type'] ?? 'movie').toString();
        _type = _types.contains(t) ? t : 'movie';
        final m = (c['monetizationModel'] ?? 'svod').toString();
        _monetization = _models.contains(m) ? m : 'svod';
        final r = (c['ageRating'] ?? 'PG').toString();
        _rating = _ratings.contains(r) ? r : 'PG';
        _ytIdCtrl.text = (c['youtubeId'] ?? '').toString();
        _vimeoIdCtrl.text = (c['vimeoId'] ?? '').toString();
        _selectedGenreIds
          ..clear()
          ..addAll(((c['genreIds'] ?? const []) as List).map((e) => e.toString()));
        _loadingForm = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loadingForm = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load content: $e')));
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose(); _descCtrl.dispose(); _shortDescCtrl.dispose();
    _ytIdCtrl.dispose(); _vimeoIdCtrl.dispose(); _trailerYtCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(void Function(File) setter) async {
    final f = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (f != null && mounted) setState(() => setter(File(f.path)));
  }

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result?.files.single.path != null && mounted) {
      setState(() => _videoFile = File(result!.files.single.path!));
    }
  }

  Future<void> _saveContent() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final api = sl<ApiService>();
      final data = {
        'title': _titleCtrl.text.trim(),
        'description': _descCtrl.text.trim(),
        'shortDescription': _shortDescCtrl.text.trim(),
        'type': _type,
        'monetizationModel': _monetization,
        'ageRating': _rating,
        'genreIds': _selectedGenreIds.toList(),
        if (_trailerYtCtrl.text.trim().isNotEmpty)
          'trailerUrl': 'https://www.youtube.com/watch?v=${_trailerYtCtrl.text.trim()}',
        if (_thumbnailUrl != null) 'thumbnailUrl': _thumbnailUrl,
        if (_posterUrl != null) 'posterUrl': _posterUrl,
        if (_bannerUrl != null) 'bannerUrl': _bannerUrl,
        // YouTube/Vimeo are plain content fields — persisted directly with Save.
        if (_videoSource == VideoSourceType.youtube && _ytIdCtrl.text.trim().isNotEmpty)
          'youtubeId': _ytIdCtrl.text.trim(),
        if (_videoSource == VideoSourceType.vimeo && _vimeoIdCtrl.text.trim().isNotEmpty)
          'vimeoId': _vimeoIdCtrl.text.trim(),
      };
      final res = widget.contentId != null
          ? await api.adminUpdateContent(widget.contentId!, data)
          : await api.adminCreateContent(data);
      _createdContentId = (res['id'] ?? widget.contentId)?.toString();
      // Now that the title exists, upload any newly-picked images + video (persisted server-side).
      await _uploadPendingImages(api);
      await _uploadPendingVideo(api);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Content saved!')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // Upload any picked image files against the saved title and capture the URLs.
  Future<void> _uploadPendingImages(ApiService api) async {
    final id = _createdContentId;
    if (id == null) return;
    Future<String> upload(File f, String type) async {
      final form = FormData.fromMap({
        'file': await MultipartFile.fromFile(f.path, filename: f.path.split(RegExp(r'[\\/]')).last),
        'type': type,
      });
      return api.adminUploadContentImage(id, form);
    }
    if (_thumbnailFile != null) { _thumbnailUrl = await upload(_thumbnailFile!, 'thumbnail'); _thumbnailFile = null; }
    if (_posterFile != null) { _posterUrl = await upload(_posterFile!, 'poster'); _posterFile = null; }
    if (_bannerFile != null) { _bannerUrl = await upload(_bannerFile!, 'banner'); _bannerFile = null; }
  }

  // Upload a picked HLS source file against the saved title and start transcoding.
  // (YouTube/Vimeo need no upload — they persist via the Save payload.)
  Future<void> _uploadPendingVideo(ApiService api) async {
    final id = _createdContentId;
    if (id == null || _videoSource != VideoSourceType.hls || _videoFile == null) return;
    setState(() { _uploading = true; _uploadStatus = 'Uploading video…'; });
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(_videoFile!.path, filename: _videoFile!.path.split(RegExp(r'[\\/]')).last),
      });
      await api.adminUploadVideo(id, 'HLS', null, formData: formData);
      _videoFile = null;
      if (mounted) setState(() => _uploadStatus = 'Upload complete — transcoding in background.');
    } catch (e) {
      if (mounted) setState(() => _uploadStatus = 'Video upload failed: $e');
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: Text(widget.contentId == null ? 'Upload Content' : 'Edit Content'),
        actions: [
          GradientButton(label: 'Save', onPressed: _saveContent, isLoading: _saving),
          const SizedBox(width: 16),
        ],
      ),
      body: _loadingForm
        ? const Center(child: CircularProgressIndicator())
        : Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            // ── Basic Info ──
            const SectionHeader(title: 'Basic Information'),
            const SizedBox(height: 12),
            _field(_titleCtrl, 'Title *', required: true),
            const SizedBox(height: 12),
            _field(_shortDescCtrl, 'Short Description'),
            const SizedBox(height: 12),
            TextFormField(controller: _descCtrl, decoration: const InputDecoration(labelText: 'Full Description', alignLabelWithHint: true), maxLines: 4),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _dropdown('Type', _type, _types, (v) => setState(() => _type = v!))),
              const SizedBox(width: 12),
              Expanded(child: _dropdown('Monetization', _monetization, _models, (v) => setState(() => _monetization = v!))),
            ]),
            const SizedBox(height: 12),
            _dropdown('Rating', _rating, _ratings, (v) => setState(() => _rating = v!)),
            const SizedBox(height: 16),

            // ── Genres ──
            const SectionHeader(title: 'Genres'),
            const SizedBox(height: 8),
            if (_genres.isEmpty)
              Text('No genres defined yet — add them under Admin › Genres.', style: TextStyle(color: colors.textSecondary, fontSize: 13))
            else
              Wrap(spacing: 8, runSpacing: 8, children: _genres.map((g) {
                final id = g['id'].toString();
                return FilterChip(
                  label: Text(g['name']?.toString() ?? ''),
                  selected: _selectedGenreIds.contains(id),
                  onSelected: (v) => setState(() => v ? _selectedGenreIds.add(id) : _selectedGenreIds.remove(id)),
                  selectedColor: colors.primary.withOpacity(0.2),
                  checkmarkColor: colors.primary,
                );
              }).toList()),
            const SizedBox(height: 24),

            // ── Images ──
            const SectionHeader(title: 'Images'),
            const SizedBox(height: 12),
            Row(children: [
              _ImagePicker(label: 'Thumbnail\n(2:3)', file: _thumbnailFile, url: _thumbnailUrl, onPick: () => _pickImage((f) => _thumbnailFile = f)),
              const SizedBox(width: 12),
              _ImagePicker(label: 'Poster\n(1:1.5)', file: _posterFile, url: _posterUrl, onPick: () => _pickImage((f) => _posterFile = f)),
              const SizedBox(width: 12),
              _ImagePicker(label: 'Banner\n(16:9)', file: _bannerFile, url: _bannerUrl, onPick: () => _pickImage((f) => _bannerFile = f), wide: true),
            ]),
            const SizedBox(height: 8),
            Text('Pick images, then tap Save to upload them.', style: TextStyle(color: colors.textSecondary, fontSize: 11)),
            const SizedBox(height: 24),

            // ── Trailer ──
            const SectionHeader(title: 'Trailer'),
            const SizedBox(height: 12),
            _field(_trailerYtCtrl, 'YouTube Trailer Video ID', hint: 'e.g. dQw4w9WgXcQ'),
            const SizedBox(height: 24),

            // ── Video Source ──
            const SectionHeader(title: 'Video Source'),
            const SizedBox(height: 12),
            _VideoSourceTabs(
              selected: _videoSource,
              onSelect: (t) => setState(() => _videoSource = t),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _buildVideoSourceInput(colors),
            ),
            const SizedBox(height: 8),
            Text('Set the video source above — it is saved (and any picked file uploaded) when you tap Save.',
                style: TextStyle(color: colors.textSecondary, fontSize: 11)),
            if (_uploading) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(value: _uploadProgress > 0 ? _uploadProgress : null, backgroundColor: colors.surface, color: colors.primary),
            ],
            if (_uploadStatus != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: colors.surface),
                child: Row(children: [
                  Icon(Icons.info_outline, color: colors.accent, size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(_uploadStatus!, style: TextStyle(color: colors.textPrimary, fontSize: 13))),
                ]),
              ),
            ],
            const SizedBox(height: 24),

            // ── Subtitles & Audio Tracks ──
            const SectionHeader(title: 'Subtitles & Audio Tracks'),
            const SizedBox(height: 8),
            if ((_createdContentId ?? widget.contentId) != null)
              TrackManager(
                // Re-create when the id first becomes available after saving a new title.
                key: ValueKey(_createdContentId ?? widget.contentId),
                contentId: (_createdContentId ?? widget.contentId)!,
              )
            else
              _InfoBox(icon: Icons.info_outline, color: colors.accent, text: 'Tap Save first — the subtitle & audio manager appears here once the title exists.'),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }

  Widget _buildVideoSourceInput(OttColors colors) {
    switch (_videoSource) {
      case VideoSourceType.youtube:
        return Column(key: const ValueKey('yt'), children: [
          _field(_ytIdCtrl, 'YouTube Video ID *', hint: 'e.g. dQw4w9WgXcQ', required: true),
          const SizedBox(height: 8),
          _InfoBox(icon: Icons.info_outline, color: colors.accent, text: 'Video will be embedded using YouTube Player API. Ensure the video is unlisted or public.'),
        ]);
      case VideoSourceType.vimeo:
        return Column(key: const ValueKey('vimeo'), children: [
          _field(_vimeoIdCtrl, 'Vimeo Video ID *', hint: 'e.g. 123456789', required: true),
          const SizedBox(height: 8),
          _InfoBox(icon: Icons.info_outline, color: colors.accent, text: 'Uses Vimeo Player API. Video must be unlocked or domain-whitelist this app.'),
        ]);
      case VideoSourceType.hls:
        return Column(key: const ValueKey('hls'), crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: _pickVideo,
            child: Container(
              height: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white24, style: BorderStyle.solid)),
              alignment: Alignment.center,
              child: _videoFile == null
                  ? Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.video_library_outlined, color: Colors.white38, size: 28), SizedBox(height: 6), Text('Tap to select MP4 video', style: TextStyle(color: Colors.white38, fontSize: 13))])
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.movie, color: Colors.white70), const SizedBox(width: 8), Flexible(child: Text(_videoFile!.path.split('/').last, style: const TextStyle(color: Colors.white70, fontSize: 12), overflow: TextOverflow.ellipsis))]),
            ),
          ),
          const SizedBox(height: 8),
          _InfoBox(icon: Icons.cloud_upload_outlined, color: colors.primary, text: 'Video will be uploaded to S3 and auto-transcoded to HLS (1080p/720p/480p/360p) via FFmpeg in background.'),
        ]);
    }
  }

  Widget _field(TextEditingController c, String label, {String? hint, bool required = false}) =>
      TextFormField(
        controller: c,
        decoration: InputDecoration(labelText: label, hintText: hint),
        validator: required ? (v) => v == null || v.isEmpty ? 'Required' : null : null,
      );

  Widget _dropdown(String label, String value, List<String> options, void Function(String?) onChanged) =>
      DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        dropdownColor: Theme.of(context).extension<OttColors>()!.surface,
        items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
        onChanged: onChanged,
      );
}

class _VideoSourceTabs extends StatelessWidget {
  final VideoSourceType selected;
  final void Function(VideoSourceType) onSelect;
  const _VideoSourceTabs({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final tabs = [
      (VideoSourceType.youtube, Icons.smart_display_outlined, 'YouTube'),
      (VideoSourceType.vimeo, Icons.videocam_outlined, 'Vimeo'),
      (VideoSourceType.hls, Icons.cloud_upload_outlined, 'Upload HLS'),
    ];
    return Row(children: tabs.map((t) {
      final active = selected == t.$1;
      return Expanded(child: GestureDetector(
        onTap: () => onSelect(t.$1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: active ? colors.primary : colors.surface,
            border: Border.all(color: active ? colors.primary : Colors.white12),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(t.$2, color: active ? Colors.white : colors.textSecondary, size: 20),
            const SizedBox(height: 4),
            Text(t.$3, style: TextStyle(color: active ? Colors.white : colors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
          ]),
        ),
      ));
    }).toList());
  }
}

class _ImagePicker extends StatelessWidget {
  final String label;
  final File? file;
  final String? url; // existing/persisted image shown when no new file is picked
  final VoidCallback onPick;
  final bool wide;
  const _ImagePicker({required this.label, this.file, this.url, required this.onPick, this.wide = false});

  @override
  Widget build(BuildContext context) {
    final DecorationImage? bg = file != null
        ? DecorationImage(image: FileImage(file!), fit: BoxFit.cover)
        : (url != null && url!.isNotEmpty ? DecorationImage(image: NetworkImage(url!), fit: BoxFit.cover) : null);
    return GestureDetector(
      onTap: onPick,
      child: Container(
        width: wide ? 140 : 90,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
          image: bg,
        ),
        child: bg == null ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.add_photo_alternate_outlined, color: Colors.white38, size: 22),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        ])) : null,
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _InfoBox({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: color.withOpacity(0.08), border: Border.all(color: color.withOpacity(0.3))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: TextStyle(color: color, fontSize: 12))),
    ]),
  );
}
