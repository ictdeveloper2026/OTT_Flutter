import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/injection.dart';
import '../../../core/error/failure.dart';
import '../../../core/network/api_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/iptv_channel.dart';
import '../../../data/repositories/subscription_repository.dart';

/// Browse free IPTV "Live TV" channels (iptv-org) with country/language filters,
/// search and infinite-scroll paging. Admins get a sync action in the app bar.
class LiveTvChannelsScreen extends StatefulWidget {
  const LiveTvChannelsScreen({super.key});

  @override
  State<LiveTvChannelsScreen> createState() => _LiveTvChannelsScreenState();
}

class _LiveTvChannelsScreenState extends State<LiveTvChannelsScreen> {
  final LiveRepository _repo = sl<LiveRepository>();
  final AdminRepository _admin = sl<AdminRepository>();
  final ApiService _api = sl<ApiService>();

  ChannelFilters _filters = ChannelFilters.empty;
  String? _country, _language;
  final _q = TextEditingController();

  List<IptvChannel> _channels = [];
  int _page = 1, _total = 0;
  bool _loading = true, _loadingMore = false;
  bool _isAdmin = false, _syncing = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _q.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    _isAdmin = await _api.isAdmin();
    if (mounted) setState(() {});
    try {
      _filters = await _repo.getChannelFilters();
    } catch (_) {/* filters are optional */}
    await _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _page = 1;
    });
    try {
      final r = await _repo.getChannels(country: _country, language: _language, q: _q.text, page: 1);
      if (!mounted) return;
      setState(() {
        _channels = r.items;
        _total = r.total;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendlyError(e))));
    }
  }

  Future<void> _more() async {
    if (_loadingMore || _channels.length >= _total) return;
    setState(() => _loadingMore = true);
    try {
      final r = await _repo.getChannels(country: _country, language: _language, q: _q.text, page: _page + 1);
      if (!mounted) return;
      setState(() {
        _page++;
        _channels.addAll(r.items);
        _loadingMore = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _sync() async {
    setState(() => _syncing = true);
    try {
      final msg = await _admin.syncLiveTv();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(friendlyError(e))));
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      backgroundColor: ott.bg,
      appBar: AppBar(
        title: Text('Live TV${_total > 0 ? ' ($_total)' : ''}'),
        actions: [
          if (_isAdmin)
            IconButton(
              tooltip: 'Sync channels',
              onPressed: _syncing ? null : _sync,
              icon: _syncing
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.sync),
            ),
        ],
      ),
      body: Column(
        children: [
          _filterBar(ott),
          const SizedBox(height: 8),
          Expanded(child: _grid(ott)),
          if (_loadingMore)
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(color: ott.primary, strokeWidth: 2),
            ),
        ],
      ),
    );
  }

  Widget _filterBar(OttColors ott) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: DropdownButtonFormField<String?>(
                initialValue: _country,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Country', isDense: true),
                items: [
                  const DropdownMenuItem<String?>(value: null, child: Text('All countries')),
                  ..._filters.countries.map((c) => DropdownMenuItem<String?>(
                        value: c.code,
                        child: Text(c.label, overflow: TextOverflow.ellipsis),
                      )),
                ],
                onChanged: (v) {
                  setState(() => _country = v);
                  _load();
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String?>(
                initialValue: _language,
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Language', isDense: true),
                items: [
                  const DropdownMenuItem<String?>(value: null, child: Text('All languages')),
                  ..._filters.languages.map((l) => DropdownMenuItem<String?>(
                        value: l.code,
                        child: Text('${l.code.toUpperCase()} (${l.count})', overflow: TextOverflow.ellipsis),
                      )),
                ],
                onChanged: (v) {
                  setState(() => _language = v);
                  _load();
                },
              ),
            ),
          ]),
          const SizedBox(height: 8),
          TextField(
            controller: _q,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _load(),
            decoration: InputDecoration(
              hintText: 'Search channels…',
              isDense: true,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(icon: const Icon(Icons.arrow_forward), onPressed: _load),
            ),
          ),
        ],
      ),
    );
  }

  Widget _grid(OttColors ott) {
    if (_loading) return Center(child: CircularProgressIndicator(color: ott.primary));
    if (_channels.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.tv_off_outlined, size: 56, color: ott.textSecondary),
              const SizedBox(height: 12),
              Text(
                _isAdmin
                    ? 'No channels yet.\nTap sync to pull them from iptv-org.'
                    : 'No channels yet.\nAn admin can sync them from here.',
                textAlign: TextAlign.center,
                style: TextStyle(color: ott.textSecondary),
              ),
            ],
          ),
        ),
      );
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n.metrics.pixels >= n.metrics.maxScrollExtent - 300) _more();
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 160,
          childAspectRatio: 1.2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _channels.length,
        itemBuilder: (_, i) => _ChannelTile(channel: _channels[i]),
      ),
    );
  }
}

class _ChannelTile extends StatelessWidget {
  final IptvChannel channel;
  const _ChannelTile({required this.channel});

  @override
  Widget build(BuildContext context) {
    final ott = Theme.of(context).extension<OttColors>()!;
    final logo = channel.logoUrl ?? '';
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => context.push('/livetv/play', extra: {'url': channel.streamUrl ?? '', 'title': channel.name}),
      child: Container(
        decoration: BoxDecoration(color: ott.surface, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: logo.isEmpty
                  ? Icon(Icons.tv, color: ott.textSecondary, size: 36)
                  : Image.network(
                      logo,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(Icons.tv, color: ott.textSecondary, size: 36),
                    ),
            ),
            const SizedBox(height: 6),
            Text(channel.name,
                maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            if (channel.subtitle.isNotEmpty)
              Text(channel.subtitle,
                  maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, color: ott.textSecondary)),
          ],
        ),
      ),
    );
  }
}
