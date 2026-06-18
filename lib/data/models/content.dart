import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

// ── Branding Config ──
@freezed
abstract class BrandingConfig with _$BrandingConfig {
  const BrandingConfig._();

  const factory BrandingConfig({
    @Default(0) int id,
    @Default(0) int tenantId,
    String? logoUrl,
    String? faviconUrl,
    @Default('#E50914') String primaryColor,
    @Default('#141414') String secondaryColor,
    @Default('#F5C518') String accentColor,
    @Default('#000000') String backgroundColor,
    @Default('#1A1A1A') String surfaceColor,
    @Default('#FFFFFF') String textPrimaryColor,
    @Default('#B3B3B3') String textSecondaryColor,
    @Default('Poppins') String fontFamily,
    String? appName,
    String? appTagline,
    String? splashImageUrl,
    @Default('dark') String themeMode,
  }) = _BrandingConfig;

  factory BrandingConfig.fromJson(Map<String, dynamic> json) => _$BrandingConfigFromJson(json);

  /// Safe fallback used by ThemeBloc when the API is unreachable.
  factory BrandingConfig.defaultConfig() => const BrandingConfig();
}

// ── Content ──
@freezed
abstract class Content with _$Content {
  const factory Content({
    required int id,
    required String title,
    required String slug,
    required String type,
    required String accessTier,
    String? description,
    String? shortDescription,
    String? thumbnailUrl,
    String? posterUrl,
    String? bannerUrl,
    String? trailerUrl,
    String? trailerType,
    String? trailerVideoId,
    int? releaseYear,
    int? durationSeconds,
    String? contentRating,
    String? status,
    double? averageRating,
    int? totalRatings,
    int? totalViews,
    bool? isFeatured,
    bool? isTrending,
    bool? isNewRelease,
    bool? isOriginal,
    String? languageName,
    List<String>? genres,
    List<CastMember>? cast,
    SeriesInfo? seriesInfo,
    VideoAsset? videoAsset,
    List<Subtitle>? subtitles,
    List<AudioTrack>? audioTracks,
    WatchProgress? watchProgress,
    bool? isInWatchlist,
    String? userRating,
    double? imdbRating,
    String? imdbId,
  }) = _Content;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
}

@freezed
abstract class CastMember with _$CastMember {
  const factory CastMember({
    required int id,
    required String personName,
    required String role,
    String? characterName,
    String? photoUrl,
    int? sortOrder,
  }) = _CastMember;
  factory CastMember.fromJson(Map<String, dynamic> json) => _$CastMemberFromJson(json);
}

@freezed
abstract class SeriesInfo with _$SeriesInfo {
  const factory SeriesInfo({
    required int seriesId,
    required int totalSeasons,
    required int totalEpisodes,
    required String status,
    List<Season>? seasons,
  }) = _SeriesInfo;
  factory SeriesInfo.fromJson(Map<String, dynamic> json) => _$SeriesInfoFromJson(json);
}

@freezed
abstract class Season with _$Season {
  const factory Season({
    required int id,
    required int seasonNumber,
    String? title,
    int? year,
    int? episodeCount,
    List<Episode>? episodes,
  }) = _Season;
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
}

@freezed
abstract class Episode with _$Episode {
  const factory Episode({
    required int id,
    required int episodeNumber,
    required String title,
    String? description,
    int? durationSeconds,
    String? thumbnailUrl,
    int? contentId,
    WatchProgress? watchProgress,
  }) = _Episode;
  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
}

@freezed
abstract class VideoAsset with _$VideoAsset {
  const factory VideoAsset({
    required int id,
    required String playerType,
    required String status,
    String? hlsManifestUrl,
    String? youTubeVideoId,
    String? vimeoVideoId,
    List<VideoQuality>? qualities,
  }) = _VideoAsset;
  factory VideoAsset.fromJson(Map<String, dynamic> json) => _$VideoAssetFromJson(json);
}

@freezed
abstract class VideoQuality with _$VideoQuality {
  const factory VideoQuality({
    required String resolution,
    int? bitrate,
    bool? isReady,
  }) = _VideoQuality;
  factory VideoQuality.fromJson(Map<String, dynamic> json) => _$VideoQualityFromJson(json);
}

@freezed
abstract class Subtitle with _$Subtitle {
  const factory Subtitle({
    required int id,
    required String languageCode,
    required String label,
    required String format,
    required String s3Url,
    bool? isDefault,
  }) = _Subtitle;
  factory Subtitle.fromJson(Map<String, dynamic> json) => _$SubtitleFromJson(json);
}

