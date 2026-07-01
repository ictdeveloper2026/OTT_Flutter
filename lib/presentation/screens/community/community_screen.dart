import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../blocs/community/community_bloc.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

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
        ),
        body: BlocConsumer<CommunityBloc, CommunityState>(
          listenWhen: (a, b) => b is CommunityLoaded && b.actionError != null,
          listener: (context, state) {
            final msg = (state as CommunityLoaded).actionError!;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Theme.of(context).colorScheme.error));
          },
          builder: (context, state) {
            if (state is CommunityLoading || state is CommunityInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CommunityError) {
              return _ErrorRetry(message: state.message);
            }
            final loaded = state as CommunityLoaded;
            return TabBarView(children: [
              _SuggestionsTab(loaded: loaded),
              _PollsTab(loaded: loaded),
            ]);
          },
        ),
      ),
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  final String message;
  const _ErrorRetry({required this.message});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.cloud_off, color: colors.textSecondary, size: 48),
        const SizedBox(height: 12),
        Text(message, style: TextStyle(color: colors.textSecondary)),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () => context.read<CommunityBloc>().add(CommunityLoadRequested()), child: const Text('Retry')),
      ]),
    );
  }
}

// ── Suggestions ──────────────────────────────────────────────────────────────
class _SuggestionsTab extends StatelessWidget {
  final CommunityLoaded loaded;
  const _SuggestionsTab({required this.loaded});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSubmit(context),
        icon: const Icon(Icons.add),
        label: const Text('Suggest'),
      ),
      body: Column(children: [
        // Sort toggle
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(children: [
            for (final s in const [('top', 'Top'), ('new', 'Newest')])
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(s.$2),
                  selected: loaded.sort == s.$1,
                  onSelected: (_) => context.read<CommunityBloc>().add(CommunitySortChanged(s.$1)),
                ),
              ),
          ]),
        ),
        Expanded(
          child: loaded.suggestions.isEmpty
              ? Center(child: Text('No suggestions yet — be the first!', style: TextStyle(color: colors.textSecondary)))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: loaded.suggestions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => _SuggestionCard(s: loaded.suggestions[i]),
                ),
        ),
      ]),
    );
  }

  void _showSubmit(BuildContext context) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final colors = Theme.of(context).extension<OttColors>()!;
    showDialog(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: colors.surface,
        title: const Text('Suggest a title'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'What should we add? *')),
          const SizedBox(height: 8),
          TextField(controller: descCtrl, maxLines: 3, decoration: const InputDecoration(labelText: 'Why / details (optional)')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleCtrl.text.trim().isEmpty) return;
              context.read<CommunityBloc>().add(SuggestionSubmitted(title: titleCtrl.text.trim(), description: descCtrl.text.trim()));
              Navigator.pop(dctx);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final Suggestion s;
  const _SuggestionCard({required this.s});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Upvote pill
        InkWell(
          onTap: () => context.read<CommunityBloc>().add(SuggestionUpvoteToggled(s.id)),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 52,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: s.hasVoted ? colors.primary : colors.textSecondary.withOpacity(0.3)),
              color: s.hasVoted ? colors.primary.withOpacity(0.15) : Colors.transparent,
            ),
            child: Column(children: [
              Icon(Icons.arrow_upward_rounded, size: 18, color: s.hasVoted ? colors.primary : colors.textSecondary),
              Text('${s.upvoteCount}', style: TextStyle(color: s.hasVoted ? colors.primary : colors.textPrimary, fontWeight: FontWeight.bold)),
            ]),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(s.title, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
          if (s.description != null && s.description!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(s.description!, style: TextStyle(color: colors.textSecondary, fontSize: 13), maxLines: 3, overflow: TextOverflow.ellipsis),
          ],
          const SizedBox(height: 6),
          _StatusChip(status: s.status),
        ])),
      ]),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final (label, color) = switch (status) {
      'planned' => ('Planned', Colors.orangeAccent),
      'added' => ('Added', Colors.green),
      'rejected' => ('Not planned', colors.textSecondary),
      'promoted' => ('In a poll', colors.primary),
      _ => ('Open', colors.textSecondary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

// ── Polls ────────────────────────────────────────────────────────────────────
class _PollsTab extends StatelessWidget {
  final CommunityLoaded loaded;
  const _PollsTab({required this.loaded});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    if (loaded.polls.isEmpty) {
      return Center(child: Text('No active polls right now.', style: TextStyle(color: colors.textSecondary)));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: loaded.polls.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _PollCard(poll: loaded.polls[i]),
    );
  }
}

class _PollCard extends StatelessWidget {
  final Poll poll;
  const _PollCard({required this.poll});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final showResults = poll.hasVoted || poll.isClosed;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(poll.question, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
        if (poll.description != null && poll.description!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(poll.description!, style: TextStyle(color: colors.textSecondary, fontSize: 13)),
        ],
        const SizedBox(height: 12),
        ...poll.options.map((o) => _PollOptionRow(poll: poll, option: o, showResults: showResults)),
        const SizedBox(height: 6),
        Text(
          '${poll.totalVotes} vote${poll.totalVotes == 1 ? '' : 's'}${poll.isClosed ? ' · closed' : ''}',
          style: TextStyle(color: colors.textSecondary, fontSize: 12),
        ),
      ]),
    );
  }
}

class _PollOptionRow extends StatelessWidget {
  final Poll poll;
  final PollOption option;
  final bool showResults;
  const _PollOptionRow({required this.poll, required this.option, required this.showResults});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final selected = poll.myOptionId == option.id;
    final pct = poll.totalVotes == 0 ? 0.0 : option.voteCount / poll.totalVotes;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: poll.isClosed ? null : () => context.read<CommunityBloc>().add(PollVoted(pollId: poll.id, optionId: option.id)),
        borderRadius: BorderRadius.circular(8),
        child: Stack(children: [
          // result fill
          if (showResults)
            FractionallySizedBox(
              widthFactor: pct.clamp(0.0, 1.0),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: (selected ? colors.primary : colors.textSecondary).withOpacity(0.20),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: selected ? colors.primary : colors.textSecondary.withOpacity(0.3)),
            ),
            child: Row(children: [
              if (selected) Padding(padding: const EdgeInsets.only(right: 6), child: Icon(Icons.check_circle, size: 16, color: colors.primary)),
              Expanded(child: Text(option.text, style: TextStyle(color: colors.textPrimary))),
              if (showResults) Text('${(pct * 100).round()}%', style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w600)),
            ]),
          ),
        ]),
      ),
    );
  }
}
