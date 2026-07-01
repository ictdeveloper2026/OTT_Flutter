import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../../data/repositories/community_repository.dart';

/// Admin management for the Community feature: moderate suggestions (set status /
/// promote to a poll) and create/close/delete polls.
class CommunityAdminScreen extends StatefulWidget {
  const CommunityAdminScreen({super.key});
  @override
  State<CommunityAdminScreen> createState() => _CommunityAdminScreenState();
}

class _CommunityAdminScreenState extends State<CommunityAdminScreen> {
  final _repo = sl<CommunityRepository>();
  List<Suggestion> _suggestions = [];
  List<Poll> _polls = [];
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
      final results = await Future.wait([
        _repo.adminGetSuggestions(),
        _repo.getPolls(status: 'all'),
      ]);
      if (!mounted) return;
      setState(() {
        _suggestions = results[0] as List<Suggestion>;
        _polls = results[1] as List<Poll>;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  void _toast(String m) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m))); }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colors.bg,
        appBar: AppBar(
          title: const Text('Community'),
          bottom: const TabBar(tabs: [Tab(text: 'Suggestions'), Tab(text: 'Polls')]),
          actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _load)],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showCreatePoll(),
          icon: const Icon(Icons.add_chart),
          label: const Text('New poll'),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text('Failed to load: $_error', style: TextStyle(color: colors.textSecondary)))
                : TabBarView(children: [_suggestionsList(colors), _pollsList(colors)]),
      ),
    );
  }

  // ── Suggestions ──
  Widget _suggestionsList(OttColors colors) {
    if (_suggestions.isEmpty) return Center(child: Text('No suggestions', style: TextStyle(color: colors.textSecondary)));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _suggestions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final s = _suggestions[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Column(children: [
              Icon(Icons.arrow_upward_rounded, size: 16, color: colors.textSecondary),
              Text('${s.upvoteCount}', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.title, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
              Text(s.status, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
            ])),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (a) => _onSuggestionAction(a, s),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'planned', child: Text('Mark Planned')),
                PopupMenuItem(value: 'added', child: Text('Mark Added')),
                PopupMenuItem(value: 'rejected', child: Text('Mark Rejected')),
                PopupMenuItem(value: 'promote', child: Text('Promote to poll')),
                PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
              ],
            ),
          ]),
        );
      },
    );
  }

  Future<void> _onSuggestionAction(String action, Suggestion s) async {
    try {
      if (action == 'delete') {
        await _repo.adminDeleteSuggestion(s.id);
        _toast('Deleted');
      } else if (action == 'promote') {
        await _showPromote(s);
        return;
      } else {
        await _repo.adminSetSuggestionStatus(s.id, action);
        _toast('Status updated');
      }
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  Future<void> _showPromote(Suggestion s) async {
    final questionCtrl = TextEditingController(text: s.title);
    final optionsCtrl = TextEditingController(text: 'Yes, add this\nNo');
    final ok = await _pollDialog(title: 'Promote to poll', questionCtrl: questionCtrl, optionsCtrl: optionsCtrl);
    if (ok != true) return;
    try {
      await _repo.adminPromoteSuggestion(
        s.id,
        question: questionCtrl.text.trim(),
        options: _parseOptions(optionsCtrl.text),
      );
      _toast('Poll created from suggestion');
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  // ── Polls ──
  Widget _pollsList(OttColors colors) {
    if (_polls.isEmpty) return Center(child: Text('No polls yet', style: TextStyle(color: colors.textSecondary)));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _polls.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final p = _polls[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(p.question, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600))),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (a) => _onPollAction(a, p),
                itemBuilder: (_) => [
                  if (!p.isClosed) const PopupMenuItem(value: 'close', child: Text('Close poll')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                ],
              ),
            ]),
            const SizedBox(height: 4),
            Text('${p.totalVotes} votes · ${p.isClosed ? 'closed' : 'open'}', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
            const SizedBox(height: 6),
            ...p.options.map((o) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(children: [
                    Expanded(child: Text(o.text, style: TextStyle(color: colors.textSecondary, fontSize: 13))),
                    Text('${o.voteCount}', style: TextStyle(color: colors.textSecondary, fontSize: 13)),
                  ]),
                )),
          ]),
        );
      },
    );
  }

  Future<void> _onPollAction(String action, Poll p) async {
    try {
      if (action == 'close') {
        await _repo.adminUpdatePoll(p.id, status: 'closed');
        _toast('Poll closed');
      } else if (action == 'delete') {
        await _repo.adminDeletePoll(p.id);
        _toast('Poll deleted');
      }
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  Future<void> _showCreatePoll() async {
    final questionCtrl = TextEditingController();
    final optionsCtrl = TextEditingController();
    final ok = await _pollDialog(title: 'New poll', questionCtrl: questionCtrl, optionsCtrl: optionsCtrl);
    if (ok != true) return;
    final options = _parseOptions(optionsCtrl.text);
    if (questionCtrl.text.trim().isEmpty || options.length < 2) { _toast('Need a question and at least 2 options'); return; }
    try {
      await _repo.adminCreatePoll(question: questionCtrl.text.trim(), options: options);
      _toast('Poll created');
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  Future<bool?> _pollDialog({required String title, required TextEditingController questionCtrl, required TextEditingController optionsCtrl}) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return showDialog<bool>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(title),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: questionCtrl, decoration: const InputDecoration(labelText: 'Question *')),
          const SizedBox(height: 8),
          TextField(controller: optionsCtrl, maxLines: 4, decoration: const InputDecoration(labelText: 'Options (one per line, min 2)')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(dctx, true), child: const Text('Save')),
        ],
      ),
    );
  }

  List<String> _parseOptions(String raw) =>
      raw.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
}
