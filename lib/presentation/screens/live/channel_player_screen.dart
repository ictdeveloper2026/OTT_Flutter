import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

// Web plays HLS via hls.js (buildHlsPlayer in hls_web.dart); native falls back to the stub
// and uses media_kit directly.
import '../../../hls_stub.dart' if (dart.library.js_interop) '../../../hls_web.dart';

/// Plays a raw channel stream URL (m3u8/HLS) for the Live TV feature.
class ChannelPlayerScreen extends StatefulWidget {
  final String url;
  final String title;
  const ChannelPlayerScreen({super.key, required this.url, required this.title});

  @override
  State<ChannelPlayerScreen> createState() => _ChannelPlayerScreenState();
}

class _ChannelPlayerScreenState extends State<ChannelPlayerScreen> {
  Player? _player;
  VideoController? _controller;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && widget.url.isNotEmpty) {
      _player = Player();
      _controller = VideoController(_player!);
      _player!.open(Media(widget.url));
    }
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: Center(child: _video()),
    );
  }

  Widget _video() {
    if (widget.url.isEmpty) {
      return const Text('This channel has no stream URL yet.', style: TextStyle(color: Colors.white54));
    }
    if (kIsWeb) return buildHlsPlayer(widget.url);
    if (_controller == null) return const CircularProgressIndicator();
    return Video(controller: _controller!, fit: BoxFit.contain);
  }
}
