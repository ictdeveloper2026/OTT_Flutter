import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/theme/app_theme.dart';
import '../../blocs/player/player_bloc.dart';
import '../../../data/models/content.dart';
import '../../widgets/player/player_controls.dart';
import '../../widgets/player/episode_drawer.dart';
import '../../widgets/player/subtitle_selector.dart';
import '../../widgets/player/quality_selector.dart';

class VideoPlayerScreen extends StatefulWidget {
  final int contentId;
  final int startPosition;
  const VideoPlayerScreen({super.key, required this.contentId, this.startPosition = 0});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  Player? _player;
  VideoController? _controller;
  YoutubePlayerController? _ytController;
  InAppWebViewController? _vimeoController;

  bool _showControls = true;
  bool _isFullscreen = false;
  Timer? _hideTimer;
  Timer? _progressTimer;
  String _playerType = 'HLS'; // HLS | YouTube | Vimeo

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _enterFullscreen();
    context.read<PlayerBloc>().add(PlayerLoadContentEvent(widget.contentId));
  }

  void _enterFullscreen() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _exitFullscreen() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void _initHLSPlayer(String url) {
    _player = Player();
    _controller = VideoController(_player!);
    _player!.open(Media(url, start: Duration(seconds: widget.startPosition)));
    _player!.stream.position.listen((pos) => _syncProgress(pos.inSeconds));
    _startProgressSync();
  }

  void _initYouTubePlayer(String videoId) {
    _ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        startAt: widget.startPosition,
        enableCaption: true,
      ),
    );
  }

  void _syncProgress(int seconds) {
    final state = context.read<PlayerBloc>().state;
    if (state is PlayerPlayingState) {
      context.read<PlayerBloc>().add(PlayerProgressUpdateEvent(seconds, state.content.durationSeconds ?? 0));
    }
  }

  void _startProgressSync() {
    _progressTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      final pos = _player?.state.position.inSeconds ?? 0;
      _syncProgress(pos);
    });
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    setState(() => _showControls = true);
    _hideTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    _progressTimer?.cancel();
    _player?.dispose();
    _ytController?.dispose();
    WakelockPlus.disable();
    _exitFullscreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;

    return BlocConsumer<PlayerBloc, PlayerState>(
      listener: (context, state) {
        if (state is PlayerReadyState) {
          _playerType = state.videoAsset.playerType;
          switch (_playerType) {
            case 'YouTube': _initYouTubePlayer(state.videoAsset.youTubeVideoId!); break;
            case 'Vimeo': break; // initialized in webview
            default: _initHLSPlayer(state.signedUrl!);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: _resetHideTimer,
            child: Stack(
              children: [
                _buildVideoView(state),
                if (state is PlayerPlayingState) ...[
                  AnimatedOpacity(
                    opacity: _showControls ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: PlayerControls(
                      content: state.content,
                      player: _player,
                      ytController: _ytController,
                      playerType: _playerType,
                      isFullscreen: _isFullscreen,
                      onBack: () { context.pop(); },
                      onFullscreen: () {
                        setState(() => _isFullscreen = !_isFullscreen);
                        _isFullscreen ? _enterFullscreen() : _exitFullscreen();
                      },
                      onQualityTap: () => _showQualitySelector(context, state),
                      onSubtitleTap: () => _showSubtitleSelector(context, state),
                      onEpisodeTap: state.content.seriesInfo != null ? () => _showEpisodeDrawer(context) : null,
                    ),
                  ),
                ],
                if (state is PlayerLoadingState)
                  const Center(child: CircularProgressIndicator(color: Colors.white)),
                if (state is PlayerErrorState)
                  Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.error_outline, color: Colors.white54, size: 64),
                    const SizedBox(height: 12),
                    Text(state.message, style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 16),
                    ElevatedButton(onPressed: () => context.pop(), child: const Text('Go Back')),
                  ])),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoView(PlayerState state) {
    if (state is! PlayerPlayingState && state is! PlayerReadyState) return const SizedBox.expand(child: ColoredBox(color: Colors.black));

    switch (_playerType) {
      case 'YouTube':
        if (_ytController == null) return const SizedBox.expand(child: ColoredBox(color: Colors.black));
        return YoutubePlayer(
          controller: _ytController!,
          showVideoProgressIndicator: false,
          width: double.infinity,
        );

      case 'Vimeo':
        final state2 = state;
        if (state2 is PlayerReadyState) {
          return InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri('https://player.vimeo.com/video/${state2.videoAsset.vimeoVideoId}?autoplay=1&byline=0&portrait=0&title=0#t=${widget.startPosition}s')),
            initialSettings: InAppWebViewSettings(allowsInlineMediaPlayback: true, mediaPlaybackRequiresUserGesture: false, allowsAirPlayForMediaPlayback: true),
            onWebViewCreated: (c) => _vimeoController = c,
          );
        }
        return const SizedBox.expand(child: ColoredBox(color: Colors.black));

      default: // HLS
        if (_controller == null) return const SizedBox.expand(child: ColoredBox(color: Colors.black));
        return Video(controller: _controller!, controls: NoVideoControls, fit: BoxFit.contain, filterQuality: FilterQuality.high);
    }
  }

  void _showQualitySelector(BuildContext context, PlayerPlayingState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => QualitySelector(
        qualities: state.videoAsset.qualities ?? [],
        selectedQuality: state.selectedQuality,
        onSelect: (q) {
          context.read<PlayerBloc>().add(PlayerChangeQualityEvent(q));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showSubtitleSelector(BuildContext context, PlayerPlayingState state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SubtitleSelector(
        subtitles: state.content.subtitles ?? [],
        selectedId: state.selectedSubtitleId,
        onSelect: (id) {
          context.read<PlayerBloc>().add(PlayerChangeSubtitleEvent(id));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEpisodeDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EpisodeDrawer(
        seriesInfo: (context.read<PlayerBloc>().state as PlayerPlayingState).content.seriesInfo!,
        currentContentId: widget.contentId,
        onEpisodeSelect: (contentId) {
          Navigator.pop(context);
          context.pushReplacement('/play/$contentId');
        },
      ),
    );
  }
}
