import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/theme/app_theme.dart';

/// Create or edit a subscription plan. Pass an existing plan map to edit; omit to
/// create. Pops `true` on a successful save so the list can refresh.
class PlanEditScreen extends StatefulWidget {
  final Map<String, dynamic>? plan;
  const PlanEditScreen({super.key, this.plan});

  @override
  State<PlanEditScreen> createState() => _PlanEditScreenState();
}

class _PlanEditScreenState extends State<PlanEditScreen> {
  final _api = sl<ApiService>();
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _profilesCtrl = TextEditingController(text: '1');
  final _streamsCtrl = TextEditingController(text: '1');
  final _featuresCtrl = TextEditingController();
  final _razorpayCtrl = TextEditingController();

  String _currency = 'INR';
  String _billing = 'monthly';
  bool _allowDownloads = false;
  bool _allowUhd = false;
  bool _isPopular = false;
  bool _isActive = true;
  bool _saving = false;

  final _currencies = ['INR', 'USD', 'EUR', 'GBP', 'AED'];
  final _cycles = ['monthly', 'quarterly', 'yearly', 'weekly'];

  bool get _isEdit => widget.plan != null;

  @override
  void initState() {
    super.initState();
    final p = widget.plan;
    if (p != null) {
      _nameCtrl.text = (p['name'] ?? '').toString();
      _descCtrl.text = (p['description'] ?? '').toString();
      _priceCtrl.text = (p['price'] ?? '').toString();
      _profilesCtrl.text = (p['maxProfiles'] ?? 1).toString();
      _streamsCtrl.text = (p['maxStreams'] ?? 1).toString();
      _razorpayCtrl.text = (p['razorpayPlanId'] ?? '').toString();
      final c = (p['currency'] ?? 'INR').toString();
      _currency = _currencies.contains(c) ? c : 'INR';
      final b = (p['billingCycle'] ?? 'monthly').toString();
      _billing = _cycles.contains(b) ? b : 'monthly';
      _allowDownloads = p['allowDownloads'] == true;
      _allowUhd = p['allowUhd'] == true;
      _isPopular = p['isPopular'] == true;
      _isActive = p['isActive'] != false;
      final feats = p['features'];
      if (feats is List) _featuresCtrl.text = feats.join('\n');
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _descCtrl.dispose(); _priceCtrl.dispose();
    _profilesCtrl.dispose(); _streamsCtrl.dispose(); _featuresCtrl.dispose(); _razorpayCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final data = {
        'name': _nameCtrl.text.trim(),
        'description': _descCtrl.text.trim(),
        'price': double.tryParse(_priceCtrl.text.trim()) ?? 0,
        'currency': _currency,
        'billingCycle': _billing,
        'maxProfiles': int.tryParse(_profilesCtrl.text.trim()) ?? 1,
        'maxStreams': int.tryParse(_streamsCtrl.text.trim()) ?? 1,
        'allowDownloads': _allowDownloads,
        'allowUhd': _allowUhd,
        'isPopular': _isPopular,
        'isActive': _isActive,
        'features': _featuresCtrl.text.split('\n').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        if (_razorpayCtrl.text.trim().isNotEmpty) 'razorpayPlanId': _razorpayCtrl.text.trim(),
      };
      if (_isEdit) {
        await _api.adminUpdatePlan(widget.plan!['id'].toString(), data);
      } else {
        await _api.adminCreatePlan(data);
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Plan' : 'New Plan'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save'),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(padding: const EdgeInsets.all(20), children: [
          _field(_nameCtrl, 'Plan name *', required: true),
          const SizedBox(height: 12),
          TextFormField(controller: _descCtrl, maxLines: 2, decoration: const InputDecoration(labelText: 'Description')),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _field(_priceCtrl, 'Price *', keyboard: TextInputType.number, required: true, numeric: true)),
            const SizedBox(width: 12),
            Expanded(child: _dropdown('Currency', _currency, _currencies, (v) => setState(() => _currency = v!))),
          ]),
          const SizedBox(height: 12),
          _dropdown('Billing cycle', _billing, _cycles, (v) => setState(() => _billing = v!)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _field(_profilesCtrl, 'Max profiles', keyboard: TextInputType.number, numeric: true)),
            const SizedBox(width: 12),
            Expanded(child: _field(_streamsCtrl, 'Max streams', keyboard: TextInputType.number, numeric: true)),
          ]),
          const SizedBox(height: 8),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: Text('Allow downloads', style: TextStyle(color: colors.textPrimary)), value: _allowDownloads, onChanged: (v) => setState(() => _allowDownloads = v)),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: Text('Allow 4K / UHD', style: TextStyle(color: colors.textPrimary)), value: _allowUhd, onChanged: (v) => setState(() => _allowUhd = v)),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: Text('Mark as popular', style: TextStyle(color: colors.textPrimary)), value: _isPopular, onChanged: (v) => setState(() => _isPopular = v)),
          SwitchListTile(contentPadding: EdgeInsets.zero, title: Text('Active (visible to users)', style: TextStyle(color: colors.textPrimary)), value: _isActive, onChanged: (v) => setState(() => _isActive = v)),
          const SizedBox(height: 12),
          TextFormField(controller: _featuresCtrl, maxLines: 4, decoration: const InputDecoration(labelText: 'Features (one per line)', alignLabelWithHint: true)),
          const SizedBox(height: 12),
          _field(_razorpayCtrl, 'Razorpay plan ID (optional)'),
        ]),
      ),
    );
  }

  Widget _field(TextEditingController c, String label, {bool required = false, bool numeric = false, TextInputType? keyboard}) =>
      TextFormField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label),
        validator: (v) {
          if (required && (v == null || v.trim().isEmpty)) return 'Required';
          if (numeric && v != null && v.trim().isNotEmpty && num.tryParse(v.trim()) == null) return 'Must be a number';
          return null;
        },
      );

  Widget _dropdown(String label, String value, List<String> options, ValueChanged<String?> onChanged) =>
      DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(labelText: label),
        dropdownColor: Theme.of(context).extension<OttColors>()!.surface,
        items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
        onChanged: onChanged,
      );
}
