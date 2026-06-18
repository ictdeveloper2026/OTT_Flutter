import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/models/content.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../widgets/common/gradient_button.dart';
import '../../widgets/common/section_header.dart';

class BrandingScreen extends StatefulWidget {
  const BrandingScreen({super.key});

  @override
  State<BrandingScreen> createState() => _BrandingScreenState();
}

class _BrandingScreenState extends State<BrandingScreen> {
  final _formKey = GlobalKey<FormState>();
  BrandingConfig? _branding;
  bool _saving = false;

  late TextEditingController _appNameCtrl;
  late TextEditingController _taglineCtrl;
  late TextEditingController _primaryCtrl;
  late TextEditingController _secondaryCtrl;
  late TextEditingController _accentCtrl;
  late TextEditingController _bgCtrl;
  late TextEditingController _surfaceCtrl;
  late TextEditingController _textPrimaryCtrl;
  late TextEditingController _textSecondaryCtrl;
  String _fontFamily = 'Poppins';
  String _themeMode = 'dark';

  final List<String> _fonts = ['Poppins', 'Inter', 'Roboto', 'Nunito', 'Montserrat', 'Lato', 'Raleway', 'Playfair Display'];
  final List<String> _themeModes = ['dark', 'light', 'system'];

  @override
  void initState() {
    super.initState();
    final b = context.read<ThemeBloc>().state.branding;
    _branding = b;
    _appNameCtrl = TextEditingController(text: b?.appName ?? 'StreamFlix');
    _taglineCtrl = TextEditingController(text: b?.appTagline ?? '');
    _primaryCtrl = TextEditingController(text: b?.primaryColor ?? '#E50914');
    _secondaryCtrl = TextEditingController(text: b?.secondaryColor ?? '#141414');
    _accentCtrl = TextEditingController(text: b?.accentColor ?? '#F5C518');
    _bgCtrl = TextEditingController(text: b?.backgroundColor ?? '#000000');
    _surfaceCtrl = TextEditingController(text: b?.surfaceColor ?? '#1A1A1A');
    _textPrimaryCtrl = TextEditingController(text: b?.textPrimaryColor ?? '#FFFFFF');
    _textSecondaryCtrl = TextEditingController(text: b?.textSecondaryColor ?? '#B3B3B3');
    _fontFamily = b?.fontFamily ?? 'Poppins';
    _themeMode = b?.themeMode ?? 'dark';
  }

  @override
  void dispose() {
    _appNameCtrl.dispose(); _taglineCtrl.dispose(); _primaryCtrl.dispose();
    _secondaryCtrl.dispose(); _accentCtrl.dispose(); _bgCtrl.dispose();
    _surfaceCtrl.dispose(); _textPrimaryCtrl.dispose(); _textSecondaryCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final updated = BrandingConfig(
      id: _branding?.id ?? 0,
      tenantId: _branding?.tenantId ?? 1,
      appName: _appNameCtrl.text,
      appTagline: _taglineCtrl.text,
      primaryColor: _primaryCtrl.text,
      secondaryColor: _secondaryCtrl.text,
      accentColor: _accentCtrl.text,
      backgroundColor: _bgCtrl.text,
      surfaceColor: _surfaceCtrl.text,
      textPrimaryColor: _textPrimaryCtrl.text,
      textSecondaryColor: _textSecondaryCtrl.text,
      fontFamily: _fontFamily,
      themeMode: _themeMode,
      logoUrl: _branding?.logoUrl,
      faviconUrl: _branding?.faviconUrl,
    );
    context.read<ThemeBloc>().add(ThemeSaveEvent(updated));
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Branding saved & applied live!'),
      backgroundColor: Theme.of(context).extension<OttColors>()!.primary,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;

    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        title: const Text('Branding & Theme'),
        actions: [
          GradientButton(label: 'Save & Apply', onPressed: _save, loading: _saving),
          const SizedBox(width: 16),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            // ── Live Preview ──
            _LivePreview(primary: _primaryCtrl.text, secondary: _secondaryCtrl.text, accent: _accentCtrl.text, bg: _bgCtrl.text, surface: _surfaceCtrl.text, textPrimary: _textPrimaryCtrl.text, appName: _appNameCtrl.text),
            const SizedBox(height: 28),

            // ── App Identity ──
            const SectionHeader(title: 'App Identity'),
            const SizedBox(height: 12),
            Row(children: [
              _LogoUploadBox(label: 'Logo', url: _branding?.logoUrl, onPick: (_) {}),
              const SizedBox(width: 16),
              _LogoUploadBox(label: 'Favicon', url: _branding?.faviconUrl, onPick: (_) {}),
              const SizedBox(width: 16),
              _LogoUploadBox(label: 'Splash', url: _branding?.splashImageUrl, onPick: (_) {}),
            ]),
            const SizedBox(height: 16),
            _Field(ctrl: _appNameCtrl, label: 'App Name', hint: 'StreamFlix'),
            const SizedBox(height: 12),
            _Field(ctrl: _taglineCtrl, label: 'Tagline', hint: 'Stream Anything. Anywhere.'),
            const SizedBox(height: 28),

            // ── Typography ──
            const SectionHeader(title: 'Typography'),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _fontFamily,
              decoration: const InputDecoration(labelText: 'Font Family'),
              dropdownColor: colors.surface,
              items: _fonts.map((f) => DropdownMenuItem(value: f, child: Text(f, style: TextStyle(color: colors.textPrimary)))).toList(),
              onChanged: (v) => setState(() => _fontFamily = v!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _themeMode,
              decoration: const InputDecoration(labelText: 'Theme Mode'),
              dropdownColor: colors.surface,
              items: _themeModes.map((m) => DropdownMenuItem(value: m, child: Text(m.toUpperCase(), style: TextStyle(color: colors.textPrimary)))).toList(),
              onChanged: (v) => setState(() => _themeMode = v!),
            ),
            const SizedBox(height: 28),

            // ── Colors ──
            const SectionHeader(title: 'Color Palette'),
            const SizedBox(height: 12),
            _ColorGrid(children: [
              _ColorField(ctrl: _primaryCtrl, label: 'Primary', hint: '#E50914', onChanged: (_) => setState(() {})),
              _ColorField(ctrl: _secondaryCtrl, label: 'Secondary', hint: '#141414', onChanged: (_) => setState(() {})),
              _ColorField(ctrl: _accentCtrl, label: 'Accent', hint: '#F5C518', onChanged: (_) => setState(() {})),
              _ColorField(ctrl: _bgCtrl, label: 'Background', hint: '#000000', onChanged: (_) => setState(() {})),
              _ColorField(ctrl: _surfaceCtrl, label: 'Surface', hint: '#1A1A1A', onChanged: (_) => setState(() {})),
              _ColorField(ctrl: _textPrimaryCtrl, label: 'Text Primary', hint: '#FFFFFF', onChanged: (_) => setState(() {})),
              _ColorField(ctrl: _textSecondaryCtrl, label: 'Text Secondary', hint: '#B3B3B3', onChanged: (_) => setState(() {})),
            ]),
            const SizedBox(height: 32),
          ]),
        ),
      ),
    );
  }
}

