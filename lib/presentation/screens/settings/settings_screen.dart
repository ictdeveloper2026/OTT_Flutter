import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/blocs/auth/auth_bloc.dart';
import '../../../presentation/blocs/subscription/subscription_bloc.dart';
import '../../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _SectionHeader(title: 'Account'),
          _SettingsTile(icon: Icons.person_outline, title: 'Profile', onTap: () => context.go('/profile')),
          _SettingsTile(icon: Icons.credit_card_outlined, title: 'Billing & Subscription', onTap: () => context.go('/billing')),
          _SettingsTile(icon: Icons.notifications_outlined, title: 'Notifications', onTap: () {}),
          _SettingsTile(icon: Icons.lock_outline, title: 'Change Password', onTap: () {}),
          const Divider(),
          _SectionHeader(title: 'Preferences'),
          _SettingsTile(icon: Icons.language_outlined, title: 'Language', onTap: () {}),
          _SettingsTile(icon: Icons.subtitles_outlined, title: 'Subtitles', onTap: () {}),
          _SettingsTile(icon: Icons.data_usage_outlined, title: 'Data & Storage', onTap: () {}),
          _SettingsTile(icon: Icons.child_care_outlined, title: 'Parental Control', onTap: () => context.go('/parental-control')),
          const Divider(),
          _SectionHeader(title: 'Support'),
          _SettingsTile(icon: Icons.help_outline, title: 'Help Center', onTap: () {}),
          _SettingsTile(icon: Icons.info_outline, title: 'About', onTap: () {}),
          _SettingsTile(icon: Icons.policy_outlined, title: 'Privacy Policy', onTap: () {}),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Sign Out'),
                content: const Text('Are you sure you want to sign out?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                      context.go('/auth/login');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(child: Text('StreamVault v1.0.0', style: TextStyle(color: ott.textSecondary, fontSize: 12))),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.5)),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final String? subtitle;

  const _SettingsTile({required this.icon, required this.title, required this.onTap, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