@freezed
abstract class AudioTrack with _$AudioTrack {
  const factory AudioTrack({
    required int id,
    required String languageCode,
    required String label,
    required int trackIndex,
    bool? isDefault,
  }) = _AudioTrack;
  factory AudioTrack.fromJson(Map<String, dynamic> json) => _$AudioTrackFromJson(json);
}

@freezed
abstract class WatchProgress with _$WatchProgress {
  const factory WatchProgress({
    required int watchedSeconds,
    required int totalSeconds,
    required double completionPct,
    bool? isCompleted,
    DateTime? lastWatchedAt,
  }) = _WatchProgress;
  factory WatchProgress.fromJson(Map<String, dynamic> json) => _$WatchProgressFromJson(json);
}

// ── Live Stream ──
@freezed
abstract class LiveStream with _$LiveStream {
  const factory LiveStream({
    required int id,
    required String title,
    required String status,
    required String streamType,
    required String accessTier,
    String? description,
    String? thumbnailUrl,
    String? playbackUrl,
    String? youTubeLiveId,
    String? vimeoEventId,
    double? ppvPrice,
    int? currentViewers,
    int? totalViewers,
    DateTime? scheduledAt,
    DateTime? startedAt,
    bool? chatEnabled,
    bool? dvrEnabled,
  }) = _LiveStream;
  factory LiveStream.fromJson(Map<String, dynamic> json) => _$LiveStreamFromJson(json);
}

// ── Subscription Plan ──
@freezed
abstract class SubscriptionPlan with _$SubscriptionPlan {
  const factory SubscriptionPlan({
    required int id,
    required String name,
    required double price,
    required String currency,
    required String billingCycle,
    int? trialDays,
    int? maxProfiles,
    int? maxDevices,
    String? maxQuality,
    bool? allowDownload,
    bool? adFree,
    List<String>? features,
    bool? isActive,
  }) = _SubscriptionPlan;
  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanFromJson(json);
}

// ── User Subscription ──
@freezed
abstract class UserSubscription with _$UserSubscription {
  const factory UserSubscription({
    required int id,
    required SubscriptionPlan plan,
    required String status,
    required DateTime startDate,
    required DateTime endDate,
    bool? autoRenew,
    String? gatewayType,
  }) = _UserSubscription;
  factory UserSubscription.fromJson(Map<String, dynamic> json) => _$UserSubscriptionFromJson(json);
}

// ── User Profile ──
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String displayName,
    String? avatarUrl,
    String? avatarColor,
    bool? isKids,
    String? maxContentRating,
    String? languageCode,
    bool? isDefault,
    int? dailyTimeLimitMinutes,
  }) = _UserProfile;
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

// ── Banner ──
@freezed
abstract class Banner with _$Banner {
  const factory Banner({
    required int id,
    String? title,
    String? subtitle,
    required String imageUrl,
    String? mobileImageUrl,
    String? linkType,
    String? linkValue,
    String? buttonText,
    int? sortOrder,
  }) = _Banner;
  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
}

// ── Home Row ──
@freezed
abstract class ContentRow with _$ContentRow {
  const factory ContentRow({
    required int id,
    required String title,
    required String rowType,
    required List<Content> items,
    int? maxItems,
  }) = _ContentRow;
  factory ContentRow.fromJson(Map<String, dynamic> json) => _$ContentRowFromJson(json);
}

// ── Notification ──
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required int id,
    required String title,
    required String body,
    required String type,
    String? deepLink,
    String? imageUrl,
    bool? isRead,
    DateTime? createdAt,
  }) = _AppNotification;
  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}

// ── Watch Party ──
@freezed
abstract class WatchParty with _$WatchParty {
  const factory WatchParty({
    required String code,
    required int contentId,
    required String status,
    required bool isPlaying,
    required int currentPosition,
    required int memberCount,
    required bool isHost,
    List<WatchPartyMember>? members,
  }) = _WatchParty;
  factory WatchParty.fromJson(Map<String, dynamic> json) => _$WatchPartyFromJson(json);
}

@freezed
abstract class WatchPartyMember with _$WatchPartyMember {
  const factory WatchPartyMember({
    required int userId,
    required String displayName,
    String? avatarUrl,
    required bool isHost,
  }) = _WatchPartyMember;
  factory WatchPartyMember.fromJson(Map<String, dynamic> json) => _$WatchPartyMemberFromJson(json);
}

// ── Pagination Wrapper ──
@Freezed(genericArgumentFactories: true)
abstract class PagedResult<T> with _$PagedResult<T> {
  const factory PagedResult({
    required List<T> items,
    required int totalCount,
    required int page,
    required int pageSize,
    required bool hasMore,
  }) = _PagedResult<T>;

  factory PagedResult.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PagedResultFromJson(json, fromJsonT);
}
