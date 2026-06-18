import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/theme/app_theme.dart';
import '../../blocs/content/content_bloc.dart';
import '../../../data/models/content.dart';
import '../../widgets/cards/content_card.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/common/gradient_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  int _heroBannerIndex = 0;
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<ContentBloc>().add(ContentLoadHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = Theme.of(context).extension<OttColors>()!;

    return Scaffold(
      backgroundColor: colors.bg,
      body: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          if (state is ContentLoadingState) return _buildShimmer(context);
          if (state is ContentErrorState) return _buildError(context, state.message);
          if (state is ContentHomeLoadedState) return _buildHome(context, state);
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHome(BuildContext context, ContentHomeLoadedState state) {
    final colors = Theme.of(context).extension<OttColors>()!;

    return RefreshIndicator(
      color: colors.primary,
      backgroundColor: colors.surface,
      onRefresh: () async => context.read<ContentBloc>().add(ContentLoadHomeEvent()),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ── Sticky transparent header ──
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: AppHeader(scrollController: _scrollController),
            ),
          ),

          // ── Hero Banner Carousel ──
          SliverToBoxAdapter(child: _buildHeroBanner(context, state.banners, colors)),

          // ── Content Rows ──
          SliverList(
            delegate: SliverChildBuilderDelegate((ctx, i) {
              final row = state.rows[i];
              return _ContentRow(row: row);
            }, childCount: state.rows.length),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context, List<Banner> banners, OttColors colors) {
    if (banners.isEmpty) return const SizedBox.shrink();
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 768;
    final heroHeight = isTablet ? size.height * 0.65 : size.height * 0.55;

    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          options: CarouselOptions(
            height: heroHeight,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 6),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOutCubic,
            onPageChanged: (i, _) => setState(() => _heroBannerIndex = i),
          ),
          itemBuilder: (_, i, __) => _HeroBannerItem(banner: banners[i]),
        ),

        // Page indicator
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: _heroBannerIndex,
              count: banners.length,
              effect: ExpandingDotsEffect(
                activeDotColor: colors.primary,
                dotColor: colors.textSecondary.withOpacity(0.4),
                dotHeight: 4,
                dotWidth: 8,
                expansionFactor: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Shimmer.fromColors(
      baseColor: colors.shimmerBase,
      highlightColor: colors.shimmerHighlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          Container(height: 400, color: Colors.white),
          const SizedBox(height: 24),
          ...List.generate(3, (_) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.only(left: 16), child: Container(height: 20, width: 160, color: Colors.white)),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  padding: const EdgeInsets.only(left: 16),
                  itemBuilder: (_, __) => Container(width: 100, height: 140, margin: const EdgeInsets.only(right: 10), decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white)),
                ),
              ),
            ]),
          )),
        ]),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.error_outline, color: colors.textSecondary, size: 64),
        const SizedBox(height: 16),
        Text(message, style: TextStyle(color: colors.textSecondary), textAlign: TextAlign.center),
        const SizedBox(height: 24),
        GradientButton(label: 'Retry', onPressed: () => context.read<ContentBloc>().add(ContentLoadHomeEvent())),
      ]),
    );
  }
}

class _HeroBannerItem extends StatelessWidget {
  final Banner banner;
  const _HeroBannerItem({required this.banner});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;
    final imageUrl = (!isPortrait && banner.mobileImageUrl == null) ? banner.imageUrl : (banner.mobileImageUrl ?? banner.imageUrl);

    return GestureDetector(
      onTap: () {
        if (banner.linkType == 'Content' && banner.linkValue != null) {
          context.push('/content/${banner.linkValue}');
        } else if (banner.linkType == 'Live' && banner.linkValue != null) {
          context.push('/live/play/${banner.linkValue}');
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Container(color: colors.surface),
          ),
          DecoratedBox(decoration: BoxDecoration(gradient: colors.heroGradient)),
          Positioned(
            bottom: 36,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (banner.title != null)
                  Text(banner.title!, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, shadows: [const Shadow(offset: Offset(0, 2), blurRadius: 8)]), maxLines: 2, overflow: TextOverflow.ellipsis),
                if (banner.subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(banner.subtitle!, style: TextStyle(color: colors.textSecondary, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
                if (banner.buttonText != null) ...[
                  const SizedBox(height: 16),
                  Row(children: [
                    GradientButton(label: banner.buttonText!, onPressed: () {
                      if (banner.linkType == 'Content' && banner.linkValue != null) context.push('/content/${banner.linkValue}');
                    }),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('My List'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentRow extends StatelessWidget {
  final ContentRow row;
  const _ContentRow({required this.row});

  @override
  Widget build(BuildContext context) {
    if (row.items.isEmpty) return const SizedBox.shrink();
    final colors = Theme.of(context).extension<OttColors>()!;
    final isFeatured = row.rowType == 'Featured';
    final cardHeight = isFeatured ? 180.0 : 140.0;
    final cardWidth = isFeatured ? 300.0 : 100.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Expanded(child: Text(row.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700))),
              if (row.items.length > 5)
                TextButton(onPressed: () {}, child: Text('See All', style: TextStyle(color: colors.primary, fontSize: 12))),
            ]),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: cardHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: row.items.length,
              itemBuilder: (ctx, i) => ContentCard(
                content: row.items[i],
                width: cardWidth,
                height: cardHeight,
                showProgress: row.rowType == 'ContinueWatching',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    return Container(
      color: Colors.black.withOpacity(t * 0.95),
      child: child,
    );
  }

  @override double get minExtent => 60;
  @override double get maxExtent => 60;
  @override bool shouldRebuild(covariant SliverPersistentHeaderDelegate old) => false;
}
