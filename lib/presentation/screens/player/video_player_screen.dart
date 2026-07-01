import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart' hide PlayerState;
import 'package:media_kit_video/media_kit_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' hide PlayerState;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/theme/app_theme.dart';
import '../../blocs/player/player_bloc.dart';
import '../../widgets/player/player_controls.dart';
import '../../widgets/episode_drawer.dart';
import '../../widgets/player/subtitle_selector.dart';
import '../../widgets/player/quality_selector.dart';
import '../../widgets/player/audio_selector.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String contentId;
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

  // Stream URL the media_kit player was last opened with. Guards the BlocConsumer
  // listener so it only (re)builds the player when the stream actually changes —
  // not on every PlayerReady copyWith (play/pause/seek/subtitle/quality/etc.).
  String? _currentStreamUrl;
  // Persist track selections so they survive a quality re-open.
  Map<String, dynamic>? _selectedSubtitle;
  String _selectedQuality = 'Auto';

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _enterFullscreen();
    context.read<PlayerBloc>().add(PlayerInitialized(contentId: widget.contentId));
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

  void _disposePlayers() {
    _progressTimer?.cancel();
    _player?.dispose();
    _player = null;
    _controller = null;
    _ytController?.dispose();
    _ytController = null;
    _vimeoController = null;
  }

  /// Apply a subtitle track (or turn captions off when [sub] is null).
  void _applySubtitle(Map<String, dynamic>? sub) {
    _selectedSubtitle = sub;
    final p = _player;
    if (p == null) return;
    if (sub == null || (sub['url'] as String?) == null) {
      p.setSubtitleTrack(SubtitleTrack.no());
    } else {
      p.setSubtitleTrack(SubtitleTrack.uri(
        sub['url'] as String,
        title: sub['label']?.toString(),
        language: sub['language']?.toString(),
      ));
    }
  }

  /// Switch the HLS rendition by re-opening at the current position, then
  /// re-apply the active subtitle (a fresh Media resets the subtitle track).
  Future<void> _applyQuality(String label, String url) async {
    final p = _player;
    if (p == null || url.isEmpty) return;
    _selectedQuality = label;
    final pos = p.state.position;
    await p.open(Media(url, start: pos));
    if (_selectedSubtitle != null) _applySubtitle(_selectedSubtitle);
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
    if (state is PlayerReady) {
      context.read<PlayerBloc>().add(PlayerProgressSynced(contentId: state.content.id, position: seconds, duration: state.duration));
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
        if (state is PlayerReady) {
          // Only (re)build the player when the underlying stream changes (first
          // load or an episode switch). Subtitle/quality/play-state changes
          // re-emit PlayerReady but must not restart playback.
          if (state.streamInfo.url == _currentStreamUrl) return;
          _currentStreamUrl = state.streamInfo.url;
          _disposePlayers();
          _selectedSubtitle = null;
          _selectedQuality = 'Auto';
          if (state.streamInfo.isYoutube) {
            _playerType = 'YouTube';
            _initYouTubePlayer(state.streamInfo.youtubeVideoId ?? '');
          } else if (state.streamInfo.isVimeo) {
            _playerType = 'Vimeo';
          } else {
            _playerType = 'HLS';
            _initHLSPlayer(state.streamInfo.url);
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
                if (state is PlayerReady) ...[
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
                      onAudioTap: () => _showAudioSelector(context, state),
                      onEpisodeTap: state.content.seriesInfo != null ? () => _showEpisodeDrawer(context) : null,
                    ),
                  ),
                ],
                if (state is PlayerLoading)
                  const Center(child: CircularProgressIndicator(color: Colors.white)),
                if (state is PlayerError)
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
    if (state is! PlayerReady) return const SizedBox.expand(child: ColoredBox(color: Colors.black));

    switch (_playerType) {
      case 'YouTube':
        if (_ytController == null) return const SizedBox.expand(child: ColoredBox(color: Colors.black));
        return YoutubePlayer(
          controller: _ytController!,
          showVideoProgressIndicator: false,
          width: double.infinity,
        );

      case 'Vimeo':
        return InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri('https://player.vimeo.com/video/${state.streamInfo.vimeoVideoId}?autoplay=1&byline=0&portrait=0&title=0#t=${widget.startPosition}s')),
          initialSettings: InAppWebViewSettings(allowsInlineMediaPlayback: true, mediaPlaybackRequiresUserGesture: false, allowsAirPlayForMediaPlayback: true),
          onWebViewCreated: (c) => _vimeoController = c,
        );

      default: // HLS
        if (_controller == null) return const SizedBox.expand(child: ColoredBox(color: Colors.black));
        return Video(controller: _controller!, controls: NoVideoControls, fit: BoxFit.contain, filterQuality: FilterQuality.high);
    }
  }

  void _showQualitySelector(BuildContext context, PlayerReady state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => QualitySelector(
        qualities: state.streamInfo.qualities,
        masterUrl: state.streamInfo.url,
        selectedQuality: _selectedQuality,
        onSelect: (label, url) {
          _applyQuality(label, url);
          context.read<PlayerBloc>().add(PlayerQualityChanged(quality: label));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showSubtitleSelector(BuildContext context, PlayerReady state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SubtitleSelector(
        subtitles: state.streamInfo.subtitles,
        selectedUrl: _selectedSubtitle?['url'] as String?,
        onSelect: (sub) {
          _applySubtitle(sub);
          context.read<PlayerBloc>().add(PlayerSubtitleChanged(subtitle: sub?['url'] as String?));
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showAudioSelector(BuildContext context, PlayerReady state) {
    final p = _player;
    if (p == null) return;
    // media_kit detects the manifest's audio renditions at runtime; the backend
    // audioTracks (if any) only enrich the labels by language code.
    final tracks = p.state.tracks.audio.where((t) => t.id != 'no').toList();
    final backendTracks = state.streamInfo.audioTracks;

    String labelFor(AudioTrack t) {
      if (t.id == 'auto') return 'Auto';
      final lang = t.language;
      if (lang != null && lang.isNotEmpty) {
        for (final b in backendTracks) {
          if ((b['language']?.toString().toLowerCase() ?? '') == lang.toLowerCase()) {
            return (b['label'] ?? b['language']).toString();
          }
        }
      }
      return t.title?.isNotEmpty == true ? t.title! : (lang ?? 'Track ${t.id}');
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => AudioSelector(
        options: [for (final t in tracks) AudioOption(id: t.id, label: labelFor(t))],
        selectedId: p.state.track.audio.id,
        onSelect: (id) {
          final track = tracks.firstWhere((t) => t.id == id);
          p.setAudioTrack(track);
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
        seasons: (context.read<PlayerBloc>().state as PlayerReady).content.seasons,
        currentEpisodeId: null,
        onEpisodeSelected: (ep) {
          Navigator.pop(context);
          context.pushReplacement('/play/${ep.id}');
        },
      ),
    );
  }
}
