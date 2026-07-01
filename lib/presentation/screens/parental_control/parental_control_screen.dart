import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';

class ParentalControlScreen extends StatefulWidget {
  const ParentalControlScreen({super.key});

  @override
  State<ParentalControlScreen> createState() => _ParentalControlScreenState();
}

class _ParentalControlScreenState extends State<ParentalControlScreen> {
  final _api = sl<ApiService>();
  String _selectedMaturity = 'all';
  bool _requirePin = false;
  bool _isPinSet = false;
  bool _isLoading = false;
  bool _initialLoading = true;
  bool _blockViolence = false;
  bool _blockLanguage = false;
  bool _blockSexualContent = false;
  String? _newPin; // captured when the admin sets/changes the PIN this session

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final pc = await _api.getParentalControl();
      if (!mounted) return;
      setState(() {
        final m = (pc['maturityLevel'] ?? 'all').toString();
        _selectedMaturity = _levels.containsKey(m) ? m : 'all';
        _requirePin = pc['requirePin'] == true;
        _isPinSet = pc['isPinSet'] == true;
        _blockViolence = pc['blockViolence'] == true;
        _blockLanguage = pc['blockLanguage'] == true;
        _blockSexualContent = pc['blockSexualContent'] == true;
        _initialLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _initialLoading = false);
    }
  }

  final Map<String, _MaturityLevel> _levels = {
    'kids': _MaturityLevel('Kids', 'Ages 0-12. G and PG rated content only.', Icons.child_care, Colors.green),
    'teen': _MaturityLevel('Teen', 'Ages 13+. PG-13 and TV-14 rated content.', Icons.school, Colors.blue),
    'all': _MaturityLevel('Adult', 'All content including R-rated.', Icons.person, Colors.orange),
  };

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text('Parental Controls', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: colors.textPrimary), onPressed: () => context.pop()),
        elevation: 0,
      ),
      body: _initialLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoBanner(colors),
            const SizedBox(height: 24),
            _buildMaturitySection(colors),
            const SizedBox(height: 24),
            _buildPinSection(colors),
            const SizedBox(height: 24),
            _buildBlockedContent(colors),
            const SizedBox(height: 32),
            GradientButton(
              label: 'Save Settings',
              isLoading: _isLoading,
              onPressed: _saveSettings,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner(OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.family_restroom, color: colors.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Keep your family safe', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
                Text('Set viewing restrictions and PIN protection for profiles.',
                    style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaturitySection(OttColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Maturity Level', style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('Choose the maximum content rating allowed', style: TextStyle(color: colors.textSecondary, fontSize: 13)),
        const SizedBox(height: 16),
        ..._levels.entries.map((entry) {
          final key = entry.key;
          final level = entry.value;
          final isSelected = _selectedMaturity == key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => setState(() => _selectedMaturity = key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? level.color.withOpacity(0.12) : colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? level.color : colors.divider,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: level.color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(level.icon, color: level.color, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(level.label, style: TextStyle(
                            color: isSelected ? level.color : colors.textPrimary,
                            fontWeight: FontWeight.bold,
                          )),
                          Text(level.description, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle, color: level.color),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPinSection(OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, color: colors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PIN Protection', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
                    Text('Require PIN to access this profile', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Switch(value: _requirePin, onChanged: (v) => setState(() => _requirePin = v), activeThumbColor: colors.primary),
            ],
          ),
          if (_requirePin) ...[
            Divider(color: colors.divider),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.pin, color: colors.textSecondary),
              title: Text(_isPinSet ? 'Change PIN' : 'Set PIN',
                  style: TextStyle(color: colors.textPrimary)),
              trailing: Icon(Icons.chevron_right, color: colors.textSecondary),
              onTap: () async {
                final pin = await _promptPin();
                if (pin != null) setState(() { _newPin = pin; _isPinSet = true; });
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBlockedContent(OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Additional Restrictions', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _restrictionRow(colors, 'Block Violence', _blockViolence, (v) => setState(() => _blockViolence = v)),
          _restrictionRow(colors, 'Block Strong Language', _blockLanguage, (v) => setState(() => _blockLanguage = v)),
          _restrictionRow(colors, 'Block Sexual Content', _blockSexualContent, (v) => setState(() => _blockSexualContent = v)),
        ],
      ),
    );
  }

  Widget _restrictionRow(OttColors colors, String label, bool value, ValueChanged<bool> onChanged) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(children: [
          Icon(Icons.block, color: colors.textSecondary, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: TextStyle(color: colors.textPrimary, fontSize: 14))),
          Switch(value: value, onChanged: onChanged, activeThumbColor: colors.primary),
        ]),
      );

  Future<String?> _promptPin() async {
    final ctrl = TextEditingController();
    final colors = Theme.of(context).extension<OttColors>()!;
    return showDialog<String>(
      context: context,
      builder: (dctx) => AlertDialog(
        backgroundColor: colors.surface,
        title: const Text('Set a 4-digit PIN'),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 4,
          decoration: const InputDecoration(counterText: '', hintText: '••••'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().length == 4) Navigator.pop(dctx, ctrl.text.trim());
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);
    try {
      await _api.saveParentalControl({
        'maturityLevel': _selectedMaturity,
        'requirePin': _requirePin,
        'blockViolence': _blockViolence,
        'blockLanguage': _blockLanguage,
        'blockSexualContent': _blockSexualContent,
        if (_requirePin && _newPin != null) 'pin': _newPin,
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Parental controls saved!'), backgroundColor: Colors.green),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}

class _MaturityLevel {
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  const _MaturityLevel(this.label, this.description, this.icon, this.color);
}
