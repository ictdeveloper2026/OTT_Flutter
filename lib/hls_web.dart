import 'dart:js_interop';
import 'dart:ui_web' as ui_web;
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

// Defined in web/index.html — attaches an HLS source to a <video> via hls.js.
@JS('attachHls')
external void _attachHls(web.HTMLVideoElement video, String url);

int _seq = 0;

/// A real HTML <video> + hls.js player, used on web where video_player can't do HLS.
Widget buildHlsPlayer(String url) => _HlsView(url: url);

class _HlsView extends StatefulWidget {
  final String url;
  const _HlsView({required this.url});
  @override
  State<_HlsView> createState() => _HlsViewState();
}

class _HlsViewState extends State<_HlsView> {
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'hls-video-${_seq++}';
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final video = web.HTMLVideoElement()
        ..controls = true
        ..autoplay = true
        ..setAttribute('playsinline', 'true');
      video.style.width = '100%';
      video.style.height = '100%';
      video.style.backgroundColor = 'black';
      _attachHls(video, widget.url);
      return video;
    });
  }

  @override
  Widget build(BuildContext context) => HtmlElementView(viewType: _viewType);
}
