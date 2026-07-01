import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/theme/app_theme.dart';

// ── Promo codes ─────────────────────────────────────────────────────────────
class AdminPromosScreen extends StatefulWidget {
  const AdminPromosScreen({super.key});
  @override
  State<AdminPromosScreen> createState() => _AdminPromosScreenState();
}

class _AdminPromosScreenState extends State<AdminPromosScreen> {
  final _api = sl<ApiService>();
  List<Map<String, dynamic>> _promos = [];
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
      final raw = await _api.adminGetPromos();
      if (!mounted) return;
      setState(() { _promos = raw.map((e) => Map<String, dynamic>.from(e)).toList(); _loading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  Future<void> _create() async {
    final codeCtrl = TextEditingController();
    final valueCtrl = TextEditingController(text: '10');
    final maxUsesCtrl = TextEditingController();
    String discountType = 'percentage';
    final colors = Theme.of(context).extension<OttColors>()!;

    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => StatefulBuilder(
        builder: (dctx, setLocal) => AlertDialog(
          backgroundColor: colors.surface,
          title: const Text('New promo code'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: codeCtrl, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Code * (e.g. WELCOME10)')),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: discountType,
              decoration: const InputDecoration(labelText: 'Discount type'),
              dropdownColor: colors.surface,
              items: const [
                DropdownMenuItem(value: 'percentage', child: Text('Percentage (%)')),
                DropdownMenuItem(value: 'fixed', child: Text('Fixed amount')),
              ],
              onChanged: (v) => setLocal(() => discountType = v ?? 'percentage'),
            ),
            const SizedBox(height: 8),
            TextField(controller: valueCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Discount value *')),
            const SizedBox(height: 8),
            TextField(controller: maxUsesCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Max uses (optional)')),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dctx, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(dctx, true), child: const Text('Create')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    final value = double.tryParse(valueCtrl.text.trim());
    if (codeCtrl.text.trim().isEmpty || value == null) { _toast('Code and a numeric value are required'); return; }
    try {
      await _api.adminCreatePromo({
        'code': codeCtrl.text.trim(),
        'discountType': discountType,
        'discountValue': value,
        if (maxUsesCtrl.text.trim().isNotEmpty) 'maxUses': int.tryParse(maxUsesCtrl.text.trim()),
      });
      _toast('Promo created');
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  void _toast(String m) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m))); }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        icon: const Icon(Icons.add),
        label: const Text('New promo'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(message: _error!, onRetry: _load)
              : _promos.isEmpty
                  ? Center(child: Text('No promo codes yet', style: TextStyle(color: colors.textSecondary)))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _promos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final p = _promos[i];
                        final type = (p['discountType'] ?? 'percentage').toString();
                        final value = p['discountValue'];
                        final label = type == 'percentage' ? '$value% off' : '₹$value off';
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Icon(Icons.local_offer_outlined, color: colors.primary),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text((p['code'] ?? '').toString(), style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, letterSpacing: 1)),
                              Text('$label · used ${p['usedCount'] ?? 0}${p['maxUses'] != null ? '/${p['maxUses']}' : ''}',
                                  style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                            ])),
                            if (p['isActive'] == true)
                              Icon(Icons.check_circle, color: Colors.green, size: 18)
                            else
                              Icon(Icons.cancel, color: colors.textSecondary, size: 18),
                          ]),
                        );
                      },
                    ),
    );
  }
}

// ── Content rows (home layout) ──────────────────────────────────────────────
class AdminRowsScreen extends StatefulWidget {
  const AdminRowsScreen({super.key});
  @override
  State<AdminRowsScreen> createState() => _AdminRowsScreenState();
}

class _AdminRowsScreenState extends State<AdminRowsScreen> {
  final _api = sl<ApiService>();
  List<Map<String, dynamic>> _rows = [];
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
      final raw = await _api.adminGetContentRows();
      if (!mounted) return;
      setState(() { _rows = raw.map((e) => Map<String, dynamic>.from(e)).toList(); _loading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() { _error = '$e'; _loading = false; });
    }
  }

  void _toast(String m) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m))); }

  Future<void> _create() async {
    final titleCtrl = TextEditingController();
    final sourceCtrl = TextEditingController();
    String rowType = 'trending';
    String displayStyle = 'portrait';
    final colors = Theme.of(context).extension<OttColors>()!;

    final ok = await showDialog<bool>(
      context: context,
      builder: (dctx) => StatefulBuilder(
        builder: (dctx, setLocal) => AlertDialog(
          backgroundColor: colors.surface,
          title: const Text('New content row'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Row title * (e.g. Trending Now)')),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: rowType,
              decoration: const InputDecoration(labelText: 'Row type'),
              dropdownColor: colors.surface,
              items: const [
                DropdownMenuItem(value: 'trending', child: Text('Trending')),
                DropdownMenuItem(value: 'new', child: Text('New releases')),
                DropdownMenuItem(value: 'genre', child: Text('By genre')),
                DropdownMenuItem(value: 'tag', child: Text('By tag')),
                DropdownMenuItem(value: 'manual', child: Text('Manual')),
              ],
              onChanged: (v) => setLocal(() => rowType = v ?? 'trending'),
            ),
            const SizedBox(height: 8),
            if (rowType == 'genre' || rowType == 'tag')
              TextField(controller: sourceCtrl, decoration: InputDecoration(labelText: '$rowType value')),
            DropdownButtonFormField<String>(
              initialValue: displayStyle,
              decoration: const InputDecoration(labelText: 'Display style'),
              dropdownColor: colors.surface,
              items: const [
                DropdownMenuItem(value: 'portrait', child: Text('Portrait')),
                DropdownMenuItem(value: 'landscape', child: Text('Landscape')),
                DropdownMenuItem(value: 'hero', child: Text('Hero')),
              ],
              onChanged: (v) => setLocal(() => displayStyle = v ?? 'portrait'),
            ),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dctx, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(dctx, true), child: const Text('Create')),
          ],
        ),
      ),
    );
    if (ok != true) return;
    if (titleCtrl.text.trim().isEmpty) { _toast('Title is required'); return; }
    try {
      await _api.adminCreateContentRow({
        'title': titleCtrl.text.trim(),
        'rowType': rowType,
        if (sourceCtrl.text.trim().isNotEmpty) 'sourceValue': sourceCtrl.text.trim(),
        'displayStyle': displayStyle,
        'sortOrder': _rows.length,
        'maxItems': 20,
        'isActive': true,
      });
      _toast('Row created');
      await _load();
    } catch (e) {
      _toast('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _create,
        icon: const Icon(Icons.add),
        label: const Text('New row'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorView(message: _error!, onRetry: _load)
              : _rows.isEmpty
                  ? Center(child: Text('No content rows yet', style: TextStyle(color: colors.textSecondary)))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _rows.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        final r = _rows[i];
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Icon(Icons.view_list_rounded, color: colors.textSecondary),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text((r['title'] ?? '').toString(), style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
                              Text('${r['rowType'] ?? ''} · ${r['displayStyle'] ?? ''}', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                            ])),
                            if (r['isActive'] == true)
                              Icon(Icons.check_circle, color: Colors.green, size: 18)
                            else
                              Icon(Icons.cancel, color: colors.textSecondary, size: 18),
                          ]),
                        );
                      },
                    ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.cloud_off, color: colors.textSecondary, size: 44),
        const SizedBox(height: 12),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Text(message, textAlign: TextAlign.center, style: TextStyle(color: colors.textSecondary))),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
      ]),
    );
  }
}
