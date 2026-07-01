import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/content.dart';

class PlayerControls extends StatefulWidget {
  final Content content;
  final Player? player;
  final YoutubePlayerController? ytController;
  final String playerType;
  final bool isFullscreen;
  final VoidCallback onBack;
  final VoidCallback onFullscreen;
  final VoidCallback onQualityTap;
  final VoidCallback onSubtitleTap;
  final VoidCallback onAudioTap;
  final VoidCallback? onEpisodeTap;

  const PlayerControls({
    super.key,
    required this.content,
    this.player,
    this.ytController,
    required this.playerType,
    required this.isFullscreen,
    required this.onBack,
    required this.onFullscreen,
    required this.onQualityTap,
    required this.onSubtitleTap,
    required this.onAudioTap,
    this.onEpisodeTap,
  });

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  bool _isPlaying = true;
  double _playbackSpeed = 1.0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  double _volume = 1.0;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _listenToPlayer();
  }

  void _listenToPlayer() {
    final p = widget.player;
    if (p == null) return;
    p.stream.playing.listen((v) { if (mounted) setState(() => _isPlaying = v); });
    p.stream.position.listen((v) { if (mounted) setState(() => _position = v); });
    p.stream.duration.listen((v) { if (mounted) setState(() => _duration = v); });
    p.stream.volume.listen((v) { if (mounted) setState(() { _volume = v / 100; _isMuted = v == 0; }); });
  }

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  void _seek(int seconds) {
    final newPos = Duration(seconds: (_position.inSeconds + seconds).clamp(0, _duration.inSeconds));
    widget.player?.seek(newPos);
    widget.ytController?.seekTo(newPos);
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      widget.player?.pause();
      widget.ytController?.pause();
    } else {
      widget.player?.play();
      widget.ytController?.play();
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xCC000000), Colors.transparent, Colors.transparent, Color(0xCC000000)],
          stops: [0, 0.25, 0.75, 1],
        ),
      ),
      child: Column(children: [
        // ── Top Bar ──
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(children: [
              IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white), onPressed: widget.onBack),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.content.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15), overflow: TextOverflow.ellipsis),
                if (widget.content.seriesInfo != null) Text('S1 E1', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ])),
              if (widget.onEpisodeTap != null)
                IconButton(icon: const Icon(Icons.playlist_play_rounded, color: Colors.white), onPressed: widget.onEpisodeTap),
              IconButton(icon: const Icon(Icons.closed_caption_outlined, color: Colors.white), onPressed: widget.onSubtitleTap),
              if (widget.playerType == 'HLS')
                IconButton(icon: const Icon(Icons.multitrack_audio_rounded, color: Colors.white), tooltip: 'Audio', onPressed: widget.onAudioTap),
              IconButton(icon: const Icon(Icons.hd_outlined, color: Colors.white), onPressed: widget.onQualityTap),
              _SpeedButton(speed: _playbackSpeed, onSelect: (s) { setState(() => _playbackSpeed = s); widget.player?.setRate(s); }),
              if (!widget.isFullscreen)
                IconButton(icon: const Icon(Icons.picture_in_picture_alt_rounded, color: Colors.white), onPressed: () {}),
            ]),
          ),
        ),

        // ── Center Controls ──
        Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _CircleButton(icon: Icons.replay_10_rounded, size: 40, onTap: () => _seek(-10)),
          const SizedBox(width: 32),
          GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              width: 64, height: 64,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.15), border: Border.all(color: Colors.white54)),
              child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 36),
            ),
          ),
          const SizedBox(width: 32),
          _CircleButton(icon: Icons.forward_10_rounded, size: 40, onTap: () => _seek(10)),
        ])),

        // ── Skip Intro Button ──
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 8),
            child: OutlinedButton(
              onPressed: () => widget.player?.seek(Duration(seconds: _position.inSeconds + 90)),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54)),
              child: const Text('Skip Intro'),
            ),
          ),
        ),

        // ── Progress Bar & Bottom Bar ──
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
          child: Column(children: [
            Row(children: [
              Text(_format(_position), style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Expanded(
                child: Slider(
                  value: _duration.inSeconds > 0 ? (_position.inSeconds / _duration.inSeconds).clamp(0.0, 1.0) : 0.0,
                  onChanged: (v) {
                    final newPos = Duration(seconds: (v * _duration.inSeconds).round());
                    widget.player?.seek(newPos);
                    widget.ytController?.seekTo(newPos);
                  },
                  activeColor: colors.primary,
                  inactiveColor: Colors.white24,
                  thumbColor: Colors.white,
                ),
              ),
              Text(_format(_duration), style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                IconButton(
                  icon: Icon(_isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded, color: Colors.white, size: 20),
                  onPressed: () {
                    _isMuted ? widget.player?.setVolume((_volume * 100)) : widget.player?.setVolume(0);
                    setState(() => _isMuted = !_isMuted);
                  },
                ),
                if (!_isMuted) SizedBox(
                  width: 80,
                  child: Slider(value: _volume, onChanged: (v) { setState(() => _volume = v); widget.player?.setVolume(v * 100); }, activeColor: Colors.white, inactiveColor: Colors.white24, thumbColor: Colors.white),
                ),
              ]),
              Row(children: [
                IconButton(icon: const Icon(Icons.cast_rounded, color: Colors.white, size: 20), onPressed: () {}),
                IconButton(
                  icon: Icon(widget.isFullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded, color: Colors.white, size: 24),
                  onPressed: widget.onFullscreen,
                ),
              ]),
            ]),
          ]),
        ),
      ]),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  const _CircleButton({required this.icon, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Icon(icon, color: Colors.white, size: size),
  );
}

class _SpeedButton extends StatelessWidget {
  final double speed;
  final void Function(double) onSelect;
  const _SpeedButton({required this.speed, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      color: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tooltip: 'Speed',
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text('${speed}x', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
      ),
      onSelected: onSelect,
      itemBuilder: (_) => [0.5, 0.75, 1.0, 1.25, 1.5, 2.0].map((s) => PopupMenuItem(
        value: s,
        child: Row(children: [
          if (s == speed) const Icon(Icons.check, color: Colors.white, size: 16) else const SizedBox(width: 16),
          const SizedBox(width: 8),
          Text('${s}x', style: const TextStyle(color: Colors.white)),
        ]),
      )).toList(),
    );
  }
}