class _LivePreview extends StatelessWidget {
  final String primary, secondary, accent, bg, surface, textPrimary, appName;
  const _LivePreview({required this.primary, required this.secondary, required this.accent, required this.bg, required this.surface, required this.textPrimary, required this.appName});

  Color _parse(String hex, Color fallback) {
    try { return Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16)); } catch (_) { return fallback; }
  }

  @override
  Widget build(BuildContext context) {
    final p = _parse(primary, Colors.red);
    final b = _parse(bg, Colors.black);
    final s = _parse(surface, const Color(0xFF1A1A1A));
    final tp = _parse(textPrimary, Colors.white);

    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        Container(
          height: 48,
          color: b,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            Container(width: 28, height: 28, decoration: BoxDecoration(color: p, borderRadius: BorderRadius.circular(6))),
            const SizedBox(width: 8),
            Text(appName.isEmpty ? 'StreamFlix' : appName, style: TextStyle(color: tp, fontWeight: FontWeight.w800, fontSize: 15)),
            const Spacer(),
            const Icon(Icons.search, color: Colors.white54, size: 20),
            const SizedBox(width: 12),
            CircleAvatar(radius: 14, backgroundColor: Colors.white12, child: Icon(Icons.person, size: 16, color: tp)),
          ]),
        ),
        Expanded(
          child: Container(color: b, padding: const EdgeInsets.all(12), child: Row(children: [
            Container(width: 80, height: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: s)),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 120, height: 12, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: tp.withOpacity(0.8))),
              const SizedBox(height: 8),
              Container(width: 80, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: tp.withOpacity(0.4))),
              const SizedBox(height: 12),
              Container(height: 32, padding: const EdgeInsets.symmetric(horizontal: 14), decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: p), alignment: Alignment.center, child: Text('Watch Now', style: TextStyle(color: tp, fontSize: 11, fontWeight: FontWeight.w600))),
            ])),
          ])),
        ),
      ]),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label, hint;
  const _Field({required this.ctrl, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: ctrl,
    decoration: InputDecoration(labelText: label, hintText: hint),
    validator: (v) => v == null || v.isEmpty ? 'Required' : null,
  );
}

class _ColorGrid extends StatelessWidget {
  final List<Widget> children;
  const _ColorGrid({required this.children});

  @override
  Widget build(BuildContext context) {
    final cols = MediaQuery.of(context).size.width > 600 ? 3 : 2;
    return Wrap(spacing: 12, runSpacing: 12, children: children.map((c) => SizedBox(width: (MediaQuery.of(context).size.width - 40 - (cols - 1) * 12) / cols, child: c)).toList());
  }
}

class _ColorField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label, hint;
  final void Function(String) onChanged;
  const _ColorField({required this.ctrl, required this.label, required this.hint, required this.onChanged});

  Color? _parse(String hex) {
    try { return Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16)); } catch (_) { return null; }
  }

  @override
  Widget build(BuildContext context) {
    final color = _parse(ctrl.text);
    return TextFormField(
      controller: ctrl,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Container(margin: const EdgeInsets.all(8), width: 28, height: 28, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: color ?? Colors.grey, border: Border.all(color: Colors.white24))),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Required';
        if (_parse(v) == null) return 'Invalid hex';
        return null;
      },
    );
  }
}

class _LogoUploadBox extends StatelessWidget {
  final String label;
  final String? url;
  final void Function(String) onPick;
  const _LogoUploadBox({required this.label, this.url, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        final file = await picker.pickImage(source: ImageSource.gallery);
        if (file != null) onPick(file.path);
      },
      child: Column(children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white24, style: BorderStyle.solid, width: 1.5)),
          child: url != null
              ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(url!, fit: BoxFit.contain))
              : const Icon(Icons.add_photo_alternate_outlined, color: Colors.white38, size: 32),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ]),
    );
  }
}
