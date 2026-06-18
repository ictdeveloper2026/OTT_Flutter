import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/blocs/profile/profile_bloc.dart';
import '../../../data/models/content.dart';
import '../../../core/theme/app_theme.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});
  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfilesLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileActive) {
              context.go('/home');
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileListLoaded) {
                return _buildProfileList(context, state.profiles, theme, ott);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileList(BuildContext context, List<UserProfile> profiles, ThemeData theme, OttColors ott) {
    return Column(
      children: [
        const Spacer(),
        Text("Who's watching?", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 48),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          alignment: WrapAlignment.center,
          children: [
            ...profiles.map((p) => _profileTile(context, p, theme, ott)),
            // Add Profile tile
            if (profiles.length < 5)
              _addProfileTile(context, theme, ott),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () => context.go('/auth/login'),
          child: Text('Sign Out', style: TextStyle(color: ott.textSecondary)),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _profileTile(BuildContext context, UserProfile profile, ThemeData theme, OttColors ott) {
    return GestureDetector(
      onTap: () {
        if (profile.hasPin == true) {
          _showPinDialog(context, profile);
        } else {
          context.read<ProfileBloc>().add(ProfileSelected(profileId: profile.id));
        }
      },
      child: SizedBox(
        width: 110,
        child: Column(
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ott.surface,
                border: Border.all(color: Colors.transparent, width: 3),
              ),
              clipBehavior: Clip.antiAlias,
              child: profile.avatarUrl != null
                  ? Image.network(profile.avatarUrl!, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        profile.name.isNotEmpty ? profile.name[0].toUpperCase() : '?',
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            Text(profile.name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
            if (profile.isKid == true)
              const SizedBox(height: 4),
            if (profile.isKid == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(8)),
                child: const Text('KIDS', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _addProfileTile(BuildContext context, ThemeData theme, OttColors ott) {
    return GestureDetector(
      onTap: () => _showAddProfileDialog(context),
      child: SizedBox(
        width: 110,
        child: Column(
          children: [
            Container(
              width: 88, height: 88,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ott.textSecondary.withOpacity(0.4), width: 2),
              ),
              child: Icon(Icons.add, size: 36, color: ott.textSecondary),
            ),
            const SizedBox(height: 10),
            Text('Add Profile', style: theme.textTheme.bodyMedium?.copyWith(color: ott.textSecondary)),
          ],
        ),
      ),
    );
  }

  void _showPinDialog(BuildContext context, UserProfile profile) {
    String pin = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enter PIN'),
        content: TextField(
          autofocus: true,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 4,
          onChanged: (v) => pin = v,
          decoration: const InputDecoration(hintText: '4-digit PIN'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileBloc>().add(ProfilePinVerified(profileId: profile.id, pin: pin));
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showAddProfileDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    bool isKid = false;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setDialog) => AlertDialog(
          title: const Text('New Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
              const SizedBox(height: 12),
              Row(children: [
                const Text("Kids' profile"),
                const Spacer(),
                Switch(value: isKid, onChanged: (v) => setDialog(() => isKid = v)),
              ]),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.read<ProfileBloc>().add(ProfileCreated(name: nameCtrl.text.trim(), isKid: isKid));
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
