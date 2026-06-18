import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../presentation/blocs/admin/admin_bloc.dart';
import '../../../data/models/content.dart';
import '../../../core/theme/app_theme.dart';

class AdminContentScreen extends StatefulWidget {
  const AdminContentScreen({super.key});
  @override
  State<AdminContentScreen> createState() => _AdminContentScreenState();
}

class _AdminContentScreenState extends State<AdminContentScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(AdminContentListLoaded());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/admin/content/upload'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => context.read<AdminBloc>().add(AdminContentListLoaded(search: v)),
              decoration: InputDecoration(
                hintText: 'Search content...',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: ott.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) return const Center(child: CircularProgressIndicator());
          if (state is AdminContentListReady) return _buildList(context, state.contents, theme, ott);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Content> contents, ThemeData theme, OttColors ott) {
    if (contents.isEmpty) return const Center(child: Text('No content found'));
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: contents.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final content = contents[i];
        return Container(
          decoration: BoxDecoration(color: ott.surface, borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: content.thumbnailUrl != null
                  ? CachedNetworkImage(imageUrl: content.thumbnailUrl!, width: 60, height: 45, fit: BoxFit.cover)
                  : Container(width: 60, height: 45, color: Colors.grey[800], child: const Icon(Icons.movie, color: Colors.white38)),
            ),
            title: Text(content.title, style: const TextStyle(fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('${content.contentType?.toUpperCase()} • ${content.releaseYear ?? '—'}', style: TextStyle(color: ott.textSecondary, fontSize: 12)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Active toggle
                Switch(
                  value: content.isActive ?? true,
                  onChanged: (v) => context.read<AdminBloc>().add(AdminContentToggled(contentId: content.id, isActive: v)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 20),
                  onSelected: (action) {
                    if (action == 'edit') context.go('/admin/content/upload', extra: {'contentId': content.id});
                    if (action == 'delete') _confirmDelete(context, content);
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18), SizedBox(width: 8), Text('Edit')])),
                    PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, size: 18, color: Colors.red), SizedBox(width: 8), Text('Delete', style: TextStyle(color: Colors.red))])),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Content content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Content'),
        content: Text('Delete "${content.title}"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AdminBloc>().add(AdminContentDeleted(contentId: content.id));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
