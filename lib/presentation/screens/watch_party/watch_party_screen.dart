import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:video_player/video_player.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/content.dart';

class WatchPartyScreen extends StatefulWidget {
  final String partyCode;
  final bool isHost;
  const WatchPartyScreen({super.key, required this.partyCode, this.isHost = false});

  @override
  State<WatchPartyScreen> createState() => _WatchPartyScreenState();
}

class _WatchPartyScreenState extends State<WatchPartyScreen> {
  HubConnection? _hubConnection;
  VideoPlayerController? _videoController;
  final _chatController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final List<PartyMember> _members = [];
  bool _isSyncing = false;
  bool _showChat = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _connectToHub();
  }

  Future<void> _connectToHub() async {
    _hubConnection = HubConnectionBuilder()
        .withUrl('${AppConstants.wsBaseUrl}/hubs/watchparty',
            options: HttpConnectionOptions(
              accessTokenFactory: () async => 'Bearer ${_getToken()}',
            ))
        .withAutomaticReconnect()
        .build();

    _hubConnection!.on('SyncState', (args) => _handleSyncState(args));
    _hubConnection!.on('PlaybackEvent', (args) => _handlePlaybackEvent(args));
    _hubConnection!.on('ChatMessage', (args) => _handleChatMessage(args));
    _hubConnection!.on('Reaction', (args) => _handleReaction(args));
    _hubConnection!.on('UserJoined', (args) => _handleUserJoined(args));
    _hubConnection!.on('UserLeft', (args) => _handleUserLeft(args));

    await _hubConnection!.start();
    await _hubConnection!.invoke('JoinParty', args: [widget.partyCode]);
  }

  String _getToken() => ''; // TODO: inject from auth bloc

  void _handleSyncState(List<Object?>? args) {
    if (args == null || args.isEmpty) return;
    // Sync video position to match host
    final state = args[0] as Map<String, dynamic>;
    final position = (state['positionSeconds'] as num).toDouble();
    final isPlaying = state['isPlaying'] as bool;
    setState(() => _isPlaying = isPlaying);
    _videoController?.seekTo(Duration(seconds: position.toInt()));
    if (isPlaying) _videoController?.play();
    else _videoController?.pause();
  }

  void _handlePlaybackEvent(List<Object?>? args) {
    if (args == null || args.isEmpty || _isSyncing) return;
    final event = args[0] as Map<String, dynamic>;
    final type = event['eventType'] as String;
    final pos = (event['positionSeconds'] as num).toDouble();

    setState(() => _isSyncing = true);
    _videoController?.seekTo(Duration(seconds: pos.toInt()));
    if (type == 'play') _videoController?.play();
    else if (type == 'pause') _videoController?.pause();
    Future.delayed(const Duration(seconds: 1), () => setState(() => _isSyncing = false));
  }

  void _handleChatMessage(List<Object?>? args) {
    if (args == null || args.isEmpty) return;
    final msg = args[0] as Map<String, dynamic>;
    setState(() {
      _messages.add(ChatMessage(
        userName: msg['userName'] as String,
        message: msg['message'] as String,
        avatarUrl: msg['avatarUrl'] as String?,
        timestamp: DateTime.now(),
      ));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients)
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  void _handleReaction(List<Object?>? args) {
    if (args == null || args.isEmpty) return;
    final reaction = (args[0] as Map<String, dynamic>)['reaction'] as String;
    _showFloatingReaction(reaction);
  }

  void _handleUserJoined(List<Object?>? args) {
    if (args == null || args.isEmpty) return;
    final user = args[0] as Map<String, dynamic>;
    setState(() {
      _members.add(PartyMember(
        userId: user['userId'] as String,
        userName: user['userName'] as String,
        avatarUrl: user['avatarUrl'] as String?,
      ));
    });
  }

  void _handleUserLeft(List<Object?>? args) {
    if (args == null || args.isEmpty) return;
    final userId = (args[0] as Map<String, dynamic>)['userId'] as String;
    setState(() => _members.removeWhere((m) => m.userId == userId));
  }

  void _showFloatingReaction(String emoji) {
    // TODO: Animate floating emoji overlay
  }

  Future<void> _sendPlaybackEvent(String type) async {
    if (!widget.isHost) return;
    final pos = _videoController?.value.position.inSeconds.toDouble() ?? 0;
    await _hubConnection?.invoke('SendPlaybackEvent',
        args: [widget.partyCode, type, pos]);
  }

  Future<void> _sendChatMessage() async {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;
    await _hubConnection?.invoke('SendChatMessage', args: [widget.partyCode, text]);
    _chatController.clear();
  }

  Future<void> _sendReaction(String emoji) async {
    await _hubConnection?.invoke('SendReaction', args: [widget.partyCode, emoji]);
  }

  @override
  void dispose() {
    _hubConnection?.stop();
    _videoController?.dispose();
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(colors),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: _buildVideoSection(colors)),
                  if (_showChat) _buildChatPanel(colors),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(OttColors colors) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: colors.surface),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: colors.textPrimary,
          ),
          const SizedBox(width: 8),
          Icon(Icons.group, color: colors.primary, size: 20),
          const SizedBox(width: 8),
          Text('Watch Party', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: colors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Text(widget.partyCode, style: TextStyle(color: colors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          // Member avatars
          SizedBox(
            width: 80,
            child: Stack(
              children: _members.take(3).indexed.map((entry) {
                final (i, member) = entry;
                return Positioned(
                  left: i * 20.0,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: member.avatarUrl != null ? NetworkImage(member.avatarUrl!) : null,
                    backgroundColor: colors.primary,
                    child: member.avatarUrl == null ? Text(member.userName[0], style: const TextStyle(fontSize: 10)) : null,
                  ),
                );
              }).toList(),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _showChat = !_showChat),
            icon: Icon(_showChat ? Icons.chat_bubble : Icons.chat_bubble_outline),
            color: colors.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection(OttColors colors) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            child: Center(
              child: _videoController?.value.isInitialized == true
                  ? AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ),
        _buildVideoControls(colors),
        _buildReactionBar(colors),
      ],
    );
  }

  Widget _buildVideoControls(OttColors colors) {
    if (!widget.isHost) {
      return Container(
        height: 48,
        color: colors.surface,
        child: Center(
          child: Text('Only the host can control playback',
              style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        ),
      );
    }
    return Container(
      color: colors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (_isPlaying) {
                _videoController?.pause();
                _sendPlaybackEvent('pause');
              } else {
                _videoController?.play();
                _sendPlaybackEvent('play');
              }
              setState(() => _isPlaying = !_isPlaying);
            },
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            color: colors.textPrimary,
          ),
          Expanded(
            child: VideoProgressIndicator(
              _videoController ?? VideoPlayerController.networkUrl(Uri.parse('')),
              allowScrubbing: true,
              colors: VideoProgressColors(playedColor: colors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionBar(OttColors colors) {
    const reactions = ['❤️', '😂', '😮', '🎉', '👏', '🔥'];
    return Container(
      height: 48,
      color: colors.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: reactions.map((emoji) => GestureDetector(
          onTap: () => _sendReaction(emoji),
          child: Text(emoji, style: const TextStyle(fontSize: 22)),
        )).toList(),
      ),
    );
  }

  Widget _buildChatPanel(OttColors colors) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: colors.divider)),
        color: colors.surface,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('Chat', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, i) => _buildChatBubble(_messages[i], colors),
            ),
          ),
          _buildChatInput(colors),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage msg, OttColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage: msg.avatarUrl != null ? NetworkImage(msg.avatarUrl!) : null,
            backgroundColor: colors.primary,
            child: msg.avatarUrl == null ? Text(msg.userName[0], style: const TextStyle(fontSize: 10)) : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(msg.userName, style: TextStyle(color: colors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(msg.message, style: TextStyle(color: colors.textPrimary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput(OttColors colors) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chatController,
              style: TextStyle(color: colors.textPrimary, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Say something...',
                hintStyle: TextStyle(color: colors.textSecondary, fontSize: 13),
                filled: true,
                fillColor: colors.background,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              ),
              onSubmitted: (_) => _sendChatMessage(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendChatMessage,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String userName;
  final String message;
  final String? avatarUrl;
  final DateTime timestamp;
  const ChatMessage({required this.userName, required this.message, this.avatarUrl, required this.timestamp});
}

class PartyMember {
  final String userId;
  final String userName;
  final String? avatarUrl;
  const PartyMember({required this.userId, required this.userName, this.avatarUrl});
}
