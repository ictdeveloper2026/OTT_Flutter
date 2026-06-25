import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/content.dart';

// ── ContentCard ────────────────────────────────────────────────────────────────

class ContentCard extends StatelessWidget {
  final ContentListItem content;
  final double? width;
  final double? height;
  final bool showTitle;
  final bool showRating;
  final bool landscape;
  final VoidCallback? onTap;

  const ContentCard({
    super.key,
    required this.content,
    this.width,
    this.height,
    this.showTitle = true,
    this.showRating = false,
    this.landscape = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final imageUrl = landscape ? (content.thumbnailUrl ?? content.posterUrl) : (content.posterUrl ?? content.thumbnailUrl);

    return GestureDetector(
      onTap: onTap ?? () => context.push('/content/${content.id}'),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: colors.surface,
                        child: Icon(Icons.movie, color: colors.textSecondary, size: 40),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: colors.surface,
                        child: Icon(Icons.movie, color: colors.textSecondary, size: 40),
                      ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                            stops: const [0.6, 1.0],
                          ),
                        ),
                      ),
                    ),
                    // Badges
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((content.isNewRelease ?? false))
                            _buildBadge('NEW', Colors.green),
                          if ((content.isTrending ?? false)) ...[
                            if ((content.isNewRelease ?? false)) const SizedBox(height: 4),
                            _buildBadge('🔥', colors.primary),
                          ],
                        ],
                      ),
                    ),
                    if (content.accessTier == 'tvod' || content.accessTier == 'paid')
                      Positioned(
                        top: 6,
                        right: 6,
                        child: _buildBadge('₹${content.price?.toStringAsFixed(0) ?? ""}', colors.primary),
                      ),
                    if (showRating && content.averageRating != null)
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 12),
                            const SizedBox(width: 2),
                            Text(content.averageRating!.toStringAsFixed(1),
                                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (showTitle) ...[
              const SizedBox(height: 6),
              Text(
                content.title,
                style: TextStyle(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (content.releaseYear != null)
                Text(
                  '${content.releaseYear}',
                  style: TextStyle(color: colors.textSecondary, fontSize: 11),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                )),
                if (subtitle != null)
                  Text(subtitle!, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          if (trailing != null) trailing!,
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Row(
                children: [
                  Text('See all', style: TextStyle(color: colors.primary, fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 2),
                  Icon(Icons.chevron_right, color: colors.primary, size: 18),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ── Gradient Button ───────────────────────────────────────────────────────────

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;
  final List<Color>? gradientColors;
  final TextStyle? textStyle;

  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.gradientColors,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final gradient = gradientColors ?? [colors.primary, colors.primary.withRed(180)];

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: colors.primary.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(label, style: textStyle ?? const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
        ),
      ),
    );
  }
}

// ── App Header ────────────────────────────────────────────────────────────────

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showSearch;
  final bool showNotification;
  final bool showLogo;
  final List<Widget>? actions;
  final Widget? leading;

  const AppHeader({
    super.key,
    this.title,
    this.showSearch = true,
    this.showNotification = true,
    this.showLogo = false,
    this.actions,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return AppBar(
      backgroundColor: colors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading,
      title: showLogo
          ? Row(
              children: [
                Icon(Icons.play_circle_filled, color: colors.primary, size: 28),
                const SizedBox(width: 8),
                Text(title ?? 'OTT Platform', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            )
          : title != null
              ? Text(title!, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold))
              : null,
      actions: [
        ...?actions,
        if (showSearch)
          IconButton(
            icon: Icon(Icons.search, color: colors.textPrimary),
            onPressed: () => context.push('/search'),
          ),
        if (showNotification)
          _NotificationBell(colors: colors),
        const SizedBox(width: 4),
      ],
    );
  }
}

class _NotificationBell extends StatelessWidget {
  final OttColors colors;
  const _NotificationBell({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: colors.textPrimary),
          onPressed: () => context.push('/notifications'),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}

// ── Content Row Widget ────────────────────────────────────────────────────────

class ContentRowWidget extends StatelessWidget {
  final ContentRowData row;
  const ContentRowWidget({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    if (row.items.isEmpty) return const SizedBox.shrink();

    final isLandscape = row.displayStyle == 'landscape';
    final cardWidth = isLandscape ? 200.0 : 130.0;
    final cardHeight = isLandscape ? 115.0 : 195.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: row.title,
          onSeeAll: row.items.length > 5 ? () {} : null,
        ),
        SizedBox(
          height: cardHeight + (isLandscape ? 0 : 45),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: row.items.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: ContentCard(
                  content: row.items[i],
                  landscape: isLandscape,
                  showTitle: !isLandscape,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Loading Shimmer ───────────────────────────────────────────────────────────

class ShimmerCard extends StatefulWidget {
  final double width;
  final double height;
  const ShimmerCard({super.key, required this.width, required this.height});

  @override
  State<ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<ShimmerCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment(_animation.value - 1, 0),
            end: Alignment(_animation.value + 1, 0),
            colors: [colors.surface, colors.surface.withOpacity(0.5), colors.surface],
          ),
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 72, color: colors.textSecondary.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(subtitle!, style: TextStyle(color: colors.textSecondary, fontSize: 14), textAlign: TextAlign.center),
          ],
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 24),
            GradientButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}

// ── Parental Control Pin Dialog ───────────────────────────────────────────────

Future<bool> showPinDialog(BuildContext context) async {
  final colors = Theme.of(context).extension<OttColors>()!;
  final controllers = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: colors.surface,
      title: Text('Enter PIN', style: TextStyle(color: colors.textPrimary)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (i) => SizedBox(
          width: 48,
          child: TextField(
            controller: controllers[i],
            focusNode: focusNodes[i],
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 1,
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: colors.background,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: colors.primary)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: colors.primary, width: 2)),
            ),
            onChanged: (val) {
              if (val.isNotEmpty && i < 3) focusNodes[i + 1].requestFocus();
              if (i == 3 && val.isNotEmpty) {
                final pin = controllers.map((c) => c.text).join();
                if (pin.length == 4) Navigator.pop(context, true);
              }
            },
          ),
        )),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel', style: TextStyle(color: colors.textSecondary))),
      ],
    ),
  );
  for (final c in controllers) c.dispose();
  for (final f in focusNodes) f.dispose();
  return result ?? false;
}
