// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrandingConfig {
  int get id;
  int get tenantId;
  String? get logoUrl;
  String? get faviconUrl;
  String get primaryColor;
  String get secondaryColor;
  String get accentColor;
  String get backgroundColor;
  String get surfaceColor;
  String get textPrimaryColor;
  String get textSecondaryColor;
  String get fontFamily;
  String? get appName;
  String? get appTagline;
  String? get splashImageUrl;
  String get themeMode;

  /// Create a copy of BrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BrandingConfigCopyWith<BrandingConfig> get copyWith =>
      _$BrandingConfigCopyWithImpl<BrandingConfig>(
          this as BrandingConfig, _$identity);

  /// Serializes this BrandingConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BrandingConfig &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.faviconUrl, faviconUrl) ||
                other.faviconUrl == faviconUrl) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.surfaceColor, surfaceColor) ||
                other.surfaceColor == surfaceColor) &&
            (identical(other.textPrimaryColor, textPrimaryColor) ||
                other.textPrimaryColor == textPrimaryColor) &&
            (identical(other.textSecondaryColor, textSecondaryColor) ||
                other.textSecondaryColor == textSecondaryColor) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.appTagline, appTagline) ||
                other.appTagline == appTagline) &&
            (identical(other.splashImageUrl, splashImageUrl) ||
                other.splashImageUrl == splashImageUrl) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tenantId,
      logoUrl,
      faviconUrl,
      primaryColor,
      secondaryColor,
      accentColor,
      backgroundColor,
      surfaceColor,
      textPrimaryColor,
      textSecondaryColor,
      fontFamily,
      appName,
      appTagline,
      splashImageUrl,
      themeMode);

  @override
  String toString() {
    return 'BrandingConfig(id: $id, tenantId: $tenantId, logoUrl: $logoUrl, faviconUrl: $faviconUrl, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, backgroundColor: $backgroundColor, surfaceColor: $surfaceColor, textPrimaryColor: $textPrimaryColor, textSecondaryColor: $textSecondaryColor, fontFamily: $fontFamily, appName: $appName, appTagline: $appTagline, splashImageUrl: $splashImageUrl, themeMode: $themeMode)';
  }
}

/// @nodoc
abstract mixin class $BrandingConfigCopyWith<$Res> {
  factory $BrandingConfigCopyWith(
          BrandingConfig value, $Res Function(BrandingConfig) _then) =
      _$BrandingConfigCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int tenantId,
      String? logoUrl,
      String? faviconUrl,
      String primaryColor,
      String secondaryColor,
      String accentColor,
      String backgroundColor,
      String surfaceColor,
      String textPrimaryColor,
      String textSecondaryColor,
      String fontFamily,
      String? appName,
      String? appTagline,
      String? splashImageUrl,
      String themeMode});
}

/// @nodoc
class _$BrandingConfigCopyWithImpl<$Res>
    implements $BrandingConfigCopyWith<$Res> {
  _$BrandingConfigCopyWithImpl(this._self, this._then);

  final BrandingConfig _self;
  final $Res Function(BrandingConfig) _then;

  /// Create a copy of BrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tenantId = null,
    Object? logoUrl = freezed,
    Object? faviconUrl = freezed,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? accentColor = null,
    Object? backgroundColor = null,
    Object? surfaceColor = null,
    Object? textPrimaryColor = null,
    Object? textSecondaryColor = null,
    Object? fontFamily = null,
    Object? appName = freezed,
    Object? appTagline = freezed,
    Object? splashImageUrl = freezed,
    Object? themeMode = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tenantId: null == tenantId
          ? _self.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as int,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      faviconUrl: freezed == faviconUrl
          ? _self.faviconUrl
          : faviconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: null == primaryColor
          ? _self.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryColor: null == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      accentColor: null == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: null == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceColor: null == surfaceColor
          ? _self.surfaceColor
          : surfaceColor // ignore: cast_nullable_to_non_nullable
              as String,
      textPrimaryColor: null == textPrimaryColor
          ? _self.textPrimaryColor
          : textPrimaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      textSecondaryColor: null == textSecondaryColor
          ? _self.textSecondaryColor
          : textSecondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      appName: freezed == appName
          ? _self.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String?,
      appTagline: freezed == appTagline
          ? _self.appTagline
          : appTagline // ignore: cast_nullable_to_non_nullable
              as String?,
      splashImageUrl: freezed == splashImageUrl
          ? _self.splashImageUrl
          : splashImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [BrandingConfig].
extension BrandingConfigPatterns on BrandingConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_BrandingConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrandingConfig() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_BrandingConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandingConfig():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_BrandingConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandingConfig() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            int tenantId,
            String? logoUrl,
            String? faviconUrl,
            String primaryColor,
            String secondaryColor,
            String accentColor,
            String backgroundColor,
            String surfaceColor,
            String textPrimaryColor,
            String textSecondaryColor,
            String fontFamily,
            String? appName,
            String? appTagline,
            String? splashImageUrl,
            String themeMode)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BrandingConfig() when $default != null:
        return $default(
            _that.id,
            _that.tenantId,
            _that.logoUrl,
            _that.faviconUrl,
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.backgroundColor,
            _that.surfaceColor,
            _that.textPrimaryColor,
            _that.textSecondaryColor,
            _that.fontFamily,
            _that.appName,
            _that.appTagline,
            _that.splashImageUrl,
            _that.themeMode);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            int tenantId,
            String? logoUrl,
            String? faviconUrl,
            String primaryColor,
            String secondaryColor,
            String accentColor,
            String backgroundColor,
            String surfaceColor,
            String textPrimaryColor,
            String textSecondaryColor,
            String fontFamily,
            String? appName,
            String? appTagline,
            String? splashImageUrl,
            String themeMode)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandingConfig():
        return $default(
            _that.id,
            _that.tenantId,
            _that.logoUrl,
            _that.faviconUrl,
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.backgroundColor,
            _that.surfaceColor,
            _that.textPrimaryColor,
            _that.textSecondaryColor,
            _that.fontFamily,
            _that.appName,
            _that.appTagline,
            _that.splashImageUrl,
            _that.themeMode);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            int tenantId,
            String? logoUrl,
            String? faviconUrl,
            String primaryColor,
            String secondaryColor,
            String accentColor,
            String backgroundColor,
            String surfaceColor,
            String textPrimaryColor,
            String textSecondaryColor,
            String fontFamily,
            String? appName,
            String? appTagline,
            String? splashImageUrl,
            String themeMode)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BrandingConfig() when $default != null:
        return $default(
            _that.id,
            _that.tenantId,
            _that.logoUrl,
            _that.faviconUrl,
            _that.primaryColor,
            _that.secondaryColor,
            _that.accentColor,
            _that.backgroundColor,
            _that.surfaceColor,
            _that.textPrimaryColor,
            _that.textSecondaryColor,
            _that.fontFamily,
            _that.appName,
            _that.appTagline,
            _that.splashImageUrl,
            _that.themeMode);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BrandingConfig extends BrandingConfig {
  const _BrandingConfig(
      {this.id = 0,
      this.tenantId = 0,
      this.logoUrl,
      this.faviconUrl,
      this.primaryColor = '#E50914',
      this.secondaryColor = '#141414',
      this.accentColor = '#F5C518',
      this.backgroundColor = '#000000',
      this.surfaceColor = '#1A1A1A',
      this.textPrimaryColor = '#FFFFFF',
      this.textSecondaryColor = '#B3B3B3',
      this.fontFamily = 'Poppins',
      this.appName,
      this.appTagline,
      this.splashImageUrl,
      this.themeMode = 'dark'})
      : super._();
  factory _BrandingConfig.fromJson(Map<String, dynamic> json) =>
      _$BrandingConfigFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int tenantId;
  @override
  final String? logoUrl;
  @override
  final String? faviconUrl;
  @override
  @JsonKey()
  final String primaryColor;
  @override
  @JsonKey()
  final String secondaryColor;
  @override
  @JsonKey()
  final String accentColor;
  @override
  @JsonKey()
  final String backgroundColor;
  @override
  @JsonKey()
  final String surfaceColor;
  @override
  @JsonKey()
  final String textPrimaryColor;
  @override
  @JsonKey()
  final String textSecondaryColor;
  @override
  @JsonKey()
  final String fontFamily;
  @override
  final String? appName;
  @override
  final String? appTagline;
  @override
  final String? splashImageUrl;
  @override
  @JsonKey()
  final String themeMode;

  /// Create a copy of BrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BrandingConfigCopyWith<_BrandingConfig> get copyWith =>
      __$BrandingConfigCopyWithImpl<_BrandingConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BrandingConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BrandingConfig &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.faviconUrl, faviconUrl) ||
                other.faviconUrl == faviconUrl) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.surfaceColor, surfaceColor) ||
                other.surfaceColor == surfaceColor) &&
            (identical(other.textPrimaryColor, textPrimaryColor) ||
                other.textPrimaryColor == textPrimaryColor) &&
            (identical(other.textSecondaryColor, textSecondaryColor) ||
                other.textSecondaryColor == textSecondaryColor) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.appTagline, appTagline) ||
                other.appTagline == appTagline) &&
            (identical(other.splashImageUrl, splashImageUrl) ||
                other.splashImageUrl == splashImageUrl) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      tenantId,
      logoUrl,
      faviconUrl,
      primaryColor,
      secondaryColor,
      accentColor,
      backgroundColor,
      surfaceColor,
      textPrimaryColor,
      textSecondaryColor,
      fontFamily,
      appName,
      appTagline,
      splashImageUrl,
      themeMode);

  @override
  String toString() {
    return 'BrandingConfig(id: $id, tenantId: $tenantId, logoUrl: $logoUrl, faviconUrl: $faviconUrl, primaryColor: $primaryColor, secondaryColor: $secondaryColor, accentColor: $accentColor, backgroundColor: $backgroundColor, surfaceColor: $surfaceColor, textPrimaryColor: $textPrimaryColor, textSecondaryColor: $textSecondaryColor, fontFamily: $fontFamily, appName: $appName, appTagline: $appTagline, splashImageUrl: $splashImageUrl, themeMode: $themeMode)';
  }
}

/// @nodoc
abstract mixin class _$BrandingConfigCopyWith<$Res>
    implements $BrandingConfigCopyWith<$Res> {
  factory _$BrandingConfigCopyWith(
          _BrandingConfig value, $Res Function(_BrandingConfig) _then) =
      __$BrandingConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int tenantId,
      String? logoUrl,
      String? faviconUrl,
      String primaryColor,
      String secondaryColor,
      String accentColor,
      String backgroundColor,
      String surfaceColor,
      String textPrimaryColor,
      String textSecondaryColor,
      String fontFamily,
      String? appName,
      String? appTagline,
      String? splashImageUrl,
      String themeMode});
}

/// @nodoc
class __$BrandingConfigCopyWithImpl<$Res>
    implements _$BrandingConfigCopyWith<$Res> {
  __$BrandingConfigCopyWithImpl(this._self, this._then);

  final _BrandingConfig _self;
  final $Res Function(_BrandingConfig) _then;

  /// Create a copy of BrandingConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? tenantId = null,
    Object? logoUrl = freezed,
    Object? faviconUrl = freezed,
    Object? primaryColor = null,
    Object? secondaryColor = null,
    Object? accentColor = null,
    Object? backgroundColor = null,
    Object? surfaceColor = null,
    Object? textPrimaryColor = null,
    Object? textSecondaryColor = null,
    Object? fontFamily = null,
    Object? appName = freezed,
    Object? appTagline = freezed,
    Object? splashImageUrl = freezed,
    Object? themeMode = null,
  }) {
    return _then(_BrandingConfig(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tenantId: null == tenantId
          ? _self.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as int,
      logoUrl: freezed == logoUrl
          ? _self.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      faviconUrl: freezed == faviconUrl
          ? _self.faviconUrl
          : faviconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: null == primaryColor
          ? _self.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryColor: null == secondaryColor
          ? _self.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      accentColor: null == accentColor
          ? _self.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as String,
      backgroundColor: null == backgroundColor
          ? _self.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceColor: null == surfaceColor
          ? _self.surfaceColor
          : surfaceColor // ignore: cast_nullable_to_non_nullable
              as String,
      textPrimaryColor: null == textPrimaryColor
          ? _self.textPrimaryColor
          : textPrimaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      textSecondaryColor: null == textSecondaryColor
          ? _self.textSecondaryColor
          : textSecondaryColor // ignore: cast_nullable_to_non_nullable
              as String,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String,
      appName: freezed == appName
          ? _self.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String?,
      appTagline: freezed == appTagline
          ? _self.appTagline
          : appTagline // ignore: cast_nullable_to_non_nullable
              as String?,
      splashImageUrl: freezed == splashImageUrl
          ? _self.splashImageUrl
          : splashImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      themeMode: null == themeMode
          ? _self.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$Content {
  int get id;
  String get title;
  String get slug;
  String get type;
  String get accessTier;
  String? get description;
  String? get shortDescription;
  String? get thumbnailUrl;
  String? get posterUrl;
  String? get bannerUrl;
  String? get trailerUrl;
  String? get trailerType;
  String? get trailerVideoId;
  int? get releaseYear;
  int? get durationSeconds;
  String? get contentRating;
  String? get status;
  double? get averageRating;
  int? get totalRatings;
  int? get totalViews;
  bool? get isFeatured;
  bool? get isTrending;
  bool? get isNewRelease;
  bool? get isOriginal;
  String? get languageName;
  List<String>? get genres;
  List<CastMember>? get cast;
  SeriesInfo? get seriesInfo;
  VideoAsset? get videoAsset;
  List<Subtitle>? get subtitles;
  List<AudioTrack>? get audioTracks;
  WatchProgress? get watchProgress;
  bool? get isInWatchlist;
  String? get userRating;
  double? get imdbRating;
  String? get imdbId;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentCopyWith<Content> get copyWith =>
      _$ContentCopyWithImpl<Content>(this as Content, _$identity);

  /// Serializes this Content to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Content &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.accessTier, accessTier) ||
                other.accessTier == accessTier) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl) &&
            (identical(other.trailerUrl, trailerUrl) ||
                other.trailerUrl == trailerUrl) &&
            (identical(other.trailerType, trailerType) ||
                other.trailerType == trailerType) &&
            (identical(other.trailerVideoId, trailerVideoId) ||
                other.trailerVideoId == trailerVideoId) &&
            (identical(other.releaseYear, releaseYear) ||
                other.releaseYear == releaseYear) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.contentRating, contentRating) ||
                other.contentRating == contentRating) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.totalViews, totalViews) ||
                other.totalViews == totalViews) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isTrending, isTrending) ||
                other.isTrending == isTrending) &&
            (identical(other.isNewRelease, isNewRelease) ||
                other.isNewRelease == isNewRelease) &&
            (identical(other.isOriginal, isOriginal) ||
                other.isOriginal == isOriginal) &&
            (identical(other.languageName, languageName) ||
                other.languageName == languageName) &&
            const DeepCollectionEquality().equals(other.genres, genres) &&
            const DeepCollectionEquality().equals(other.cast, cast) &&
            (identical(other.seriesInfo, seriesInfo) ||
                other.seriesInfo == seriesInfo) &&
            (identical(other.videoAsset, videoAsset) ||
                other.videoAsset == videoAsset) &&
            const DeepCollectionEquality().equals(other.subtitles, subtitles) &&
            const DeepCollectionEquality()
                .equals(other.audioTracks, audioTracks) &&
            (identical(other.watchProgress, watchProgress) ||
                other.watchProgress == watchProgress) &&
            (identical(other.isInWatchlist, isInWatchlist) ||
                other.isInWatchlist == isInWatchlist) &&
            (identical(other.userRating, userRating) ||
                other.userRating == userRating) &&
            (identical(other.imdbRating, imdbRating) ||
                other.imdbRating == imdbRating) &&
            (identical(other.imdbId, imdbId) || other.imdbId == imdbId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        slug,
        type,
        accessTier,
        description,
        shortDescription,
        thumbnailUrl,
        posterUrl,
        bannerUrl,
        trailerUrl,
        trailerType,
        trailerVideoId,
        releaseYear,
        durationSeconds,
        contentRating,
        status,
        averageRating,
        totalRatings,
        totalViews,
        isFeatured,
        isTrending,
        isNewRelease,
        isOriginal,
        languageName,
        const DeepCollectionEquality().hash(genres),
        const DeepCollectionEquality().hash(cast),
        seriesInfo,
        videoAsset,
        const DeepCollectionEquality().hash(subtitles),
        const DeepCollectionEquality().hash(audioTracks),
        watchProgress,
        isInWatchlist,
        userRating,
        imdbRating,
        imdbId
      ]);

  @override
  String toString() {
    return 'Content(id: $id, title: $title, slug: $slug, type: $type, accessTier: $accessTier, description: $description, shortDescription: $shortDescription, thumbnailUrl: $thumbnailUrl, posterUrl: $posterUrl, bannerUrl: $bannerUrl, trailerUrl: $trailerUrl, trailerType: $trailerType, trailerVideoId: $trailerVideoId, releaseYear: $releaseYear, durationSeconds: $durationSeconds, contentRating: $contentRating, status: $status, averageRating: $averageRating, totalRatings: $totalRatings, totalViews: $totalViews, isFeatured: $isFeatured, isTrending: $isTrending, isNewRelease: $isNewRelease, isOriginal: $isOriginal, languageName: $languageName, genres: $genres, cast: $cast, seriesInfo: $seriesInfo, videoAsset: $videoAsset, subtitles: $subtitles, audioTracks: $audioTracks, watchProgress: $watchProgress, isInWatchlist: $isInWatchlist, userRating: $userRating, imdbRating: $imdbRating, imdbId: $imdbId)';
  }
}

/// @nodoc
abstract mixin class $ContentCopyWith<$Res> {
  factory $ContentCopyWith(Content value, $Res Function(Content) _then) =
      _$ContentCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String slug,
      String type,
      String accessTier,
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
      String? imdbId});

  $SeriesInfoCopyWith<$Res>? get seriesInfo;
  $VideoAssetCopyWith<$Res>? get videoAsset;
  $WatchProgressCopyWith<$Res>? get watchProgress;
}

/// @nodoc
class _$ContentCopyWithImpl<$Res> implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._self, this._then);

  final Content _self;
  final $Res Function(Content) _then;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = null,
    Object? type = null,
    Object? accessTier = null,
    Object? description = freezed,
    Object? shortDescription = freezed,
    Object? thumbnailUrl = freezed,
    Object? posterUrl = freezed,
    Object? bannerUrl = freezed,
    Object? trailerUrl = freezed,
    Object? trailerType = freezed,
    Object? trailerVideoId = freezed,
    Object? releaseYear = freezed,
    Object? durationSeconds = freezed,
    Object? contentRating = freezed,
    Object? status = freezed,
    Object? averageRating = freezed,
    Object? totalRatings = freezed,
    Object? totalViews = freezed,
    Object? isFeatured = freezed,
    Object? isTrending = freezed,
    Object? isNewRelease = freezed,
    Object? isOriginal = freezed,
    Object? languageName = freezed,
    Object? genres = freezed,
    Object? cast = freezed,
    Object? seriesInfo = freezed,
    Object? videoAsset = freezed,
    Object? subtitles = freezed,
    Object? audioTracks = freezed,
    Object? watchProgress = freezed,
    Object? isInWatchlist = freezed,
    Object? userRating = freezed,
    Object? imdbRating = freezed,
    Object? imdbId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accessTier: null == accessTier
          ? _self.accessTier
          : accessTier // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      shortDescription: freezed == shortDescription
          ? _self.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _self.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerUrl: freezed == bannerUrl
          ? _self.bannerUrl
          : bannerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      trailerUrl: freezed == trailerUrl
          ? _self.trailerUrl
          : trailerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      trailerType: freezed == trailerType
          ? _self.trailerType
          : trailerType // ignore: cast_nullable_to_non_nullable
              as String?,
      trailerVideoId: freezed == trailerVideoId
          ? _self.trailerVideoId
          : trailerVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseYear: freezed == releaseYear
          ? _self.releaseYear
          : releaseYear // ignore: cast_nullable_to_non_nullable
              as int?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      contentRating: freezed == contentRating
          ? _self.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      averageRating: freezed == averageRating
          ? _self.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRatings: freezed == totalRatings
          ? _self.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      totalViews: freezed == totalViews
          ? _self.totalViews
          : totalViews // ignore: cast_nullable_to_non_nullable
              as int?,
      isFeatured: freezed == isFeatured
          ? _self.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool?,
      isTrending: freezed == isTrending
          ? _self.isTrending
          : isTrending // ignore: cast_nullable_to_non_nullable
              as bool?,
      isNewRelease: freezed == isNewRelease
          ? _self.isNewRelease
          : isNewRelease // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOriginal: freezed == isOriginal
          ? _self.isOriginal
          : isOriginal // ignore: cast_nullable_to_non_nullable
              as bool?,
      languageName: freezed == languageName
          ? _self.languageName
          : languageName // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: freezed == genres
          ? _self.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cast: freezed == cast
          ? _self.cast
          : cast // ignore: cast_nullable_to_non_nullable
              as List<CastMember>?,
      seriesInfo: freezed == seriesInfo
          ? _self.seriesInfo
          : seriesInfo // ignore: cast_nullable_to_non_nullable
              as SeriesInfo?,
      videoAsset: freezed == videoAsset
          ? _self.videoAsset
          : videoAsset // ignore: cast_nullable_to_non_nullable
              as VideoAsset?,
      subtitles: freezed == subtitles
          ? _self.subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<Subtitle>?,
      audioTracks: freezed == audioTracks
          ? _self.audioTracks
          : audioTracks // ignore: cast_nullable_to_non_nullable
              as List<AudioTrack>?,
      watchProgress: freezed == watchProgress
          ? _self.watchProgress
          : watchProgress // ignore: cast_nullable_to_non_nullable
              as WatchProgress?,
      isInWatchlist: freezed == isInWatchlist
          ? _self.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool?,
      userRating: freezed == userRating
          ? _self.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as String?,
      imdbRating: freezed == imdbRating
          ? _self.imdbRating
          : imdbRating // ignore: cast_nullable_to_non_nullable
              as double?,
      imdbId: freezed == imdbId
          ? _self.imdbId
          : imdbId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeriesInfoCopyWith<$Res>? get seriesInfo {
    if (_self.seriesInfo == null) {
      return null;
    }

    return $SeriesInfoCopyWith<$Res>(_self.seriesInfo!, (value) {
      return _then(_self.copyWith(seriesInfo: value));
    });
  }

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VideoAssetCopyWith<$Res>? get videoAsset {
    if (_self.videoAsset == null) {
      return null;
    }

    return $VideoAssetCopyWith<$Res>(_self.videoAsset!, (value) {
      return _then(_self.copyWith(videoAsset: value));
    });
  }

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WatchProgressCopyWith<$Res>? get watchProgress {
    if (_self.watchProgress == null) {
      return null;
    }

    return $WatchProgressCopyWith<$Res>(_self.watchProgress!, (value) {
      return _then(_self.copyWith(watchProgress: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Content].
extension ContentPatterns on Content {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Content value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Content() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Content value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Content():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Content value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Content() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String title,
            String slug,
            String type,
            String accessTier,
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
            String? imdbId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Content() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.slug,
            _that.type,
            _that.accessTier,
            _that.description,
            _that.shortDescription,
            _that.thumbnailUrl,
            _that.posterUrl,
            _that.bannerUrl,
            _that.trailerUrl,
            _that.trailerType,
            _that.trailerVideoId,
            _that.releaseYear,
            _that.durationSeconds,
            _that.contentRating,
            _that.status,
            _that.averageRating,
            _that.totalRatings,
            _that.totalViews,
            _that.isFeatured,
            _that.isTrending,
            _that.isNewRelease,
            _that.isOriginal,
            _that.languageName,
            _that.genres,
            _that.cast,
            _that.seriesInfo,
            _that.videoAsset,
            _that.subtitles,
            _that.audioTracks,
            _that.watchProgress,
            _that.isInWatchlist,
            _that.userRating,
            _that.imdbRating,
            _that.imdbId);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String title,
            String slug,
            String type,
            String accessTier,
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
            String? imdbId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Content():
        return $default(
            _that.id,
            _that.title,
            _that.slug,
            _that.type,
            _that.accessTier,
            _that.description,
            _that.shortDescription,
            _that.thumbnailUrl,
            _that.posterUrl,
            _that.bannerUrl,
            _that.trailerUrl,
            _that.trailerType,
            _that.trailerVideoId,
            _that.releaseYear,
            _that.durationSeconds,
            _that.contentRating,
            _that.status,
            _that.averageRating,
            _that.totalRatings,
            _that.totalViews,
            _that.isFeatured,
            _that.isTrending,
            _that.isNewRelease,
            _that.isOriginal,
            _that.languageName,
            _that.genres,
            _that.cast,
            _that.seriesInfo,
            _that.videoAsset,
            _that.subtitles,
            _that.audioTracks,
            _that.watchProgress,
            _that.isInWatchlist,
            _that.userRating,
            _that.imdbRating,
            _that.imdbId);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String title,
            String slug,
            String type,
            String accessTier,
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
            String? imdbId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Content() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.slug,
            _that.type,
            _that.accessTier,
            _that.description,
            _that.shortDescription,
            _that.thumbnailUrl,
            _that.posterUrl,
            _that.bannerUrl,
            _that.trailerUrl,
            _that.trailerType,
            _that.trailerVideoId,
            _that.releaseYear,
            _that.durationSeconds,
            _that.contentRating,
            _that.status,
            _that.averageRating,
            _that.totalRatings,
            _that.totalViews,
            _that.isFeatured,
            _that.isTrending,
            _that.isNewRelease,
            _that.isOriginal,
            _that.languageName,
            _that.genres,
            _that.cast,
            _that.seriesInfo,
            _that.videoAsset,
            _that.subtitles,
            _that.audioTracks,
            _that.watchProgress,
            _that.isInWatchlist,
            _that.userRating,
            _that.imdbRating,
            _that.imdbId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Content implements Content {
  const _Content(
      {required this.id,
      required this.title,
      required this.slug,
      required this.type,
      required this.accessTier,
      this.description,
      this.shortDescription,
      this.thumbnailUrl,
      this.posterUrl,
      this.bannerUrl,
      this.trailerUrl,
      this.trailerType,
      this.trailerVideoId,
      this.releaseYear,
      this.durationSeconds,
      this.contentRating,
      this.status,
      this.averageRating,
      this.totalRatings,
      this.totalViews,
      this.isFeatured,
      this.isTrending,
      this.isNewRelease,
      this.isOriginal,
      this.languageName,
      final List<String>? genres,
      final List<CastMember>? cast,
      this.seriesInfo,
      this.videoAsset,
      final List<Subtitle>? subtitles,
      final List<AudioTrack>? audioTracks,
      this.watchProgress,
      this.isInWatchlist,
      this.userRating,
      this.imdbRating,
      this.imdbId})
      : _genres = genres,
        _cast = cast,
        _subtitles = subtitles,
        _audioTracks = audioTracks;
  factory _Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String slug;
  @override
  final String type;
  @override
  final String accessTier;
  @override
  final String? description;
  @override
  final String? shortDescription;
  @override
  final String? thumbnailUrl;
  @override
  final String? posterUrl;
  @override
  final String? bannerUrl;
  @override
  final String? trailerUrl;
  @override
  final String? trailerType;
  @override
  final String? trailerVideoId;
  @override
  final int? releaseYear;
  @override
  final int? durationSeconds;
  @override
  final String? contentRating;
  @override
  final String? status;
  @override
  final double? averageRating;
  @override
  final int? totalRatings;
  @override
  final int? totalViews;
  @override
  final bool? isFeatured;
  @override
  final bool? isTrending;
  @override
  final bool? isNewRelease;
  @override
  final bool? isOriginal;
  @override
  final String? languageName;
  final List<String>? _genres;
  @override
  List<String>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CastMember>? _cast;
  @override
  List<CastMember>? get cast {
    final value = _cast;
    if (value == null) return null;
    if (_cast is EqualUnmodifiableListView) return _cast;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final SeriesInfo? seriesInfo;
  @override
  final VideoAsset? videoAsset;
  final List<Subtitle>? _subtitles;
  @override
  List<Subtitle>? get subtitles {
    final value = _subtitles;
    if (value == null) return null;
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AudioTrack>? _audioTracks;
  @override
  List<AudioTrack>? get audioTracks {
    final value = _audioTracks;
    if (value == null) return null;
    if (_audioTracks is EqualUnmodifiableListView) return _audioTracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final WatchProgress? watchProgress;
  @override
  final bool? isInWatchlist;
  @override
  final String? userRating;
  @override
  final double? imdbRating;
  @override
  final String? imdbId;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.accessTier, accessTier) ||
                other.accessTier == accessTier) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.posterUrl, posterUrl) ||
                other.posterUrl == posterUrl) &&
            (identical(other.bannerUrl, bannerUrl) ||
                other.bannerUrl == bannerUrl) &&
            (identical(other.trailerUrl, trailerUrl) ||
                other.trailerUrl == trailerUrl) &&
            (identical(other.trailerType, trailerType) ||
                other.trailerType == trailerType) &&
            (identical(other.trailerVideoId, trailerVideoId) ||
                other.trailerVideoId == trailerVideoId) &&
            (identical(other.releaseYear, releaseYear) ||
                other.releaseYear == releaseYear) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.contentRating, contentRating) ||
                other.contentRating == contentRating) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRatings, totalRatings) ||
                other.totalRatings == totalRatings) &&
            (identical(other.totalViews, totalViews) ||
                other.totalViews == totalViews) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isTrending, isTrending) ||
                other.isTrending == isTrending) &&
            (identical(other.isNewRelease, isNewRelease) ||
                other.isNewRelease == isNewRelease) &&
            (identical(other.isOriginal, isOriginal) ||
                other.isOriginal == isOriginal) &&
            (identical(other.languageName, languageName) ||
                other.languageName == languageName) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality().equals(other._cast, _cast) &&
            (identical(other.seriesInfo, seriesInfo) ||
                other.seriesInfo == seriesInfo) &&
            (identical(other.videoAsset, videoAsset) ||
                other.videoAsset == videoAsset) &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles) &&
            const DeepCollectionEquality()
                .equals(other._audioTracks, _audioTracks) &&
            (identical(other.watchProgress, watchProgress) ||
                other.watchProgress == watchProgress) &&
            (identical(other.isInWatchlist, isInWatchlist) ||
                other.isInWatchlist == isInWatchlist) &&
            (identical(other.userRating, userRating) ||
                other.userRating == userRating) &&
            (identical(other.imdbRating, imdbRating) ||
                other.imdbRating == imdbRating) &&
            (identical(other.imdbId, imdbId) || other.imdbId == imdbId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        slug,
        type,
        accessTier,
        description,
        shortDescription,
        thumbnailUrl,
        posterUrl,
        bannerUrl,
        trailerUrl,
        trailerType,
        trailerVideoId,
        releaseYear,
        durationSeconds,
        contentRating,
        status,
        averageRating,
        totalRatings,
        totalViews,
        isFeatured,
        isTrending,
        isNewRelease,
        isOriginal,
        languageName,
        const DeepCollectionEquality().hash(_genres),
        const DeepCollectionEquality().hash(_cast),
        seriesInfo,
        videoAsset,
        const DeepCollectionEquality().hash(_subtitles),
        const DeepCollectionEquality().hash(_audioTracks),
        watchProgress,
        isInWatchlist,
        userRating,
        imdbRating,
        imdbId
      ]);

  @override
  String toString() {
    return 'Content(id: $id, title: $title, slug: $slug, type: $type, accessTier: $accessTier, description: $description, shortDescription: $shortDescription, thumbnailUrl: $thumbnailUrl, posterUrl: $posterUrl, bannerUrl: $bannerUrl, trailerUrl: $trailerUrl, trailerType: $trailerType, trailerVideoId: $trailerVideoId, releaseYear: $releaseYear, durationSeconds: $durationSeconds, contentRating: $contentRating, status: $status, averageRating: $averageRating, totalRatings: $totalRatings, totalViews: $totalViews, isFeatured: $isFeatured, isTrending: $isTrending, isNewRelease: $isNewRelease, isOriginal: $isOriginal, languageName: $languageName, genres: $genres, cast: $cast, seriesInfo: $seriesInfo, videoAsset: $videoAsset, subtitles: $subtitles, audioTracks: $audioTracks, watchProgress: $watchProgress, isInWatchlist: $isInWatchlist, userRating: $userRating, imdbRating: $imdbRating, imdbId: $imdbId)';
  }
}

/// @nodoc
abstract mixin class _$ContentCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) _then) =
      __$ContentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String slug,
      String type,
      String accessTier,
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
      String? imdbId});

  @override
  $SeriesInfoCopyWith<$Res>? get seriesInfo;
  @override
  $VideoAssetCopyWith<$Res>? get videoAsset;
  @override
  $WatchProgressCopyWith<$Res>? get watchProgress;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(this._self, this._then);

  final _Content _self;
  final $Res Function(_Content) _then;

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = null,
    Object? type = null,
    Object? accessTier = null,
    Object? description = freezed,
    Object? shortDescription = freezed,
    Object? thumbnailUrl = freezed,
    Object? posterUrl = freezed,
    Object? bannerUrl = freezed,
    Object? trailerUrl = freezed,
    Object? trailerType = freezed,
    Object? trailerVideoId = freezed,
    Object? releaseYear = freezed,
    Object? durationSeconds = freezed,
    Object? contentRating = freezed,
    Object? status = freezed,
    Object? averageRating = freezed,
    Object? totalRatings = freezed,
    Object? totalViews = freezed,
    Object? isFeatured = freezed,
    Object? isTrending = freezed,
    Object? isNewRelease = freezed,
    Object? isOriginal = freezed,
    Object? languageName = freezed,
    Object? genres = freezed,
    Object? cast = freezed,
    Object? seriesInfo = freezed,
    Object? videoAsset = freezed,
    Object? subtitles = freezed,
    Object? audioTracks = freezed,
    Object? watchProgress = freezed,
    Object? isInWatchlist = freezed,
    Object? userRating = freezed,
    Object? imdbRating = freezed,
    Object? imdbId = freezed,
  }) {
    return _then(_Content(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accessTier: null == accessTier
          ? _self.accessTier
          : accessTier // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      shortDescription: freezed == shortDescription
          ? _self.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      posterUrl: freezed == posterUrl
          ? _self.posterUrl
          : posterUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bannerUrl: freezed == bannerUrl
          ? _self.bannerUrl
          : bannerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      trailerUrl: freezed == trailerUrl
          ? _self.trailerUrl
          : trailerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      trailerType: freezed == trailerType
          ? _self.trailerType
          : trailerType // ignore: cast_nullable_to_non_nullable
              as String?,
      trailerVideoId: freezed == trailerVideoId
          ? _self.trailerVideoId
          : trailerVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseYear: freezed == releaseYear
          ? _self.releaseYear
          : releaseYear // ignore: cast_nullable_to_non_nullable
              as int?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      contentRating: freezed == contentRating
          ? _self.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      averageRating: freezed == averageRating
          ? _self.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRatings: freezed == totalRatings
          ? _self.totalRatings
          : totalRatings // ignore: cast_nullable_to_non_nullable
              as int?,
      totalViews: freezed == totalViews
          ? _self.totalViews
          : totalViews // ignore: cast_nullable_to_non_nullable
              as int?,
      isFeatured: freezed == isFeatured
          ? _self.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool?,
      isTrending: freezed == isTrending
          ? _self.isTrending
          : isTrending // ignore: cast_nullable_to_non_nullable
              as bool?,
      isNewRelease: freezed == isNewRelease
          ? _self.isNewRelease
          : isNewRelease // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOriginal: freezed == isOriginal
          ? _self.isOriginal
          : isOriginal // ignore: cast_nullable_to_non_nullable
              as bool?,
      languageName: freezed == languageName
          ? _self.languageName
          : languageName // ignore: cast_nullable_to_non_nullable
              as String?,
      genres: freezed == genres
          ? _self._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      cast: freezed == cast
          ? _self._cast
          : cast // ignore: cast_nullable_to_non_nullable
              as List<CastMember>?,
      seriesInfo: freezed == seriesInfo
          ? _self.seriesInfo
          : seriesInfo // ignore: cast_nullable_to_non_nullable
              as SeriesInfo?,
      videoAsset: freezed == videoAsset
          ? _self.videoAsset
          : videoAsset // ignore: cast_nullable_to_non_nullable
              as VideoAsset?,
      subtitles: freezed == subtitles
          ? _self._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<Subtitle>?,
      audioTracks: freezed == audioTracks
          ? _self._audioTracks
          : audioTracks // ignore: cast_nullable_to_non_nullable
              as List<AudioTrack>?,
      watchProgress: freezed == watchProgress
          ? _self.watchProgress
          : watchProgress // ignore: cast_nullable_to_non_nullable
              as WatchProgress?,
      isInWatchlist: freezed == isInWatchlist
          ? _self.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool?,
      userRating: freezed == userRating
          ? _self.userRating
          : userRating // ignore: cast_nullable_to_non_nullable
              as String?,
      imdbRating: freezed == imdbRating
          ? _self.imdbRating
          : imdbRating // ignore: cast_nullable_to_non_nullable
              as double?,
      imdbId: freezed == imdbId
          ? _self.imdbId
          : imdbId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeriesInfoCopyWith<$Res>? get seriesInfo {
    if (_self.seriesInfo == null) {
      return null;
    }

    return $SeriesInfoCopyWith<$Res>(_self.seriesInfo!, (value) {
      return _then(_self.copyWith(seriesInfo: value));
    });
  }

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VideoAssetCopyWith<$Res>? get videoAsset {
    if (_self.videoAsset == null) {
      return null;
    }

    return $VideoAssetCopyWith<$Res>(_self.videoAsset!, (value) {
      return _then(_self.copyWith(videoAsset: value));
    });
  }

  /// Create a copy of Content
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WatchProgressCopyWith<$Res>? get watchProgress {
    if (_self.watchProgress == null) {
      return null;
    }

    return $WatchProgressCopyWith<$Res>(_self.watchProgress!, (value) {
      return _then(_self.copyWith(watchProgress: value));
    });
  }
}

/// @nodoc
mixin _$CastMember {
  int get id;
  String get personName;
  String get role;
  String? get characterName;
  String? get photoUrl;
  int? get sortOrder;

  /// Create a copy of CastMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CastMemberCopyWith<CastMember> get copyWith =>
      _$CastMemberCopyWithImpl<CastMember>(this as CastMember, _$identity);

  /// Serializes this CastMember to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CastMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.personName, personName) ||
                other.personName == personName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.characterName, characterName) ||
                other.characterName == characterName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, personName, role, characterName, photoUrl, sortOrder);

  @override
  String toString() {
    return 'CastMember(id: $id, personName: $personName, role: $role, characterName: $characterName, photoUrl: $photoUrl, sortOrder: $sortOrder)';
  }
}

/// @nodoc
abstract mixin class $CastMemberCopyWith<$Res> {
  factory $CastMemberCopyWith(
          CastMember value, $Res Function(CastMember) _then) =
      _$CastMemberCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String personName,
      String role,
      String? characterName,
      String? photoUrl,
      int? sortOrder});
}

/// @nodoc
class _$CastMemberCopyWithImpl<$Res> implements $CastMemberCopyWith<$Res> {
  _$CastMemberCopyWithImpl(this._self, this._then);

  final CastMember _self;
  final $Res Function(CastMember) _then;

  /// Create a copy of CastMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? personName = null,
    Object? role = null,
    Object? characterName = freezed,
    Object? photoUrl = freezed,
    Object? sortOrder = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      personName: null == personName
          ? _self.personName
          : personName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      characterName: freezed == characterName
          ? _self.characterName
          : characterName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CastMember].
extension CastMemberPatterns on CastMember {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CastMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CastMember() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CastMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CastMember():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CastMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CastMember() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String personName, String role,
            String? characterName, String? photoUrl, int? sortOrder)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CastMember() when $default != null:
        return $default(_that.id, _that.personName, _that.role,
            _that.characterName, _that.photoUrl, _that.sortOrder);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String personName, String role,
            String? characterName, String? photoUrl, int? sortOrder)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CastMember():
        return $default(_that.id, _that.personName, _that.role,
            _that.characterName, _that.photoUrl, _that.sortOrder);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String personName, String role,
            String? characterName, String? photoUrl, int? sortOrder)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CastMember() when $default != null:
        return $default(_that.id, _that.personName, _that.role,
            _that.characterName, _that.photoUrl, _that.sortOrder);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CastMember implements CastMember {
  const _CastMember(
      {required this.id,
      required this.personName,
      required this.role,
      this.characterName,
      this.photoUrl,
      this.sortOrder});
  factory _CastMember.fromJson(Map<String, dynamic> json) =>
      _$CastMemberFromJson(json);

  @override
  final int id;
  @override
  final String personName;
  @override
  final String role;
  @override
  final String? characterName;
  @override
  final String? photoUrl;
  @override
  final int? sortOrder;

  /// Create a copy of CastMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CastMemberCopyWith<_CastMember> get copyWith =>
      __$CastMemberCopyWithImpl<_CastMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CastMemberToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CastMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.personName, personName) ||
                other.personName == personName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.characterName, characterName) ||
                other.characterName == characterName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, personName, role, characterName, photoUrl, sortOrder);

  @override
  String toString() {
    return 'CastMember(id: $id, personName: $personName, role: $role, characterName: $characterName, photoUrl: $photoUrl, sortOrder: $sortOrder)';
  }
}

/// @nodoc
abstract mixin class _$CastMemberCopyWith<$Res>
    implements $CastMemberCopyWith<$Res> {
  factory _$CastMemberCopyWith(
          _CastMember value, $Res Function(_CastMember) _then) =
      __$CastMemberCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String personName,
      String role,
      String? characterName,
      String? photoUrl,
      int? sortOrder});
}

/// @nodoc
class __$CastMemberCopyWithImpl<$Res> implements _$CastMemberCopyWith<$Res> {
  __$CastMemberCopyWithImpl(this._self, this._then);

  final _CastMember _self;
  final $Res Function(_CastMember) _then;

  /// Create a copy of CastMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? personName = null,
    Object? role = null,
    Object? characterName = freezed,
    Object? photoUrl = freezed,
    Object? sortOrder = freezed,
  }) {
    return _then(_CastMember(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      personName: null == personName
          ? _self.personName
          : personName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      characterName: freezed == characterName
          ? _self.characterName
          : characterName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$SeriesInfo {
  int get seriesId;
  int get totalSeasons;
  int get totalEpisodes;
  String get status;
  List<Season>? get seasons;

  /// Create a copy of SeriesInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeriesInfoCopyWith<SeriesInfo> get copyWith =>
      _$SeriesInfoCopyWithImpl<SeriesInfo>(this as SeriesInfo, _$identity);

  /// Serializes this SeriesInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SeriesInfo &&
            (identical(other.seriesId, seriesId) ||
                other.seriesId == seriesId) &&
            (identical(other.totalSeasons, totalSeasons) ||
                other.totalSeasons == totalSeasons) &&
            (identical(other.totalEpisodes, totalEpisodes) ||
                other.totalEpisodes == totalEpisodes) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.seasons, seasons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, seriesId, totalSeasons,
      totalEpisodes, status, const DeepCollectionEquality().hash(seasons));

  @override
  String toString() {
    return 'SeriesInfo(seriesId: $seriesId, totalSeasons: $totalSeasons, totalEpisodes: $totalEpisodes, status: $status, seasons: $seasons)';
  }
}

/// @nodoc
abstract mixin class $SeriesInfoCopyWith<$Res> {
  factory $SeriesInfoCopyWith(
          SeriesInfo value, $Res Function(SeriesInfo) _then) =
      _$SeriesInfoCopyWithImpl;
  @useResult
  $Res call(
      {int seriesId,
      int totalSeasons,
      int totalEpisodes,
      String status,
      List<Season>? seasons});
}

/// @nodoc
class _$SeriesInfoCopyWithImpl<$Res> implements $SeriesInfoCopyWith<$Res> {
  _$SeriesInfoCopyWithImpl(this._self, this._then);

  final SeriesInfo _self;
  final $Res Function(SeriesInfo) _then;

  /// Create a copy of SeriesInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seriesId = null,
    Object? totalSeasons = null,
    Object? totalEpisodes = null,
    Object? status = null,
    Object? seasons = freezed,
  }) {
    return _then(_self.copyWith(
      seriesId: null == seriesId
          ? _self.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as int,
      totalSeasons: null == totalSeasons
          ? _self.totalSeasons
          : totalSeasons // ignore: cast_nullable_to_non_nullable
              as int,
      totalEpisodes: null == totalEpisodes
          ? _self.totalEpisodes
          : totalEpisodes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      seasons: freezed == seasons
          ? _self.seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SeriesInfo].
extension SeriesInfoPatterns on SeriesInfo {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SeriesInfo value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeriesInfo() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SeriesInfo value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeriesInfo():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SeriesInfo value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeriesInfo() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int seriesId, int totalSeasons, int totalEpisodes,
            String status, List<Season>? seasons)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SeriesInfo() when $default != null:
        return $default(_that.seriesId, _that.totalSeasons, _that.totalEpisodes,
            _that.status, _that.seasons);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int seriesId, int totalSeasons, int totalEpisodes,
            String status, List<Season>? seasons)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeriesInfo():
        return $default(_that.seriesId, _that.totalSeasons, _that.totalEpisodes,
            _that.status, _that.seasons);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int seriesId, int totalSeasons, int totalEpisodes,
            String status, List<Season>? seasons)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SeriesInfo() when $default != null:
        return $default(_that.seriesId, _that.totalSeasons, _that.totalEpisodes,
            _that.status, _that.seasons);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SeriesInfo implements SeriesInfo {
  const _SeriesInfo(
      {required this.seriesId,
      required this.totalSeasons,
      required this.totalEpisodes,
      required this.status,
      final List<Season>? seasons})
      : _seasons = seasons;
  factory _SeriesInfo.fromJson(Map<String, dynamic> json) =>
      _$SeriesInfoFromJson(json);

  @override
  final int seriesId;
  @override
  final int totalSeasons;
  @override
  final int totalEpisodes;
  @override
  final String status;
  final List<Season>? _seasons;
  @override
  List<Season>? get seasons {
    final value = _seasons;
    if (value == null) return null;
    if (_seasons is EqualUnmodifiableListView) return _seasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of SeriesInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeriesInfoCopyWith<_SeriesInfo> get copyWith =>
      __$SeriesInfoCopyWithImpl<_SeriesInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeriesInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SeriesInfo &&
            (identical(other.seriesId, seriesId) ||
                other.seriesId == seriesId) &&
            (identical(other.totalSeasons, totalSeasons) ||
                other.totalSeasons == totalSeasons) &&
            (identical(other.totalEpisodes, totalEpisodes) ||
                other.totalEpisodes == totalEpisodes) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._seasons, _seasons));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, seriesId, totalSeasons,
      totalEpisodes, status, const DeepCollectionEquality().hash(_seasons));

  @override
  String toString() {
    return 'SeriesInfo(seriesId: $seriesId, totalSeasons: $totalSeasons, totalEpisodes: $totalEpisodes, status: $status, seasons: $seasons)';
  }
}

/// @nodoc
abstract mixin class _$SeriesInfoCopyWith<$Res>
    implements $SeriesInfoCopyWith<$Res> {
  factory _$SeriesInfoCopyWith(
          _SeriesInfo value, $Res Function(_SeriesInfo) _then) =
      __$SeriesInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int seriesId,
      int totalSeasons,
      int totalEpisodes,
      String status,
      List<Season>? seasons});
}

/// @nodoc
class __$SeriesInfoCopyWithImpl<$Res> implements _$SeriesInfoCopyWith<$Res> {
  __$SeriesInfoCopyWithImpl(this._self, this._then);

  final _SeriesInfo _self;
  final $Res Function(_SeriesInfo) _then;

  /// Create a copy of SeriesInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? seriesId = null,
    Object? totalSeasons = null,
    Object? totalEpisodes = null,
    Object? status = null,
    Object? seasons = freezed,
  }) {
    return _then(_SeriesInfo(
      seriesId: null == seriesId
          ? _self.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as int,
      totalSeasons: null == totalSeasons
          ? _self.totalSeasons
          : totalSeasons // ignore: cast_nullable_to_non_nullable
              as int,
      totalEpisodes: null == totalEpisodes
          ? _self.totalEpisodes
          : totalEpisodes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      seasons: freezed == seasons
          ? _self._seasons
          : seasons // ignore: cast_nullable_to_non_nullable
              as List<Season>?,
    ));
  }
}

/// @nodoc
mixin _$Season {
  int get id;
  int get seasonNumber;
  String? get title;
  int? get year;
  int? get episodeCount;
  List<Episode>? get episodes;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SeasonCopyWith<Season> get copyWith =>
      _$SeasonCopyWithImpl<Season>(this as Season, _$identity);

  /// Serializes this Season to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Season &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.episodeCount, episodeCount) ||
                other.episodeCount == episodeCount) &&
            const DeepCollectionEquality().equals(other.episodes, episodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, seasonNumber, title, year,
      episodeCount, const DeepCollectionEquality().hash(episodes));

  @override
  String toString() {
    return 'Season(id: $id, seasonNumber: $seasonNumber, title: $title, year: $year, episodeCount: $episodeCount, episodes: $episodes)';
  }
}

/// @nodoc
abstract mixin class $SeasonCopyWith<$Res> {
  factory $SeasonCopyWith(Season value, $Res Function(Season) _then) =
      _$SeasonCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int seasonNumber,
      String? title,
      int? year,
      int? episodeCount,
      List<Episode>? episodes});
}

/// @nodoc
class _$SeasonCopyWithImpl<$Res> implements $SeasonCopyWith<$Res> {
  _$SeasonCopyWithImpl(this._self, this._then);

  final Season _self;
  final $Res Function(Season) _then;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seasonNumber = null,
    Object? title = freezed,
    Object? year = freezed,
    Object? episodeCount = freezed,
    Object? episodes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seasonNumber: null == seasonNumber
          ? _self.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      episodeCount: freezed == episodeCount
          ? _self.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      episodes: freezed == episodes
          ? _self.episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Season].
extension SeasonPatterns on Season {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Season value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Season() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Season value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Season():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Season value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Season() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, int seasonNumber, String? title, int? year,
            int? episodeCount, List<Episode>? episodes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Season() when $default != null:
        return $default(_that.id, _that.seasonNumber, _that.title, _that.year,
            _that.episodeCount, _that.episodes);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, int seasonNumber, String? title, int? year,
            int? episodeCount, List<Episode>? episodes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Season():
        return $default(_that.id, _that.seasonNumber, _that.title, _that.year,
            _that.episodeCount, _that.episodes);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, int seasonNumber, String? title, int? year,
            int? episodeCount, List<Episode>? episodes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Season() when $default != null:
        return $default(_that.id, _that.seasonNumber, _that.title, _that.year,
            _that.episodeCount, _that.episodes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Season implements Season {
  const _Season(
      {required this.id,
      required this.seasonNumber,
      this.title,
      this.year,
      this.episodeCount,
      final List<Episode>? episodes})
      : _episodes = episodes;
  factory _Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  @override
  final int id;
  @override
  final int seasonNumber;
  @override
  final String? title;
  @override
  final int? year;
  @override
  final int? episodeCount;
  final List<Episode>? _episodes;
  @override
  List<Episode>? get episodes {
    final value = _episodes;
    if (value == null) return null;
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SeasonCopyWith<_Season> get copyWith =>
      __$SeasonCopyWithImpl<_Season>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SeasonToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Season &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seasonNumber, seasonNumber) ||
                other.seasonNumber == seasonNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.episodeCount, episodeCount) ||
                other.episodeCount == episodeCount) &&
            const DeepCollectionEquality().equals(other._episodes, _episodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, seasonNumber, title, year,
      episodeCount, const DeepCollectionEquality().hash(_episodes));

  @override
  String toString() {
    return 'Season(id: $id, seasonNumber: $seasonNumber, title: $title, year: $year, episodeCount: $episodeCount, episodes: $episodes)';
  }
}

/// @nodoc
abstract mixin class _$SeasonCopyWith<$Res> implements $SeasonCopyWith<$Res> {
  factory _$SeasonCopyWith(_Season value, $Res Function(_Season) _then) =
      __$SeasonCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int seasonNumber,
      String? title,
      int? year,
      int? episodeCount,
      List<Episode>? episodes});
}

/// @nodoc
class __$SeasonCopyWithImpl<$Res> implements _$SeasonCopyWith<$Res> {
  __$SeasonCopyWithImpl(this._self, this._then);

  final _Season _self;
  final $Res Function(_Season) _then;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? seasonNumber = null,
    Object? title = freezed,
    Object? year = freezed,
    Object? episodeCount = freezed,
    Object? episodes = freezed,
  }) {
    return _then(_Season(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      seasonNumber: null == seasonNumber
          ? _self.seasonNumber
          : seasonNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      episodeCount: freezed == episodeCount
          ? _self.episodeCount
          : episodeCount // ignore: cast_nullable_to_non_nullable
              as int?,
      episodes: freezed == episodes
          ? _self._episodes
          : episodes // ignore: cast_nullable_to_non_nullable
              as List<Episode>?,
    ));
  }
}

/// @nodoc
mixin _$Episode {
  int get id;
  int get episodeNumber;
  String get title;
  String? get description;
  int? get durationSeconds;
  String? get thumbnailUrl;
  int? get contentId;
  WatchProgress? get watchProgress;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EpisodeCopyWith<Episode> get copyWith =>
      _$EpisodeCopyWithImpl<Episode>(this as Episode, _$identity);

  /// Serializes this Episode to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Episode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.episodeNumber, episodeNumber) ||
                other.episodeNumber == episodeNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.watchProgress, watchProgress) ||
                other.watchProgress == watchProgress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, episodeNumber, title,
      description, durationSeconds, thumbnailUrl, contentId, watchProgress);

  @override
  String toString() {
    return 'Episode(id: $id, episodeNumber: $episodeNumber, title: $title, description: $description, durationSeconds: $durationSeconds, thumbnailUrl: $thumbnailUrl, contentId: $contentId, watchProgress: $watchProgress)';
  }
}

/// @nodoc
abstract mixin class $EpisodeCopyWith<$Res> {
  factory $EpisodeCopyWith(Episode value, $Res Function(Episode) _then) =
      _$EpisodeCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int episodeNumber,
      String title,
      String? description,
      int? durationSeconds,
      String? thumbnailUrl,
      int? contentId,
      WatchProgress? watchProgress});

  $WatchProgressCopyWith<$Res>? get watchProgress;
}

/// @nodoc
class _$EpisodeCopyWithImpl<$Res> implements $EpisodeCopyWith<$Res> {
  _$EpisodeCopyWithImpl(this._self, this._then);

  final Episode _self;
  final $Res Function(Episode) _then;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? episodeNumber = null,
    Object? title = null,
    Object? description = freezed,
    Object? durationSeconds = freezed,
    Object? thumbnailUrl = freezed,
    Object? contentId = freezed,
    Object? watchProgress = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      episodeNumber: null == episodeNumber
          ? _self.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: freezed == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int?,
      watchProgress: freezed == watchProgress
          ? _self.watchProgress
          : watchProgress // ignore: cast_nullable_to_non_nullable
              as WatchProgress?,
    ));
  }

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WatchProgressCopyWith<$Res>? get watchProgress {
    if (_self.watchProgress == null) {
      return null;
    }

    return $WatchProgressCopyWith<$Res>(_self.watchProgress!, (value) {
      return _then(_self.copyWith(watchProgress: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Episode].
extension EpisodePatterns on Episode {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Episode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Episode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Episode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            int episodeNumber,
            String title,
            String? description,
            int? durationSeconds,
            String? thumbnailUrl,
            int? contentId,
            WatchProgress? watchProgress)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
        return $default(
            _that.id,
            _that.episodeNumber,
            _that.title,
            _that.description,
            _that.durationSeconds,
            _that.thumbnailUrl,
            _that.contentId,
            _that.watchProgress);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            int episodeNumber,
            String title,
            String? description,
            int? durationSeconds,
            String? thumbnailUrl,
            int? contentId,
            WatchProgress? watchProgress)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode():
        return $default(
            _that.id,
            _that.episodeNumber,
            _that.title,
            _that.description,
            _that.durationSeconds,
            _that.thumbnailUrl,
            _that.contentId,
            _that.watchProgress);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            int episodeNumber,
            String title,
            String? description,
            int? durationSeconds,
            String? thumbnailUrl,
            int? contentId,
            WatchProgress? watchProgress)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Episode() when $default != null:
        return $default(
            _that.id,
            _that.episodeNumber,
            _that.title,
            _that.description,
            _that.durationSeconds,
            _that.thumbnailUrl,
            _that.contentId,
            _that.watchProgress);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Episode implements Episode {
  const _Episode(
      {required this.id,
      required this.episodeNumber,
      required this.title,
      this.description,
      this.durationSeconds,
      this.thumbnailUrl,
      this.contentId,
      this.watchProgress});
  factory _Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  @override
  final int id;
  @override
  final int episodeNumber;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int? durationSeconds;
  @override
  final String? thumbnailUrl;
  @override
  final int? contentId;
  @override
  final WatchProgress? watchProgress;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EpisodeCopyWith<_Episode> get copyWith =>
      __$EpisodeCopyWithImpl<_Episode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EpisodeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Episode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.episodeNumber, episodeNumber) ||
                other.episodeNumber == episodeNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.watchProgress, watchProgress) ||
                other.watchProgress == watchProgress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, episodeNumber, title,
      description, durationSeconds, thumbnailUrl, contentId, watchProgress);

  @override
  String toString() {
    return 'Episode(id: $id, episodeNumber: $episodeNumber, title: $title, description: $description, durationSeconds: $durationSeconds, thumbnailUrl: $thumbnailUrl, contentId: $contentId, watchProgress: $watchProgress)';
  }
}

/// @nodoc
abstract mixin class _$EpisodeCopyWith<$Res> implements $EpisodeCopyWith<$Res> {
  factory _$EpisodeCopyWith(_Episode value, $Res Function(_Episode) _then) =
      __$EpisodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int episodeNumber,
      String title,
      String? description,
      int? durationSeconds,
      String? thumbnailUrl,
      int? contentId,
      WatchProgress? watchProgress});

  @override
  $WatchProgressCopyWith<$Res>? get watchProgress;
}

/// @nodoc
class __$EpisodeCopyWithImpl<$Res> implements _$EpisodeCopyWith<$Res> {
  __$EpisodeCopyWithImpl(this._self, this._then);

  final _Episode _self;
  final $Res Function(_Episode) _then;

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? episodeNumber = null,
    Object? title = null,
    Object? description = freezed,
    Object? durationSeconds = freezed,
    Object? thumbnailUrl = freezed,
    Object? contentId = freezed,
    Object? watchProgress = freezed,
  }) {
    return _then(_Episode(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      episodeNumber: null == episodeNumber
          ? _self.episodeNumber
          : episodeNumber // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      durationSeconds: freezed == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: freezed == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int?,
      watchProgress: freezed == watchProgress
          ? _self.watchProgress
          : watchProgress // ignore: cast_nullable_to_non_nullable
              as WatchProgress?,
    ));
  }

  /// Create a copy of Episode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WatchProgressCopyWith<$Res>? get watchProgress {
    if (_self.watchProgress == null) {
      return null;
    }

    return $WatchProgressCopyWith<$Res>(_self.watchProgress!, (value) {
      return _then(_self.copyWith(watchProgress: value));
    });
  }
}

/// @nodoc
mixin _$VideoAsset {
  int get id;
  String get playerType;
  String get status;
  String? get hlsManifestUrl;
  String? get youTubeVideoId;
  String? get vimeoVideoId;
  List<VideoQuality>? get qualities;

  /// Create a copy of VideoAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VideoAssetCopyWith<VideoAsset> get copyWith =>
      _$VideoAssetCopyWithImpl<VideoAsset>(this as VideoAsset, _$identity);

  /// Serializes this VideoAsset to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VideoAsset &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerType, playerType) ||
                other.playerType == playerType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hlsManifestUrl, hlsManifestUrl) ||
                other.hlsManifestUrl == hlsManifestUrl) &&
            (identical(other.youTubeVideoId, youTubeVideoId) ||
                other.youTubeVideoId == youTubeVideoId) &&
            (identical(other.vimeoVideoId, vimeoVideoId) ||
                other.vimeoVideoId == vimeoVideoId) &&
            const DeepCollectionEquality().equals(other.qualities, qualities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      playerType,
      status,
      hlsManifestUrl,
      youTubeVideoId,
      vimeoVideoId,
      const DeepCollectionEquality().hash(qualities));

  @override
  String toString() {
    return 'VideoAsset(id: $id, playerType: $playerType, status: $status, hlsManifestUrl: $hlsManifestUrl, youTubeVideoId: $youTubeVideoId, vimeoVideoId: $vimeoVideoId, qualities: $qualities)';
  }
}

/// @nodoc
abstract mixin class $VideoAssetCopyWith<$Res> {
  factory $VideoAssetCopyWith(
          VideoAsset value, $Res Function(VideoAsset) _then) =
      _$VideoAssetCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String playerType,
      String status,
      String? hlsManifestUrl,
      String? youTubeVideoId,
      String? vimeoVideoId,
      List<VideoQuality>? qualities});
}

/// @nodoc
class _$VideoAssetCopyWithImpl<$Res> implements $VideoAssetCopyWith<$Res> {
  _$VideoAssetCopyWithImpl(this._self, this._then);

  final VideoAsset _self;
  final $Res Function(VideoAsset) _then;

  /// Create a copy of VideoAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerType = null,
    Object? status = null,
    Object? hlsManifestUrl = freezed,
    Object? youTubeVideoId = freezed,
    Object? vimeoVideoId = freezed,
    Object? qualities = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      playerType: null == playerType
          ? _self.playerType
          : playerType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hlsManifestUrl: freezed == hlsManifestUrl
          ? _self.hlsManifestUrl
          : hlsManifestUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      youTubeVideoId: freezed == youTubeVideoId
          ? _self.youTubeVideoId
          : youTubeVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      vimeoVideoId: freezed == vimeoVideoId
          ? _self.vimeoVideoId
          : vimeoVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      qualities: freezed == qualities
          ? _self.qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as List<VideoQuality>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VideoAsset].
extension VideoAssetPatterns on VideoAsset {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoAsset value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoAsset() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoAsset value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoAsset():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoAsset value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoAsset() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String playerType,
            String status,
            String? hlsManifestUrl,
            String? youTubeVideoId,
            String? vimeoVideoId,
            List<VideoQuality>? qualities)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoAsset() when $default != null:
        return $default(
            _that.id,
            _that.playerType,
            _that.status,
            _that.hlsManifestUrl,
            _that.youTubeVideoId,
            _that.vimeoVideoId,
            _that.qualities);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String playerType,
            String status,
            String? hlsManifestUrl,
            String? youTubeVideoId,
            String? vimeoVideoId,
            List<VideoQuality>? qualities)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoAsset():
        return $default(
            _that.id,
            _that.playerType,
            _that.status,
            _that.hlsManifestUrl,
            _that.youTubeVideoId,
            _that.vimeoVideoId,
            _that.qualities);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String playerType,
            String status,
            String? hlsManifestUrl,
            String? youTubeVideoId,
            String? vimeoVideoId,
            List<VideoQuality>? qualities)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoAsset() when $default != null:
        return $default(
            _that.id,
            _that.playerType,
            _that.status,
            _that.hlsManifestUrl,
            _that.youTubeVideoId,
            _that.vimeoVideoId,
            _that.qualities);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VideoAsset implements VideoAsset {
  const _VideoAsset(
      {required this.id,
      required this.playerType,
      required this.status,
      this.hlsManifestUrl,
      this.youTubeVideoId,
      this.vimeoVideoId,
      final List<VideoQuality>? qualities})
      : _qualities = qualities;
  factory _VideoAsset.fromJson(Map<String, dynamic> json) =>
      _$VideoAssetFromJson(json);

  @override
  final int id;
  @override
  final String playerType;
  @override
  final String status;
  @override
  final String? hlsManifestUrl;
  @override
  final String? youTubeVideoId;
  @override
  final String? vimeoVideoId;
  final List<VideoQuality>? _qualities;
  @override
  List<VideoQuality>? get qualities {
    final value = _qualities;
    if (value == null) return null;
    if (_qualities is EqualUnmodifiableListView) return _qualities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of VideoAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VideoAssetCopyWith<_VideoAsset> get copyWith =>
      __$VideoAssetCopyWithImpl<_VideoAsset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VideoAssetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VideoAsset &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerType, playerType) ||
                other.playerType == playerType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.hlsManifestUrl, hlsManifestUrl) ||
                other.hlsManifestUrl == hlsManifestUrl) &&
            (identical(other.youTubeVideoId, youTubeVideoId) ||
                other.youTubeVideoId == youTubeVideoId) &&
            (identical(other.vimeoVideoId, vimeoVideoId) ||
                other.vimeoVideoId == vimeoVideoId) &&
            const DeepCollectionEquality()
                .equals(other._qualities, _qualities));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      playerType,
      status,
      hlsManifestUrl,
      youTubeVideoId,
      vimeoVideoId,
      const DeepCollectionEquality().hash(_qualities));

  @override
  String toString() {
    return 'VideoAsset(id: $id, playerType: $playerType, status: $status, hlsManifestUrl: $hlsManifestUrl, youTubeVideoId: $youTubeVideoId, vimeoVideoId: $vimeoVideoId, qualities: $qualities)';
  }
}

/// @nodoc
abstract mixin class _$VideoAssetCopyWith<$Res>
    implements $VideoAssetCopyWith<$Res> {
  factory _$VideoAssetCopyWith(
          _VideoAsset value, $Res Function(_VideoAsset) _then) =
      __$VideoAssetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String playerType,
      String status,
      String? hlsManifestUrl,
      String? youTubeVideoId,
      String? vimeoVideoId,
      List<VideoQuality>? qualities});
}

/// @nodoc
class __$VideoAssetCopyWithImpl<$Res> implements _$VideoAssetCopyWith<$Res> {
  __$VideoAssetCopyWithImpl(this._self, this._then);

  final _VideoAsset _self;
  final $Res Function(_VideoAsset) _then;

  /// Create a copy of VideoAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? playerType = null,
    Object? status = null,
    Object? hlsManifestUrl = freezed,
    Object? youTubeVideoId = freezed,
    Object? vimeoVideoId = freezed,
    Object? qualities = freezed,
  }) {
    return _then(_VideoAsset(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      playerType: null == playerType
          ? _self.playerType
          : playerType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      hlsManifestUrl: freezed == hlsManifestUrl
          ? _self.hlsManifestUrl
          : hlsManifestUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      youTubeVideoId: freezed == youTubeVideoId
          ? _self.youTubeVideoId
          : youTubeVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      vimeoVideoId: freezed == vimeoVideoId
          ? _self.vimeoVideoId
          : vimeoVideoId // ignore: cast_nullable_to_non_nullable
              as String?,
      qualities: freezed == qualities
          ? _self._qualities
          : qualities // ignore: cast_nullable_to_non_nullable
              as List<VideoQuality>?,
    ));
  }
}

/// @nodoc
mixin _$VideoQuality {
  String get resolution;
  int? get bitrate;
  bool? get isReady;

  /// Create a copy of VideoQuality
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VideoQualityCopyWith<VideoQuality> get copyWith =>
      _$VideoQualityCopyWithImpl<VideoQuality>(
          this as VideoQuality, _$identity);

  /// Serializes this VideoQuality to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VideoQuality &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.bitrate, bitrate) || other.bitrate == bitrate) &&
            (identical(other.isReady, isReady) || other.isReady == isReady));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resolution, bitrate, isReady);

  @override
  String toString() {
    return 'VideoQuality(resolution: $resolution, bitrate: $bitrate, isReady: $isReady)';
  }
}

/// @nodoc
abstract mixin class $VideoQualityCopyWith<$Res> {
  factory $VideoQualityCopyWith(
          VideoQuality value, $Res Function(VideoQuality) _then) =
      _$VideoQualityCopyWithImpl;
  @useResult
  $Res call({String resolution, int? bitrate, bool? isReady});
}

/// @nodoc
class _$VideoQualityCopyWithImpl<$Res> implements $VideoQualityCopyWith<$Res> {
  _$VideoQualityCopyWithImpl(this._self, this._then);

  final VideoQuality _self;
  final $Res Function(VideoQuality) _then;

  /// Create a copy of VideoQuality
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolution = null,
    Object? bitrate = freezed,
    Object? isReady = freezed,
  }) {
    return _then(_self.copyWith(
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      bitrate: freezed == bitrate
          ? _self.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int?,
      isReady: freezed == isReady
          ? _self.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [VideoQuality].
extension VideoQualityPatterns on VideoQuality {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_VideoQuality value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoQuality() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_VideoQuality value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoQuality():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_VideoQuality value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoQuality() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String resolution, int? bitrate, bool? isReady)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VideoQuality() when $default != null:
        return $default(_that.resolution, _that.bitrate, _that.isReady);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String resolution, int? bitrate, bool? isReady) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoQuality():
        return $default(_that.resolution, _that.bitrate, _that.isReady);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String resolution, int? bitrate, bool? isReady)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VideoQuality() when $default != null:
        return $default(_that.resolution, _that.bitrate, _that.isReady);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VideoQuality implements VideoQuality {
  const _VideoQuality({required this.resolution, this.bitrate, this.isReady});
  factory _VideoQuality.fromJson(Map<String, dynamic> json) =>
      _$VideoQualityFromJson(json);

  @override
  final String resolution;
  @override
  final int? bitrate;
  @override
  final bool? isReady;

  /// Create a copy of VideoQuality
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VideoQualityCopyWith<_VideoQuality> get copyWith =>
      __$VideoQualityCopyWithImpl<_VideoQuality>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VideoQualityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VideoQuality &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.bitrate, bitrate) || other.bitrate == bitrate) &&
            (identical(other.isReady, isReady) || other.isReady == isReady));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, resolution, bitrate, isReady);

  @override
  String toString() {
    return 'VideoQuality(resolution: $resolution, bitrate: $bitrate, isReady: $isReady)';
  }
}

/// @nodoc
abstract mixin class _$VideoQualityCopyWith<$Res>
    implements $VideoQualityCopyWith<$Res> {
  factory _$VideoQualityCopyWith(
          _VideoQuality value, $Res Function(_VideoQuality) _then) =
      __$VideoQualityCopyWithImpl;
  @override
  @useResult
  $Res call({String resolution, int? bitrate, bool? isReady});
}

/// @nodoc
class __$VideoQualityCopyWithImpl<$Res>
    implements _$VideoQualityCopyWith<$Res> {
  __$VideoQualityCopyWithImpl(this._self, this._then);

  final _VideoQuality _self;
  final $Res Function(_VideoQuality) _then;

  /// Create a copy of VideoQuality
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? resolution = null,
    Object? bitrate = freezed,
    Object? isReady = freezed,
  }) {
    return _then(_VideoQuality(
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as String,
      bitrate: freezed == bitrate
          ? _self.bitrate
          : bitrate // ignore: cast_nullable_to_non_nullable
              as int?,
      isReady: freezed == isReady
          ? _self.isReady
          : isReady // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$Subtitle {
  int get id;
  String get languageCode;
  String get label;
  String get format;
  String get s3Url;
  bool? get isDefault;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubtitleCopyWith<Subtitle> get copyWith =>
      _$SubtitleCopyWithImpl<Subtitle>(this as Subtitle, _$identity);

  /// Serializes this Subtitle to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Subtitle &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.s3Url, s3Url) || other.s3Url == s3Url) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, languageCode, label, format, s3Url, isDefault);

  @override
  String toString() {
    return 'Subtitle(id: $id, languageCode: $languageCode, label: $label, format: $format, s3Url: $s3Url, isDefault: $isDefault)';
  }
}

/// @nodoc
abstract mixin class $SubtitleCopyWith<$Res> {
  factory $SubtitleCopyWith(Subtitle value, $Res Function(Subtitle) _then) =
      _$SubtitleCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String languageCode,
      String label,
      String format,
      String s3Url,
      bool? isDefault});
}

/// @nodoc
class _$SubtitleCopyWithImpl<$Res> implements $SubtitleCopyWith<$Res> {
  _$SubtitleCopyWithImpl(this._self, this._then);

  final Subtitle _self;
  final $Res Function(Subtitle) _then;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? languageCode = null,
    Object? label = null,
    Object? format = null,
    Object? s3Url = null,
    Object? isDefault = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      languageCode: null == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      s3Url: null == s3Url
          ? _self.s3Url
          : s3Url // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Subtitle].
extension SubtitlePatterns on Subtitle {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Subtitle value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Subtitle value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Subtitle value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String languageCode, String label, String format,
            String s3Url, bool? isDefault)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
        return $default(_that.id, _that.languageCode, _that.label, _that.format,
            _that.s3Url, _that.isDefault);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String languageCode, String label, String format,
            String s3Url, bool? isDefault)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle():
        return $default(_that.id, _that.languageCode, _that.label, _that.format,
            _that.s3Url, _that.isDefault);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String languageCode, String label, String format,
            String s3Url, bool? isDefault)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subtitle() when $default != null:
        return $default(_that.id, _that.languageCode, _that.label, _that.format,
            _that.s3Url, _that.isDefault);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Subtitle implements Subtitle {
  const _Subtitle(
      {required this.id,
      required this.languageCode,
      required this.label,
      required this.format,
      required this.s3Url,
      this.isDefault});
  factory _Subtitle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFromJson(json);

  @override
  final int id;
  @override
  final String languageCode;
  @override
  final String label;
  @override
  final String format;
  @override
  final String s3Url;
  @override
  final bool? isDefault;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubtitleCopyWith<_Subtitle> get copyWith =>
      __$SubtitleCopyWithImpl<_Subtitle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubtitleToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Subtitle &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.s3Url, s3Url) || other.s3Url == s3Url) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, languageCode, label, format, s3Url, isDefault);

  @override
  String toString() {
    return 'Subtitle(id: $id, languageCode: $languageCode, label: $label, format: $format, s3Url: $s3Url, isDefault: $isDefault)';
  }
}

/// @nodoc
abstract mixin class _$SubtitleCopyWith<$Res>
    implements $SubtitleCopyWith<$Res> {
  factory _$SubtitleCopyWith(_Subtitle value, $Res Function(_Subtitle) _then) =
      __$SubtitleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String languageCode,
      String label,
      String format,
      String s3Url,
      bool? isDefault});
}

/// @nodoc
class __$SubtitleCopyWithImpl<$Res> implements _$SubtitleCopyWith<$Res> {
  __$SubtitleCopyWithImpl(this._self, this._then);

  final _Subtitle _self;
  final $Res Function(_Subtitle) _then;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? languageCode = null,
    Object? label = null,
    Object? format = null,
    Object? s3Url = null,
    Object? isDefault = freezed,
  }) {
    return _then(_Subtitle(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      languageCode: null == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      s3Url: null == s3Url
          ? _self.s3Url
          : s3Url // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$AudioTrack {
  int get id;
  String get languageCode;
  String get label;
  int get trackIndex;
  bool? get isDefault;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AudioTrackCopyWith<AudioTrack> get copyWith =>
      _$AudioTrackCopyWithImpl<AudioTrack>(this as AudioTrack, _$identity);

  /// Serializes this AudioTrack to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AudioTrack &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.trackIndex, trackIndex) ||
                other.trackIndex == trackIndex) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, languageCode, label, trackIndex, isDefault);

  @override
  String toString() {
    return 'AudioTrack(id: $id, languageCode: $languageCode, label: $label, trackIndex: $trackIndex, isDefault: $isDefault)';
  }
}

/// @nodoc
abstract mixin class $AudioTrackCopyWith<$Res> {
  factory $AudioTrackCopyWith(
          AudioTrack value, $Res Function(AudioTrack) _then) =
      _$AudioTrackCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String languageCode,
      String label,
      int trackIndex,
      bool? isDefault});
}

/// @nodoc
class _$AudioTrackCopyWithImpl<$Res> implements $AudioTrackCopyWith<$Res> {
  _$AudioTrackCopyWithImpl(this._self, this._then);

  final AudioTrack _self;
  final $Res Function(AudioTrack) _then;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? languageCode = null,
    Object? label = null,
    Object? trackIndex = null,
    Object? isDefault = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      languageCode: null == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      trackIndex: null == trackIndex
          ? _self.trackIndex
          : trackIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AudioTrack].
extension AudioTrackPatterns on AudioTrack {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AudioTrack value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AudioTrack() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AudioTrack value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioTrack():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AudioTrack value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioTrack() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String languageCode, String label, int trackIndex,
            bool? isDefault)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AudioTrack() when $default != null:
        return $default(_that.id, _that.languageCode, _that.label,
            _that.trackIndex, _that.isDefault);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String languageCode, String label, int trackIndex,
            bool? isDefault)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioTrack():
        return $default(_that.id, _that.languageCode, _that.label,
            _that.trackIndex, _that.isDefault);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String languageCode, String label, int trackIndex,
            bool? isDefault)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AudioTrack() when $default != null:
        return $default(_that.id, _that.languageCode, _that.label,
            _that.trackIndex, _that.isDefault);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AudioTrack implements AudioTrack {
  const _AudioTrack(
      {required this.id,
      required this.languageCode,
      required this.label,
      required this.trackIndex,
      this.isDefault});
  factory _AudioTrack.fromJson(Map<String, dynamic> json) =>
      _$AudioTrackFromJson(json);

  @override
  final int id;
  @override
  final String languageCode;
  @override
  final String label;
  @override
  final int trackIndex;
  @override
  final bool? isDefault;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AudioTrackCopyWith<_AudioTrack> get copyWith =>
      __$AudioTrackCopyWithImpl<_AudioTrack>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AudioTrackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AudioTrack &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.trackIndex, trackIndex) ||
                other.trackIndex == trackIndex) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, languageCode, label, trackIndex, isDefault);

  @override
  String toString() {
    return 'AudioTrack(id: $id, languageCode: $languageCode, label: $label, trackIndex: $trackIndex, isDefault: $isDefault)';
  }
}

/// @nodoc
abstract mixin class _$AudioTrackCopyWith<$Res>
    implements $AudioTrackCopyWith<$Res> {
  factory _$AudioTrackCopyWith(
          _AudioTrack value, $Res Function(_AudioTrack) _then) =
      __$AudioTrackCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String languageCode,
      String label,
      int trackIndex,
      bool? isDefault});
}

/// @nodoc
class __$AudioTrackCopyWithImpl<$Res> implements _$AudioTrackCopyWith<$Res> {
  __$AudioTrackCopyWithImpl(this._self, this._then);

  final _AudioTrack _self;
  final $Res Function(_AudioTrack) _then;

  /// Create a copy of AudioTrack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? languageCode = null,
    Object? label = null,
    Object? trackIndex = null,
    Object? isDefault = freezed,
  }) {
    return _then(_AudioTrack(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      languageCode: null == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      trackIndex: null == trackIndex
          ? _self.trackIndex
          : trackIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$WatchProgress {
  int get watchedSeconds;
  int get totalSeconds;
  double get completionPct;
  bool? get isCompleted;
  DateTime? get lastWatchedAt;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WatchProgressCopyWith<WatchProgress> get copyWith =>
      _$WatchProgressCopyWithImpl<WatchProgress>(
          this as WatchProgress, _$identity);

  /// Serializes this WatchProgress to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WatchProgress &&
            (identical(other.watchedSeconds, watchedSeconds) ||
                other.watchedSeconds == watchedSeconds) &&
            (identical(other.totalSeconds, totalSeconds) ||
                other.totalSeconds == totalSeconds) &&
            (identical(other.completionPct, completionPct) ||
                other.completionPct == completionPct) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.lastWatchedAt, lastWatchedAt) ||
                other.lastWatchedAt == lastWatchedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, watchedSeconds, totalSeconds,
      completionPct, isCompleted, lastWatchedAt);

  @override
  String toString() {
    return 'WatchProgress(watchedSeconds: $watchedSeconds, totalSeconds: $totalSeconds, completionPct: $completionPct, isCompleted: $isCompleted, lastWatchedAt: $lastWatchedAt)';
  }
}

/// @nodoc
abstract mixin class $WatchProgressCopyWith<$Res> {
  factory $WatchProgressCopyWith(
          WatchProgress value, $Res Function(WatchProgress) _then) =
      _$WatchProgressCopyWithImpl;
  @useResult
  $Res call(
      {int watchedSeconds,
      int totalSeconds,
      double completionPct,
      bool? isCompleted,
      DateTime? lastWatchedAt});
}

/// @nodoc
class _$WatchProgressCopyWithImpl<$Res>
    implements $WatchProgressCopyWith<$Res> {
  _$WatchProgressCopyWithImpl(this._self, this._then);

  final WatchProgress _self;
  final $Res Function(WatchProgress) _then;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? watchedSeconds = null,
    Object? totalSeconds = null,
    Object? completionPct = null,
    Object? isCompleted = freezed,
    Object? lastWatchedAt = freezed,
  }) {
    return _then(_self.copyWith(
      watchedSeconds: null == watchedSeconds
          ? _self.watchedSeconds
          : watchedSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      totalSeconds: null == totalSeconds
          ? _self.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      completionPct: null == completionPct
          ? _self.completionPct
          : completionPct // ignore: cast_nullable_to_non_nullable
              as double,
      isCompleted: freezed == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastWatchedAt: freezed == lastWatchedAt
          ? _self.lastWatchedAt
          : lastWatchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WatchProgress].
extension WatchProgressPatterns on WatchProgress {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WatchProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WatchProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_WatchProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int watchedSeconds, int totalSeconds, double completionPct,
            bool? isCompleted, DateTime? lastWatchedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
        return $default(_that.watchedSeconds, _that.totalSeconds,
            _that.completionPct, _that.isCompleted, _that.lastWatchedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int watchedSeconds, int totalSeconds, double completionPct,
            bool? isCompleted, DateTime? lastWatchedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress():
        return $default(_that.watchedSeconds, _that.totalSeconds,
            _that.completionPct, _that.isCompleted, _that.lastWatchedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int watchedSeconds, int totalSeconds,
            double completionPct, bool? isCompleted, DateTime? lastWatchedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchProgress() when $default != null:
        return $default(_that.watchedSeconds, _that.totalSeconds,
            _that.completionPct, _that.isCompleted, _that.lastWatchedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WatchProgress implements WatchProgress {
  const _WatchProgress(
      {required this.watchedSeconds,
      required this.totalSeconds,
      required this.completionPct,
      this.isCompleted,
      this.lastWatchedAt});
  factory _WatchProgress.fromJson(Map<String, dynamic> json) =>
      _$WatchProgressFromJson(json);

  @override
  final int watchedSeconds;
  @override
  final int totalSeconds;
  @override
  final double completionPct;
  @override
  final bool? isCompleted;
  @override
  final DateTime? lastWatchedAt;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WatchProgressCopyWith<_WatchProgress> get copyWith =>
      __$WatchProgressCopyWithImpl<_WatchProgress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WatchProgressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WatchProgress &&
            (identical(other.watchedSeconds, watchedSeconds) ||
                other.watchedSeconds == watchedSeconds) &&
            (identical(other.totalSeconds, totalSeconds) ||
                other.totalSeconds == totalSeconds) &&
            (identical(other.completionPct, completionPct) ||
                other.completionPct == completionPct) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.lastWatchedAt, lastWatchedAt) ||
                other.lastWatchedAt == lastWatchedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, watchedSeconds, totalSeconds,
      completionPct, isCompleted, lastWatchedAt);

  @override
  String toString() {
    return 'WatchProgress(watchedSeconds: $watchedSeconds, totalSeconds: $totalSeconds, completionPct: $completionPct, isCompleted: $isCompleted, lastWatchedAt: $lastWatchedAt)';
  }
}

/// @nodoc
abstract mixin class _$WatchProgressCopyWith<$Res>
    implements $WatchProgressCopyWith<$Res> {
  factory _$WatchProgressCopyWith(
          _WatchProgress value, $Res Function(_WatchProgress) _then) =
      __$WatchProgressCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int watchedSeconds,
      int totalSeconds,
      double completionPct,
      bool? isCompleted,
      DateTime? lastWatchedAt});
}

/// @nodoc
class __$WatchProgressCopyWithImpl<$Res>
    implements _$WatchProgressCopyWith<$Res> {
  __$WatchProgressCopyWithImpl(this._self, this._then);

  final _WatchProgress _self;
  final $Res Function(_WatchProgress) _then;

  /// Create a copy of WatchProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? watchedSeconds = null,
    Object? totalSeconds = null,
    Object? completionPct = null,
    Object? isCompleted = freezed,
    Object? lastWatchedAt = freezed,
  }) {
    return _then(_WatchProgress(
      watchedSeconds: null == watchedSeconds
          ? _self.watchedSeconds
          : watchedSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      totalSeconds: null == totalSeconds
          ? _self.totalSeconds
          : totalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      completionPct: null == completionPct
          ? _self.completionPct
          : completionPct // ignore: cast_nullable_to_non_nullable
              as double,
      isCompleted: freezed == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastWatchedAt: freezed == lastWatchedAt
          ? _self.lastWatchedAt
          : lastWatchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$LiveStream {
  int get id;
  String get title;
  String get status;
  String get streamType;
  String get accessTier;
  String? get description;
  String? get thumbnailUrl;
  String? get playbackUrl;
  String? get youTubeLiveId;
  String? get vimeoEventId;
  double? get ppvPrice;
  int? get currentViewers;
  int? get totalViewers;
  DateTime? get scheduledAt;
  DateTime? get startedAt;
  bool? get chatEnabled;
  bool? get dvrEnabled;

  /// Create a copy of LiveStream
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LiveStreamCopyWith<LiveStream> get copyWith =>
      _$LiveStreamCopyWithImpl<LiveStream>(this as LiveStream, _$identity);

  /// Serializes this LiveStream to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LiveStream &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.streamType, streamType) ||
                other.streamType == streamType) &&
            (identical(other.accessTier, accessTier) ||
                other.accessTier == accessTier) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.playbackUrl, playbackUrl) ||
                other.playbackUrl == playbackUrl) &&
            (identical(other.youTubeLiveId, youTubeLiveId) ||
                other.youTubeLiveId == youTubeLiveId) &&
            (identical(other.vimeoEventId, vimeoEventId) ||
                other.vimeoEventId == vimeoEventId) &&
            (identical(other.ppvPrice, ppvPrice) ||
                other.ppvPrice == ppvPrice) &&
            (identical(other.currentViewers, currentViewers) ||
                other.currentViewers == currentViewers) &&
            (identical(other.totalViewers, totalViewers) ||
                other.totalViewers == totalViewers) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.chatEnabled, chatEnabled) ||
                other.chatEnabled == chatEnabled) &&
            (identical(other.dvrEnabled, dvrEnabled) ||
                other.dvrEnabled == dvrEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      status,
      streamType,
      accessTier,
      description,
      thumbnailUrl,
      playbackUrl,
      youTubeLiveId,
      vimeoEventId,
      ppvPrice,
      currentViewers,
      totalViewers,
      scheduledAt,
      startedAt,
      chatEnabled,
      dvrEnabled);

  @override
  String toString() {
    return 'LiveStream(id: $id, title: $title, status: $status, streamType: $streamType, accessTier: $accessTier, description: $description, thumbnailUrl: $thumbnailUrl, playbackUrl: $playbackUrl, youTubeLiveId: $youTubeLiveId, vimeoEventId: $vimeoEventId, ppvPrice: $ppvPrice, currentViewers: $currentViewers, totalViewers: $totalViewers, scheduledAt: $scheduledAt, startedAt: $startedAt, chatEnabled: $chatEnabled, dvrEnabled: $dvrEnabled)';
  }
}

/// @nodoc
abstract mixin class $LiveStreamCopyWith<$Res> {
  factory $LiveStreamCopyWith(
          LiveStream value, $Res Function(LiveStream) _then) =
      _$LiveStreamCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String status,
      String streamType,
      String accessTier,
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
      bool? dvrEnabled});
}

/// @nodoc
class _$LiveStreamCopyWithImpl<$Res> implements $LiveStreamCopyWith<$Res> {
  _$LiveStreamCopyWithImpl(this._self, this._then);

  final LiveStream _self;
  final $Res Function(LiveStream) _then;

  /// Create a copy of LiveStream
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? status = null,
    Object? streamType = null,
    Object? accessTier = null,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? playbackUrl = freezed,
    Object? youTubeLiveId = freezed,
    Object? vimeoEventId = freezed,
    Object? ppvPrice = freezed,
    Object? currentViewers = freezed,
    Object? totalViewers = freezed,
    Object? scheduledAt = freezed,
    Object? startedAt = freezed,
    Object? chatEnabled = freezed,
    Object? dvrEnabled = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      streamType: null == streamType
          ? _self.streamType
          : streamType // ignore: cast_nullable_to_non_nullable
              as String,
      accessTier: null == accessTier
          ? _self.accessTier
          : accessTier // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      playbackUrl: freezed == playbackUrl
          ? _self.playbackUrl
          : playbackUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      youTubeLiveId: freezed == youTubeLiveId
          ? _self.youTubeLiveId
          : youTubeLiveId // ignore: cast_nullable_to_non_nullable
              as String?,
      vimeoEventId: freezed == vimeoEventId
          ? _self.vimeoEventId
          : vimeoEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      ppvPrice: freezed == ppvPrice
          ? _self.ppvPrice
          : ppvPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      currentViewers: freezed == currentViewers
          ? _self.currentViewers
          : currentViewers // ignore: cast_nullable_to_non_nullable
              as int?,
      totalViewers: freezed == totalViewers
          ? _self.totalViewers
          : totalViewers // ignore: cast_nullable_to_non_nullable
              as int?,
      scheduledAt: freezed == scheduledAt
          ? _self.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatEnabled: freezed == chatEnabled
          ? _self.chatEnabled
          : chatEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      dvrEnabled: freezed == dvrEnabled
          ? _self.dvrEnabled
          : dvrEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LiveStream].
extension LiveStreamPatterns on LiveStream {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LiveStream value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LiveStream() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LiveStream value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveStream():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LiveStream value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveStream() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String title,
            String status,
            String streamType,
            String accessTier,
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
            bool? dvrEnabled)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LiveStream() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.status,
            _that.streamType,
            _that.accessTier,
            _that.description,
            _that.thumbnailUrl,
            _that.playbackUrl,
            _that.youTubeLiveId,
            _that.vimeoEventId,
            _that.ppvPrice,
            _that.currentViewers,
            _that.totalViewers,
            _that.scheduledAt,
            _that.startedAt,
            _that.chatEnabled,
            _that.dvrEnabled);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String title,
            String status,
            String streamType,
            String accessTier,
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
            bool? dvrEnabled)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveStream():
        return $default(
            _that.id,
            _that.title,
            _that.status,
            _that.streamType,
            _that.accessTier,
            _that.description,
            _that.thumbnailUrl,
            _that.playbackUrl,
            _that.youTubeLiveId,
            _that.vimeoEventId,
            _that.ppvPrice,
            _that.currentViewers,
            _that.totalViewers,
            _that.scheduledAt,
            _that.startedAt,
            _that.chatEnabled,
            _that.dvrEnabled);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String title,
            String status,
            String streamType,
            String accessTier,
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
            bool? dvrEnabled)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LiveStream() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.status,
            _that.streamType,
            _that.accessTier,
            _that.description,
            _that.thumbnailUrl,
            _that.playbackUrl,
            _that.youTubeLiveId,
            _that.vimeoEventId,
            _that.ppvPrice,
            _that.currentViewers,
            _that.totalViewers,
            _that.scheduledAt,
            _that.startedAt,
            _that.chatEnabled,
            _that.dvrEnabled);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LiveStream implements LiveStream {
  const _LiveStream(
      {required this.id,
      required this.title,
      required this.status,
      required this.streamType,
      required this.accessTier,
      this.description,
      this.thumbnailUrl,
      this.playbackUrl,
      this.youTubeLiveId,
      this.vimeoEventId,
      this.ppvPrice,
      this.currentViewers,
      this.totalViewers,
      this.scheduledAt,
      this.startedAt,
      this.chatEnabled,
      this.dvrEnabled});
  factory _LiveStream.fromJson(Map<String, dynamic> json) =>
      _$LiveStreamFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String status;
  @override
  final String streamType;
  @override
  final String accessTier;
  @override
  final String? description;
  @override
  final String? thumbnailUrl;
  @override
  final String? playbackUrl;
  @override
  final String? youTubeLiveId;
  @override
  final String? vimeoEventId;
  @override
  final double? ppvPrice;
  @override
  final int? currentViewers;
  @override
  final int? totalViewers;
  @override
  final DateTime? scheduledAt;
  @override
  final DateTime? startedAt;
  @override
  final bool? chatEnabled;
  @override
  final bool? dvrEnabled;

  /// Create a copy of LiveStream
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LiveStreamCopyWith<_LiveStream> get copyWith =>
      __$LiveStreamCopyWithImpl<_LiveStream>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LiveStreamToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LiveStream &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.streamType, streamType) ||
                other.streamType == streamType) &&
            (identical(other.accessTier, accessTier) ||
                other.accessTier == accessTier) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.playbackUrl, playbackUrl) ||
                other.playbackUrl == playbackUrl) &&
            (identical(other.youTubeLiveId, youTubeLiveId) ||
                other.youTubeLiveId == youTubeLiveId) &&
            (identical(other.vimeoEventId, vimeoEventId) ||
                other.vimeoEventId == vimeoEventId) &&
            (identical(other.ppvPrice, ppvPrice) ||
                other.ppvPrice == ppvPrice) &&
            (identical(other.currentViewers, currentViewers) ||
                other.currentViewers == currentViewers) &&
            (identical(other.totalViewers, totalViewers) ||
                other.totalViewers == totalViewers) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.chatEnabled, chatEnabled) ||
                other.chatEnabled == chatEnabled) &&
            (identical(other.dvrEnabled, dvrEnabled) ||
                other.dvrEnabled == dvrEnabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      status,
      streamType,
      accessTier,
      description,
      thumbnailUrl,
      playbackUrl,
      youTubeLiveId,
      vimeoEventId,
      ppvPrice,
      currentViewers,
      totalViewers,
      scheduledAt,
      startedAt,
      chatEnabled,
      dvrEnabled);

  @override
  String toString() {
    return 'LiveStream(id: $id, title: $title, status: $status, streamType: $streamType, accessTier: $accessTier, description: $description, thumbnailUrl: $thumbnailUrl, playbackUrl: $playbackUrl, youTubeLiveId: $youTubeLiveId, vimeoEventId: $vimeoEventId, ppvPrice: $ppvPrice, currentViewers: $currentViewers, totalViewers: $totalViewers, scheduledAt: $scheduledAt, startedAt: $startedAt, chatEnabled: $chatEnabled, dvrEnabled: $dvrEnabled)';
  }
}

/// @nodoc
abstract mixin class _$LiveStreamCopyWith<$Res>
    implements $LiveStreamCopyWith<$Res> {
  factory _$LiveStreamCopyWith(
          _LiveStream value, $Res Function(_LiveStream) _then) =
      __$LiveStreamCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String status,
      String streamType,
      String accessTier,
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
      bool? dvrEnabled});
}

/// @nodoc
class __$LiveStreamCopyWithImpl<$Res> implements _$LiveStreamCopyWith<$Res> {
  __$LiveStreamCopyWithImpl(this._self, this._then);

  final _LiveStream _self;
  final $Res Function(_LiveStream) _then;

  /// Create a copy of LiveStream
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? status = null,
    Object? streamType = null,
    Object? accessTier = null,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? playbackUrl = freezed,
    Object? youTubeLiveId = freezed,
    Object? vimeoEventId = freezed,
    Object? ppvPrice = freezed,
    Object? currentViewers = freezed,
    Object? totalViewers = freezed,
    Object? scheduledAt = freezed,
    Object? startedAt = freezed,
    Object? chatEnabled = freezed,
    Object? dvrEnabled = freezed,
  }) {
    return _then(_LiveStream(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      streamType: null == streamType
          ? _self.streamType
          : streamType // ignore: cast_nullable_to_non_nullable
              as String,
      accessTier: null == accessTier
          ? _self.accessTier
          : accessTier // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailUrl: freezed == thumbnailUrl
          ? _self.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      playbackUrl: freezed == playbackUrl
          ? _self.playbackUrl
          : playbackUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      youTubeLiveId: freezed == youTubeLiveId
          ? _self.youTubeLiveId
          : youTubeLiveId // ignore: cast_nullable_to_non_nullable
              as String?,
      vimeoEventId: freezed == vimeoEventId
          ? _self.vimeoEventId
          : vimeoEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      ppvPrice: freezed == ppvPrice
          ? _self.ppvPrice
          : ppvPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      currentViewers: freezed == currentViewers
          ? _self.currentViewers
          : currentViewers // ignore: cast_nullable_to_non_nullable
              as int?,
      totalViewers: freezed == totalViewers
          ? _self.totalViewers
          : totalViewers // ignore: cast_nullable_to_non_nullable
              as int?,
      scheduledAt: freezed == scheduledAt
          ? _self.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chatEnabled: freezed == chatEnabled
          ? _self.chatEnabled
          : chatEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      dvrEnabled: freezed == dvrEnabled
          ? _self.dvrEnabled
          : dvrEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$SubscriptionPlan {
  int get id;
  String get name;
  double get price;
  String get currency;
  String get billingCycle;
  int? get trialDays;
  int? get maxProfiles;
  int? get maxDevices;
  String? get maxQuality;
  bool? get allowDownload;
  bool? get adFree;
  List<String>? get features;
  bool? get isActive;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubscriptionPlanCopyWith<SubscriptionPlan> get copyWith =>
      _$SubscriptionPlanCopyWithImpl<SubscriptionPlan>(
          this as SubscriptionPlan, _$identity);

  /// Serializes this SubscriptionPlan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubscriptionPlan &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.billingCycle, billingCycle) ||
                other.billingCycle == billingCycle) &&
            (identical(other.trialDays, trialDays) ||
                other.trialDays == trialDays) &&
            (identical(other.maxProfiles, maxProfiles) ||
                other.maxProfiles == maxProfiles) &&
            (identical(other.maxDevices, maxDevices) ||
                other.maxDevices == maxDevices) &&
            (identical(other.maxQuality, maxQuality) ||
                other.maxQuality == maxQuality) &&
            (identical(other.allowDownload, allowDownload) ||
                other.allowDownload == allowDownload) &&
            (identical(other.adFree, adFree) || other.adFree == adFree) &&
            const DeepCollectionEquality().equals(other.features, features) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      price,
      currency,
      billingCycle,
      trialDays,
      maxProfiles,
      maxDevices,
      maxQuality,
      allowDownload,
      adFree,
      const DeepCollectionEquality().hash(features),
      isActive);

  @override
  String toString() {
    return 'SubscriptionPlan(id: $id, name: $name, price: $price, currency: $currency, billingCycle: $billingCycle, trialDays: $trialDays, maxProfiles: $maxProfiles, maxDevices: $maxDevices, maxQuality: $maxQuality, allowDownload: $allowDownload, adFree: $adFree, features: $features, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class $SubscriptionPlanCopyWith<$Res> {
  factory $SubscriptionPlanCopyWith(
          SubscriptionPlan value, $Res Function(SubscriptionPlan) _then) =
      _$SubscriptionPlanCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      double price,
      String currency,
      String billingCycle,
      int? trialDays,
      int? maxProfiles,
      int? maxDevices,
      String? maxQuality,
      bool? allowDownload,
      bool? adFree,
      List<String>? features,
      bool? isActive});
}

/// @nodoc
class _$SubscriptionPlanCopyWithImpl<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  _$SubscriptionPlanCopyWithImpl(this._self, this._then);

  final SubscriptionPlan _self;
  final $Res Function(SubscriptionPlan) _then;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? currency = null,
    Object? billingCycle = null,
    Object? trialDays = freezed,
    Object? maxProfiles = freezed,
    Object? maxDevices = freezed,
    Object? maxQuality = freezed,
    Object? allowDownload = freezed,
    Object? adFree = freezed,
    Object? features = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      billingCycle: null == billingCycle
          ? _self.billingCycle
          : billingCycle // ignore: cast_nullable_to_non_nullable
              as String,
      trialDays: freezed == trialDays
          ? _self.trialDays
          : trialDays // ignore: cast_nullable_to_non_nullable
              as int?,
      maxProfiles: freezed == maxProfiles
          ? _self.maxProfiles
          : maxProfiles // ignore: cast_nullable_to_non_nullable
              as int?,
      maxDevices: freezed == maxDevices
          ? _self.maxDevices
          : maxDevices // ignore: cast_nullable_to_non_nullable
              as int?,
      maxQuality: freezed == maxQuality
          ? _self.maxQuality
          : maxQuality // ignore: cast_nullable_to_non_nullable
              as String?,
      allowDownload: freezed == allowDownload
          ? _self.allowDownload
          : allowDownload // ignore: cast_nullable_to_non_nullable
              as bool?,
      adFree: freezed == adFree
          ? _self.adFree
          : adFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      features: freezed == features
          ? _self.features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isActive: freezed == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubscriptionPlan].
extension SubscriptionPlanPatterns on SubscriptionPlan {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SubscriptionPlan value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubscriptionPlan() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SubscriptionPlan value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionPlan():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SubscriptionPlan value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionPlan() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String name,
            double price,
            String currency,
            String billingCycle,
            int? trialDays,
            int? maxProfiles,
            int? maxDevices,
            String? maxQuality,
            bool? allowDownload,
            bool? adFree,
            List<String>? features,
            bool? isActive)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubscriptionPlan() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.price,
            _that.currency,
            _that.billingCycle,
            _that.trialDays,
            _that.maxProfiles,
            _that.maxDevices,
            _that.maxQuality,
            _that.allowDownload,
            _that.adFree,
            _that.features,
            _that.isActive);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String name,
            double price,
            String currency,
            String billingCycle,
            int? trialDays,
            int? maxProfiles,
            int? maxDevices,
            String? maxQuality,
            bool? allowDownload,
            bool? adFree,
            List<String>? features,
            bool? isActive)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionPlan():
        return $default(
            _that.id,
            _that.name,
            _that.price,
            _that.currency,
            _that.billingCycle,
            _that.trialDays,
            _that.maxProfiles,
            _that.maxDevices,
            _that.maxQuality,
            _that.allowDownload,
            _that.adFree,
            _that.features,
            _that.isActive);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String name,
            double price,
            String currency,
            String billingCycle,
            int? trialDays,
            int? maxProfiles,
            int? maxDevices,
            String? maxQuality,
            bool? allowDownload,
            bool? adFree,
            List<String>? features,
            bool? isActive)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubscriptionPlan() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.price,
            _that.currency,
            _that.billingCycle,
            _that.trialDays,
            _that.maxProfiles,
            _that.maxDevices,
            _that.maxQuality,
            _that.allowDownload,
            _that.adFree,
            _that.features,
            _that.isActive);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SubscriptionPlan implements SubscriptionPlan {
  const _SubscriptionPlan(
      {required this.id,
      required this.name,
      required this.price,
      required this.currency,
      required this.billingCycle,
      this.trialDays,
      this.maxProfiles,
      this.maxDevices,
      this.maxQuality,
      this.allowDownload,
      this.adFree,
      final List<String>? features,
      this.isActive})
      : _features = features;
  factory _SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final double price;
  @override
  final String currency;
  @override
  final String billingCycle;
  @override
  final int? trialDays;
  @override
  final int? maxProfiles;
  @override
  final int? maxDevices;
  @override
  final String? maxQuality;
  @override
  final bool? allowDownload;
  @override
  final bool? adFree;
  final List<String>? _features;
  @override
  List<String>? get features {
    final value = _features;
    if (value == null) return null;
    if (_features is EqualUnmodifiableListView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isActive;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubscriptionPlanCopyWith<_SubscriptionPlan> get copyWith =>
      __$SubscriptionPlanCopyWithImpl<_SubscriptionPlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubscriptionPlanToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubscriptionPlan &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.billingCycle, billingCycle) ||
                other.billingCycle == billingCycle) &&
            (identical(other.trialDays, trialDays) ||
                other.trialDays == trialDays) &&
            (identical(other.maxProfiles, maxProfiles) ||
                other.maxProfiles == maxProfiles) &&
            (identical(other.maxDevices, maxDevices) ||
                other.maxDevices == maxDevices) &&
            (identical(other.maxQuality, maxQuality) ||
                other.maxQuality == maxQuality) &&
            (identical(other.allowDownload, allowDownload) ||
                other.allowDownload == allowDownload) &&
            (identical(other.adFree, adFree) || other.adFree == adFree) &&
            const DeepCollectionEquality().equals(other._features, _features) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      price,
      currency,
      billingCycle,
      trialDays,
      maxProfiles,
      maxDevices,
      maxQuality,
      allowDownload,
      adFree,
      const DeepCollectionEquality().hash(_features),
      isActive);

  @override
  String toString() {
    return 'SubscriptionPlan(id: $id, name: $name, price: $price, currency: $currency, billingCycle: $billingCycle, trialDays: $trialDays, maxProfiles: $maxProfiles, maxDevices: $maxDevices, maxQuality: $maxQuality, allowDownload: $allowDownload, adFree: $adFree, features: $features, isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$SubscriptionPlanCopyWith<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  factory _$SubscriptionPlanCopyWith(
          _SubscriptionPlan value, $Res Function(_SubscriptionPlan) _then) =
      __$SubscriptionPlanCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      double price,
      String currency,
      String billingCycle,
      int? trialDays,
      int? maxProfiles,
      int? maxDevices,
      String? maxQuality,
      bool? allowDownload,
      bool? adFree,
      List<String>? features,
      bool? isActive});
}

/// @nodoc
class __$SubscriptionPlanCopyWithImpl<$Res>
    implements _$SubscriptionPlanCopyWith<$Res> {
  __$SubscriptionPlanCopyWithImpl(this._self, this._then);

  final _SubscriptionPlan _self;
  final $Res Function(_SubscriptionPlan) _then;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? currency = null,
    Object? billingCycle = null,
    Object? trialDays = freezed,
    Object? maxProfiles = freezed,
    Object? maxDevices = freezed,
    Object? maxQuality = freezed,
    Object? allowDownload = freezed,
    Object? adFree = freezed,
    Object? features = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_SubscriptionPlan(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _self.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      billingCycle: null == billingCycle
          ? _self.billingCycle
          : billingCycle // ignore: cast_nullable_to_non_nullable
              as String,
      trialDays: freezed == trialDays
          ? _self.trialDays
          : trialDays // ignore: cast_nullable_to_non_nullable
              as int?,
      maxProfiles: freezed == maxProfiles
          ? _self.maxProfiles
          : maxProfiles // ignore: cast_nullable_to_non_nullable
              as int?,
      maxDevices: freezed == maxDevices
          ? _self.maxDevices
          : maxDevices // ignore: cast_nullable_to_non_nullable
              as int?,
      maxQuality: freezed == maxQuality
          ? _self.maxQuality
          : maxQuality // ignore: cast_nullable_to_non_nullable
              as String?,
      allowDownload: freezed == allowDownload
          ? _self.allowDownload
          : allowDownload // ignore: cast_nullable_to_non_nullable
              as bool?,
      adFree: freezed == adFree
          ? _self.adFree
          : adFree // ignore: cast_nullable_to_non_nullable
              as bool?,
      features: freezed == features
          ? _self._features
          : features // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isActive: freezed == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$UserSubscription {
  int get id;
  SubscriptionPlan get plan;
  String get status;
  DateTime get startDate;
  DateTime get endDate;
  bool? get autoRenew;
  String? get gatewayType;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserSubscriptionCopyWith<UserSubscription> get copyWith =>
      _$UserSubscriptionCopyWithImpl<UserSubscription>(
          this as UserSubscription, _$identity);

  /// Serializes this UserSubscription to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserSubscription &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.gatewayType, gatewayType) ||
                other.gatewayType == gatewayType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, plan, status, startDate,
      endDate, autoRenew, gatewayType);

  @override
  String toString() {
    return 'UserSubscription(id: $id, plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew, gatewayType: $gatewayType)';
  }
}

/// @nodoc
abstract mixin class $UserSubscriptionCopyWith<$Res> {
  factory $UserSubscriptionCopyWith(
          UserSubscription value, $Res Function(UserSubscription) _then) =
      _$UserSubscriptionCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      SubscriptionPlan plan,
      String status,
      DateTime startDate,
      DateTime endDate,
      bool? autoRenew,
      String? gatewayType});

  $SubscriptionPlanCopyWith<$Res> get plan;
}

/// @nodoc
class _$UserSubscriptionCopyWithImpl<$Res>
    implements $UserSubscriptionCopyWith<$Res> {
  _$UserSubscriptionCopyWithImpl(this._self, this._then);

  final UserSubscription _self;
  final $Res Function(UserSubscription) _then;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plan = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? autoRenew = freezed,
    Object? gatewayType = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      plan: null == plan
          ? _self.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as SubscriptionPlan,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      autoRenew: freezed == autoRenew
          ? _self.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool?,
      gatewayType: freezed == gatewayType
          ? _self.gatewayType
          : gatewayType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanCopyWith<$Res> get plan {
    return $SubscriptionPlanCopyWith<$Res>(_self.plan, (value) {
      return _then(_self.copyWith(plan: value));
    });
  }
}

/// Adds pattern-matching-related methods to [UserSubscription].
extension UserSubscriptionPatterns on UserSubscription {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserSubscription value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSubscription() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserSubscription value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSubscription():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserSubscription value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSubscription() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            SubscriptionPlan plan,
            String status,
            DateTime startDate,
            DateTime endDate,
            bool? autoRenew,
            String? gatewayType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserSubscription() when $default != null:
        return $default(_that.id, _that.plan, _that.status, _that.startDate,
            _that.endDate, _that.autoRenew, _that.gatewayType);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            SubscriptionPlan plan,
            String status,
            DateTime startDate,
            DateTime endDate,
            bool? autoRenew,
            String? gatewayType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSubscription():
        return $default(_that.id, _that.plan, _that.status, _that.startDate,
            _that.endDate, _that.autoRenew, _that.gatewayType);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            SubscriptionPlan plan,
            String status,
            DateTime startDate,
            DateTime endDate,
            bool? autoRenew,
            String? gatewayType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserSubscription() when $default != null:
        return $default(_that.id, _that.plan, _that.status, _that.startDate,
            _that.endDate, _that.autoRenew, _that.gatewayType);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserSubscription implements UserSubscription {
  const _UserSubscription(
      {required this.id,
      required this.plan,
      required this.status,
      required this.startDate,
      required this.endDate,
      this.autoRenew,
      this.gatewayType});
  factory _UserSubscription.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionFromJson(json);

  @override
  final int id;
  @override
  final SubscriptionPlan plan;
  @override
  final String status;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final bool? autoRenew;
  @override
  final String? gatewayType;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserSubscriptionCopyWith<_UserSubscription> get copyWith =>
      __$UserSubscriptionCopyWithImpl<_UserSubscription>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserSubscriptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserSubscription &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.gatewayType, gatewayType) ||
                other.gatewayType == gatewayType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, plan, status, startDate,
      endDate, autoRenew, gatewayType);

  @override
  String toString() {
    return 'UserSubscription(id: $id, plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew, gatewayType: $gatewayType)';
  }
}

/// @nodoc
abstract mixin class _$UserSubscriptionCopyWith<$Res>
    implements $UserSubscriptionCopyWith<$Res> {
  factory _$UserSubscriptionCopyWith(
          _UserSubscription value, $Res Function(_UserSubscription) _then) =
      __$UserSubscriptionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      SubscriptionPlan plan,
      String status,
      DateTime startDate,
      DateTime endDate,
      bool? autoRenew,
      String? gatewayType});

  @override
  $SubscriptionPlanCopyWith<$Res> get plan;
}

/// @nodoc
class __$UserSubscriptionCopyWithImpl<$Res>
    implements _$UserSubscriptionCopyWith<$Res> {
  __$UserSubscriptionCopyWithImpl(this._self, this._then);

  final _UserSubscription _self;
  final $Res Function(_UserSubscription) _then;

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? plan = null,
    Object? status = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? autoRenew = freezed,
    Object? gatewayType = freezed,
  }) {
    return _then(_UserSubscription(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      plan: null == plan
          ? _self.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as SubscriptionPlan,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      autoRenew: freezed == autoRenew
          ? _self.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as bool?,
      gatewayType: freezed == gatewayType
          ? _self.gatewayType
          : gatewayType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of UserSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanCopyWith<$Res> get plan {
    return $SubscriptionPlanCopyWith<$Res>(_self.plan, (value) {
      return _then(_self.copyWith(plan: value));
    });
  }
}

/// @nodoc
mixin _$UserProfile {
  int get id;
  String get displayName;
  String? get avatarUrl;
  String? get avatarColor;
  bool? get isKids;
  String? get maxContentRating;
  String? get languageCode;
  bool? get isDefault;
  int? get dailyTimeLimitMinutes;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<UserProfile> get copyWith =>
      _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserProfile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.isKids, isKids) || other.isKids == isKids) &&
            (identical(other.maxContentRating, maxContentRating) ||
                other.maxContentRating == maxContentRating) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.dailyTimeLimitMinutes, dailyTimeLimitMinutes) ||
                other.dailyTimeLimitMinutes == dailyTimeLimitMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      avatarUrl,
      avatarColor,
      isKids,
      maxContentRating,
      languageCode,
      isDefault,
      dailyTimeLimitMinutes);

  @override
  String toString() {
    return 'UserProfile(id: $id, displayName: $displayName, avatarUrl: $avatarUrl, avatarColor: $avatarColor, isKids: $isKids, maxContentRating: $maxContentRating, languageCode: $languageCode, isDefault: $isDefault, dailyTimeLimitMinutes: $dailyTimeLimitMinutes)';
  }
}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) _then) =
      _$UserProfileCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String displayName,
      String? avatarUrl,
      String? avatarColor,
      bool? isKids,
      String? maxContentRating,
      String? languageCode,
      bool? isDefault,
      int? dailyTimeLimitMinutes});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res> implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? isKids = freezed,
    Object? maxContentRating = freezed,
    Object? languageCode = freezed,
    Object? isDefault = freezed,
    Object? dailyTimeLimitMinutes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarColor: freezed == avatarColor
          ? _self.avatarColor
          : avatarColor // ignore: cast_nullable_to_non_nullable
              as String?,
      isKids: freezed == isKids
          ? _self.isKids
          : isKids // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxContentRating: freezed == maxContentRating
          ? _self.maxContentRating
          : maxContentRating // ignore: cast_nullable_to_non_nullable
              as String?,
      languageCode: freezed == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      dailyTimeLimitMinutes: freezed == dailyTimeLimitMinutes
          ? _self.dailyTimeLimitMinutes
          : dailyTimeLimitMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String displayName,
            String? avatarUrl,
            String? avatarColor,
            bool? isKids,
            String? maxContentRating,
            String? languageCode,
            bool? isDefault,
            int? dailyTimeLimitMinutes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(
            _that.id,
            _that.displayName,
            _that.avatarUrl,
            _that.avatarColor,
            _that.isKids,
            _that.maxContentRating,
            _that.languageCode,
            _that.isDefault,
            _that.dailyTimeLimitMinutes);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String displayName,
            String? avatarUrl,
            String? avatarColor,
            bool? isKids,
            String? maxContentRating,
            String? languageCode,
            bool? isDefault,
            int? dailyTimeLimitMinutes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile():
        return $default(
            _that.id,
            _that.displayName,
            _that.avatarUrl,
            _that.avatarColor,
            _that.isKids,
            _that.maxContentRating,
            _that.languageCode,
            _that.isDefault,
            _that.dailyTimeLimitMinutes);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String displayName,
            String? avatarUrl,
            String? avatarColor,
            bool? isKids,
            String? maxContentRating,
            String? languageCode,
            bool? isDefault,
            int? dailyTimeLimitMinutes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserProfile() when $default != null:
        return $default(
            _that.id,
            _that.displayName,
            _that.avatarUrl,
            _that.avatarColor,
            _that.isKids,
            _that.maxContentRating,
            _that.languageCode,
            _that.isDefault,
            _that.dailyTimeLimitMinutes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserProfile implements UserProfile {
  const _UserProfile(
      {required this.id,
      required this.displayName,
      this.avatarUrl,
      this.avatarColor,
      this.isKids,
      this.maxContentRating,
      this.languageCode,
      this.isDefault,
      this.dailyTimeLimitMinutes});
  factory _UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  @override
  final int id;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final String? avatarColor;
  @override
  final bool? isKids;
  @override
  final String? maxContentRating;
  @override
  final String? languageCode;
  @override
  final bool? isDefault;
  @override
  final int? dailyTimeLimitMinutes;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserProfileCopyWith<_UserProfile> get copyWith =>
      __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserProfile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.avatarColor, avatarColor) ||
                other.avatarColor == avatarColor) &&
            (identical(other.isKids, isKids) || other.isKids == isKids) &&
            (identical(other.maxContentRating, maxContentRating) ||
                other.maxContentRating == maxContentRating) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.dailyTimeLimitMinutes, dailyTimeLimitMinutes) ||
                other.dailyTimeLimitMinutes == dailyTimeLimitMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      avatarUrl,
      avatarColor,
      isKids,
      maxContentRating,
      languageCode,
      isDefault,
      dailyTimeLimitMinutes);

  @override
  String toString() {
    return 'UserProfile(id: $id, displayName: $displayName, avatarUrl: $avatarUrl, avatarColor: $avatarColor, isKids: $isKids, maxContentRating: $maxContentRating, languageCode: $languageCode, isDefault: $isDefault, dailyTimeLimitMinutes: $dailyTimeLimitMinutes)';
  }
}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(
          _UserProfile value, $Res Function(_UserProfile) _then) =
      __$UserProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String displayName,
      String? avatarUrl,
      String? avatarColor,
      bool? isKids,
      String? maxContentRating,
      String? languageCode,
      bool? isDefault,
      int? dailyTimeLimitMinutes});
}

/// @nodoc
class __$UserProfileCopyWithImpl<$Res> implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? avatarColor = freezed,
    Object? isKids = freezed,
    Object? maxContentRating = freezed,
    Object? languageCode = freezed,
    Object? isDefault = freezed,
    Object? dailyTimeLimitMinutes = freezed,
  }) {
    return _then(_UserProfile(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarColor: freezed == avatarColor
          ? _self.avatarColor
          : avatarColor // ignore: cast_nullable_to_non_nullable
              as String?,
      isKids: freezed == isKids
          ? _self.isKids
          : isKids // ignore: cast_nullable_to_non_nullable
              as bool?,
      maxContentRating: freezed == maxContentRating
          ? _self.maxContentRating
          : maxContentRating // ignore: cast_nullable_to_non_nullable
              as String?,
      languageCode: freezed == languageCode
          ? _self.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: freezed == isDefault
          ? _self.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
      dailyTimeLimitMinutes: freezed == dailyTimeLimitMinutes
          ? _self.dailyTimeLimitMinutes
          : dailyTimeLimitMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$Banner {
  int get id;
  String? get title;
  String? get subtitle;
  String get imageUrl;
  String? get mobileImageUrl;
  String? get linkType;
  String? get linkValue;
  String? get buttonText;
  int? get sortOrder;

  /// Create a copy of Banner
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BannerCopyWith<Banner> get copyWith =>
      _$BannerCopyWithImpl<Banner>(this as Banner, _$identity);

  /// Serializes this Banner to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Banner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.mobileImageUrl, mobileImageUrl) ||
                other.mobileImageUrl == mobileImageUrl) &&
            (identical(other.linkType, linkType) ||
                other.linkType == linkType) &&
            (identical(other.linkValue, linkValue) ||
                other.linkValue == linkValue) &&
            (identical(other.buttonText, buttonText) ||
                other.buttonText == buttonText) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, subtitle, imageUrl,
      mobileImageUrl, linkType, linkValue, buttonText, sortOrder);

  @override
  String toString() {
    return 'Banner(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, mobileImageUrl: $mobileImageUrl, linkType: $linkType, linkValue: $linkValue, buttonText: $buttonText, sortOrder: $sortOrder)';
  }
}

/// @nodoc
abstract mixin class $BannerCopyWith<$Res> {
  factory $BannerCopyWith(Banner value, $Res Function(Banner) _then) =
      _$BannerCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String? title,
      String? subtitle,
      String imageUrl,
      String? mobileImageUrl,
      String? linkType,
      String? linkValue,
      String? buttonText,
      int? sortOrder});
}

/// @nodoc
class _$BannerCopyWithImpl<$Res> implements $BannerCopyWith<$Res> {
  _$BannerCopyWithImpl(this._self, this._then);

  final Banner _self;
  final $Res Function(Banner) _then;

  /// Create a copy of Banner
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? imageUrl = null,
    Object? mobileImageUrl = freezed,
    Object? linkType = freezed,
    Object? linkValue = freezed,
    Object? buttonText = freezed,
    Object? sortOrder = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: freezed == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mobileImageUrl: freezed == mobileImageUrl
          ? _self.mobileImageUrl
          : mobileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkType: freezed == linkType
          ? _self.linkType
          : linkType // ignore: cast_nullable_to_non_nullable
              as String?,
      linkValue: freezed == linkValue
          ? _self.linkValue
          : linkValue // ignore: cast_nullable_to_non_nullable
              as String?,
      buttonText: freezed == buttonText
          ? _self.buttonText
          : buttonText // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Banner].
extension BannerPatterns on Banner {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Banner value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Banner() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Banner value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Banner():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Banner value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Banner() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String? title,
            String? subtitle,
            String imageUrl,
            String? mobileImageUrl,
            String? linkType,
            String? linkValue,
            String? buttonText,
            int? sortOrder)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Banner() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.subtitle,
            _that.imageUrl,
            _that.mobileImageUrl,
            _that.linkType,
            _that.linkValue,
            _that.buttonText,
            _that.sortOrder);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String? title,
            String? subtitle,
            String imageUrl,
            String? mobileImageUrl,
            String? linkType,
            String? linkValue,
            String? buttonText,
            int? sortOrder)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Banner():
        return $default(
            _that.id,
            _that.title,
            _that.subtitle,
            _that.imageUrl,
            _that.mobileImageUrl,
            _that.linkType,
            _that.linkValue,
            _that.buttonText,
            _that.sortOrder);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String? title,
            String? subtitle,
            String imageUrl,
            String? mobileImageUrl,
            String? linkType,
            String? linkValue,
            String? buttonText,
            int? sortOrder)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Banner() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.subtitle,
            _that.imageUrl,
            _that.mobileImageUrl,
            _that.linkType,
            _that.linkValue,
            _that.buttonText,
            _that.sortOrder);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Banner implements Banner {
  const _Banner(
      {required this.id,
      this.title,
      this.subtitle,
      required this.imageUrl,
      this.mobileImageUrl,
      this.linkType,
      this.linkValue,
      this.buttonText,
      this.sortOrder});
  factory _Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String imageUrl;
  @override
  final String? mobileImageUrl;
  @override
  final String? linkType;
  @override
  final String? linkValue;
  @override
  final String? buttonText;
  @override
  final int? sortOrder;

  /// Create a copy of Banner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BannerCopyWith<_Banner> get copyWith =>
      __$BannerCopyWithImpl<_Banner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BannerToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Banner &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.mobileImageUrl, mobileImageUrl) ||
                other.mobileImageUrl == mobileImageUrl) &&
            (identical(other.linkType, linkType) ||
                other.linkType == linkType) &&
            (identical(other.linkValue, linkValue) ||
                other.linkValue == linkValue) &&
            (identical(other.buttonText, buttonText) ||
                other.buttonText == buttonText) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, subtitle, imageUrl,
      mobileImageUrl, linkType, linkValue, buttonText, sortOrder);

  @override
  String toString() {
    return 'Banner(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, mobileImageUrl: $mobileImageUrl, linkType: $linkType, linkValue: $linkValue, buttonText: $buttonText, sortOrder: $sortOrder)';
  }
}

/// @nodoc
abstract mixin class _$BannerCopyWith<$Res> implements $BannerCopyWith<$Res> {
  factory _$BannerCopyWith(_Banner value, $Res Function(_Banner) _then) =
      __$BannerCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String? title,
      String? subtitle,
      String imageUrl,
      String? mobileImageUrl,
      String? linkType,
      String? linkValue,
      String? buttonText,
      int? sortOrder});
}

/// @nodoc
class __$BannerCopyWithImpl<$Res> implements _$BannerCopyWith<$Res> {
  __$BannerCopyWithImpl(this._self, this._then);

  final _Banner _self;
  final $Res Function(_Banner) _then;

  /// Create a copy of Banner
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? imageUrl = null,
    Object? mobileImageUrl = freezed,
    Object? linkType = freezed,
    Object? linkValue = freezed,
    Object? buttonText = freezed,
    Object? sortOrder = freezed,
  }) {
    return _then(_Banner(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: freezed == subtitle
          ? _self.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      mobileImageUrl: freezed == mobileImageUrl
          ? _self.mobileImageUrl
          : mobileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      linkType: freezed == linkType
          ? _self.linkType
          : linkType // ignore: cast_nullable_to_non_nullable
              as String?,
      linkValue: freezed == linkValue
          ? _self.linkValue
          : linkValue // ignore: cast_nullable_to_non_nullable
              as String?,
      buttonText: freezed == buttonText
          ? _self.buttonText
          : buttonText // ignore: cast_nullable_to_non_nullable
              as String?,
      sortOrder: freezed == sortOrder
          ? _self.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$ContentRow {
  int get id;
  String get title;
  String get rowType;
  List<Content> get items;
  int? get maxItems;

  /// Create a copy of ContentRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentRowCopyWith<ContentRow> get copyWith =>
      _$ContentRowCopyWithImpl<ContentRow>(this as ContentRow, _$identity);

  /// Serializes this ContentRow to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentRow &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.rowType, rowType) || other.rowType == rowType) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.maxItems, maxItems) ||
                other.maxItems == maxItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, rowType,
      const DeepCollectionEquality().hash(items), maxItems);

  @override
  String toString() {
    return 'ContentRow(id: $id, title: $title, rowType: $rowType, items: $items, maxItems: $maxItems)';
  }
}

/// @nodoc
abstract mixin class $ContentRowCopyWith<$Res> {
  factory $ContentRowCopyWith(
          ContentRow value, $Res Function(ContentRow) _then) =
      _$ContentRowCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String rowType,
      List<Content> items,
      int? maxItems});
}

/// @nodoc
class _$ContentRowCopyWithImpl<$Res> implements $ContentRowCopyWith<$Res> {
  _$ContentRowCopyWithImpl(this._self, this._then);

  final ContentRow _self;
  final $Res Function(ContentRow) _then;

  /// Create a copy of ContentRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? rowType = null,
    Object? items = null,
    Object? maxItems = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      rowType: null == rowType
          ? _self.rowType
          : rowType // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Content>,
      maxItems: freezed == maxItems
          ? _self.maxItems
          : maxItems // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentRow].
extension ContentRowPatterns on ContentRow {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ContentRow value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentRow() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ContentRow value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRow():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ContentRow value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRow() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int id, String title, String rowType, List<Content> items,
            int? maxItems)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentRow() when $default != null:
        return $default(
            _that.id, _that.title, _that.rowType, _that.items, _that.maxItems);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int id, String title, String rowType, List<Content> items,
            int? maxItems)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRow():
        return $default(
            _that.id, _that.title, _that.rowType, _that.items, _that.maxItems);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int id, String title, String rowType, List<Content> items,
            int? maxItems)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentRow() when $default != null:
        return $default(
            _that.id, _that.title, _that.rowType, _that.items, _that.maxItems);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentRow implements ContentRow {
  const _ContentRow(
      {required this.id,
      required this.title,
      required this.rowType,
      required final List<Content> items,
      this.maxItems})
      : _items = items;
  factory _ContentRow.fromJson(Map<String, dynamic> json) =>
      _$ContentRowFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String rowType;
  final List<Content> _items;
  @override
  List<Content> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int? maxItems;

  /// Create a copy of ContentRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentRowCopyWith<_ContentRow> get copyWith =>
      __$ContentRowCopyWithImpl<_ContentRow>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentRowToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentRow &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.rowType, rowType) || other.rowType == rowType) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.maxItems, maxItems) ||
                other.maxItems == maxItems));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, rowType,
      const DeepCollectionEquality().hash(_items), maxItems);

  @override
  String toString() {
    return 'ContentRow(id: $id, title: $title, rowType: $rowType, items: $items, maxItems: $maxItems)';
  }
}

/// @nodoc
abstract mixin class _$ContentRowCopyWith<$Res>
    implements $ContentRowCopyWith<$Res> {
  factory _$ContentRowCopyWith(
          _ContentRow value, $Res Function(_ContentRow) _then) =
      __$ContentRowCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String rowType,
      List<Content> items,
      int? maxItems});
}

/// @nodoc
class __$ContentRowCopyWithImpl<$Res> implements _$ContentRowCopyWith<$Res> {
  __$ContentRowCopyWithImpl(this._self, this._then);

  final _ContentRow _self;
  final $Res Function(_ContentRow) _then;

  /// Create a copy of ContentRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? rowType = null,
    Object? items = null,
    Object? maxItems = freezed,
  }) {
    return _then(_ContentRow(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      rowType: null == rowType
          ? _self.rowType
          : rowType // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Content>,
      maxItems: freezed == maxItems
          ? _self.maxItems
          : maxItems // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
mixin _$AppNotification {
  int get id;
  String get title;
  String get body;
  String get type;
  String? get deepLink;
  String? get imageUrl;
  bool? get isRead;
  DateTime? get createdAt;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      _$AppNotificationCopyWithImpl<AppNotification>(
          this as AppNotification, _$identity);

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.deepLink, deepLink) ||
                other.deepLink == deepLink) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, type, deepLink,
      imageUrl, isRead, createdAt);

  @override
  String toString() {
    return 'AppNotification(id: $id, title: $title, body: $body, type: $type, deepLink: $deepLink, imageUrl: $imageUrl, isRead: $isRead, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
          AppNotification value, $Res Function(AppNotification) _then) =
      _$AppNotificationCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      String type,
      String? deepLink,
      String? imageUrl,
      bool? isRead,
      DateTime? createdAt});
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._self, this._then);

  final AppNotification _self;
  final $Res Function(AppNotification) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? deepLink = freezed,
    Object? imageUrl = freezed,
    Object? isRead = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      deepLink: freezed == deepLink
          ? _self.deepLink
          : deepLink // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AppNotification].
extension AppNotificationPatterns on AppNotification {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppNotification value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppNotification() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppNotification value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppNotification():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppNotification value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppNotification() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int id,
            String title,
            String body,
            String type,
            String? deepLink,
            String? imageUrl,
            bool? isRead,
            DateTime? createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AppNotification() when $default != null:
        return $default(_that.id, _that.title, _that.body, _that.type,
            _that.deepLink, _that.imageUrl, _that.isRead, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int id,
            String title,
            String body,
            String type,
            String? deepLink,
            String? imageUrl,
            bool? isRead,
            DateTime? createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppNotification():
        return $default(_that.id, _that.title, _that.body, _that.type,
            _that.deepLink, _that.imageUrl, _that.isRead, _that.createdAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int id,
            String title,
            String body,
            String type,
            String? deepLink,
            String? imageUrl,
            bool? isRead,
            DateTime? createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AppNotification() when $default != null:
        return $default(_that.id, _that.title, _that.body, _that.type,
            _that.deepLink, _that.imageUrl, _that.isRead, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AppNotification implements AppNotification {
  const _AppNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.type,
      this.deepLink,
      this.imageUrl,
      this.isRead,
      this.createdAt});
  factory _AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String body;
  @override
  final String type;
  @override
  final String? deepLink;
  @override
  final String? imageUrl;
  @override
  final bool? isRead;
  @override
  final DateTime? createdAt;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppNotificationCopyWith<_AppNotification> get copyWith =>
      __$AppNotificationCopyWithImpl<_AppNotification>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AppNotificationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppNotification &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.deepLink, deepLink) ||
                other.deepLink == deepLink) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, type, deepLink,
      imageUrl, isRead, createdAt);

  @override
  String toString() {
    return 'AppNotification(id: $id, title: $title, body: $body, type: $type, deepLink: $deepLink, imageUrl: $imageUrl, isRead: $isRead, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$AppNotificationCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$AppNotificationCopyWith(
          _AppNotification value, $Res Function(_AppNotification) _then) =
      __$AppNotificationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String body,
      String type,
      String? deepLink,
      String? imageUrl,
      bool? isRead,
      DateTime? createdAt});
}

/// @nodoc
class __$AppNotificationCopyWithImpl<$Res>
    implements _$AppNotificationCopyWith<$Res> {
  __$AppNotificationCopyWithImpl(this._self, this._then);

  final _AppNotification _self;
  final $Res Function(_AppNotification) _then;

  /// Create a copy of AppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? deepLink = freezed,
    Object? imageUrl = freezed,
    Object? isRead = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_AppNotification(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _self.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      deepLink: freezed == deepLink
          ? _self.deepLink
          : deepLink // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: freezed == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$WatchParty {
  String get code;
  int get contentId;
  String get status;
  bool get isPlaying;
  int get currentPosition;
  int get memberCount;
  bool get isHost;
  List<WatchPartyMember>? get members;

  /// Create a copy of WatchParty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WatchPartyCopyWith<WatchParty> get copyWith =>
      _$WatchPartyCopyWithImpl<WatchParty>(this as WatchParty, _$identity);

  /// Serializes this WatchParty to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WatchParty &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.isHost, isHost) || other.isHost == isHost) &&
            const DeepCollectionEquality().equals(other.members, members));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      contentId,
      status,
      isPlaying,
      currentPosition,
      memberCount,
      isHost,
      const DeepCollectionEquality().hash(members));

  @override
  String toString() {
    return 'WatchParty(code: $code, contentId: $contentId, status: $status, isPlaying: $isPlaying, currentPosition: $currentPosition, memberCount: $memberCount, isHost: $isHost, members: $members)';
  }
}

/// @nodoc
abstract mixin class $WatchPartyCopyWith<$Res> {
  factory $WatchPartyCopyWith(
          WatchParty value, $Res Function(WatchParty) _then) =
      _$WatchPartyCopyWithImpl;
  @useResult
  $Res call(
      {String code,
      int contentId,
      String status,
      bool isPlaying,
      int currentPosition,
      int memberCount,
      bool isHost,
      List<WatchPartyMember>? members});
}

/// @nodoc
class _$WatchPartyCopyWithImpl<$Res> implements $WatchPartyCopyWith<$Res> {
  _$WatchPartyCopyWithImpl(this._self, this._then);

  final WatchParty _self;
  final $Res Function(WatchParty) _then;

  /// Create a copy of WatchParty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? contentId = null,
    Object? status = null,
    Object? isPlaying = null,
    Object? currentPosition = null,
    Object? memberCount = null,
    Object? isHost = null,
    Object? members = freezed,
  }) {
    return _then(_self.copyWith(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isPlaying: null == isPlaying
          ? _self.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPosition: null == currentPosition
          ? _self.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as int,
      memberCount: null == memberCount
          ? _self.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      isHost: null == isHost
          ? _self.isHost
          : isHost // ignore: cast_nullable_to_non_nullable
              as bool,
      members: freezed == members
          ? _self.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<WatchPartyMember>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WatchParty].
extension WatchPartyPatterns on WatchParty {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WatchParty value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchParty() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WatchParty value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchParty():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_WatchParty value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchParty() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String code,
            int contentId,
            String status,
            bool isPlaying,
            int currentPosition,
            int memberCount,
            bool isHost,
            List<WatchPartyMember>? members)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchParty() when $default != null:
        return $default(
            _that.code,
            _that.contentId,
            _that.status,
            _that.isPlaying,
            _that.currentPosition,
            _that.memberCount,
            _that.isHost,
            _that.members);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String code,
            int contentId,
            String status,
            bool isPlaying,
            int currentPosition,
            int memberCount,
            bool isHost,
            List<WatchPartyMember>? members)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchParty():
        return $default(
            _that.code,
            _that.contentId,
            _that.status,
            _that.isPlaying,
            _that.currentPosition,
            _that.memberCount,
            _that.isHost,
            _that.members);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String code,
            int contentId,
            String status,
            bool isPlaying,
            int currentPosition,
            int memberCount,
            bool isHost,
            List<WatchPartyMember>? members)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchParty() when $default != null:
        return $default(
            _that.code,
            _that.contentId,
            _that.status,
            _that.isPlaying,
            _that.currentPosition,
            _that.memberCount,
            _that.isHost,
            _that.members);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WatchParty implements WatchParty {
  const _WatchParty(
      {required this.code,
      required this.contentId,
      required this.status,
      required this.isPlaying,
      required this.currentPosition,
      required this.memberCount,
      required this.isHost,
      final List<WatchPartyMember>? members})
      : _members = members;
  factory _WatchParty.fromJson(Map<String, dynamic> json) =>
      _$WatchPartyFromJson(json);

  @override
  final String code;
  @override
  final int contentId;
  @override
  final String status;
  @override
  final bool isPlaying;
  @override
  final int currentPosition;
  @override
  final int memberCount;
  @override
  final bool isHost;
  final List<WatchPartyMember>? _members;
  @override
  List<WatchPartyMember>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of WatchParty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WatchPartyCopyWith<_WatchParty> get copyWith =>
      __$WatchPartyCopyWithImpl<_WatchParty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WatchPartyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WatchParty &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.currentPosition, currentPosition) ||
                other.currentPosition == currentPosition) &&
            (identical(other.memberCount, memberCount) ||
                other.memberCount == memberCount) &&
            (identical(other.isHost, isHost) || other.isHost == isHost) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      code,
      contentId,
      status,
      isPlaying,
      currentPosition,
      memberCount,
      isHost,
      const DeepCollectionEquality().hash(_members));

  @override
  String toString() {
    return 'WatchParty(code: $code, contentId: $contentId, status: $status, isPlaying: $isPlaying, currentPosition: $currentPosition, memberCount: $memberCount, isHost: $isHost, members: $members)';
  }
}

/// @nodoc
abstract mixin class _$WatchPartyCopyWith<$Res>
    implements $WatchPartyCopyWith<$Res> {
  factory _$WatchPartyCopyWith(
          _WatchParty value, $Res Function(_WatchParty) _then) =
      __$WatchPartyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String code,
      int contentId,
      String status,
      bool isPlaying,
      int currentPosition,
      int memberCount,
      bool isHost,
      List<WatchPartyMember>? members});
}

/// @nodoc
class __$WatchPartyCopyWithImpl<$Res> implements _$WatchPartyCopyWith<$Res> {
  __$WatchPartyCopyWithImpl(this._self, this._then);

  final _WatchParty _self;
  final $Res Function(_WatchParty) _then;

  /// Create a copy of WatchParty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
    Object? contentId = null,
    Object? status = null,
    Object? isPlaying = null,
    Object? currentPosition = null,
    Object? memberCount = null,
    Object? isHost = null,
    Object? members = freezed,
  }) {
    return _then(_WatchParty(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      contentId: null == contentId
          ? _self.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isPlaying: null == isPlaying
          ? _self.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPosition: null == currentPosition
          ? _self.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as int,
      memberCount: null == memberCount
          ? _self.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int,
      isHost: null == isHost
          ? _self.isHost
          : isHost // ignore: cast_nullable_to_non_nullable
              as bool,
      members: freezed == members
          ? _self._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<WatchPartyMember>?,
    ));
  }
}

/// @nodoc
mixin _$WatchPartyMember {
  int get userId;
  String get displayName;
  String? get avatarUrl;
  bool get isHost;

  /// Create a copy of WatchPartyMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WatchPartyMemberCopyWith<WatchPartyMember> get copyWith =>
      _$WatchPartyMemberCopyWithImpl<WatchPartyMember>(
          this as WatchPartyMember, _$identity);

  /// Serializes this WatchPartyMember to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WatchPartyMember &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isHost, isHost) || other.isHost == isHost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, avatarUrl, isHost);

  @override
  String toString() {
    return 'WatchPartyMember(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, isHost: $isHost)';
  }
}

/// @nodoc
abstract mixin class $WatchPartyMemberCopyWith<$Res> {
  factory $WatchPartyMemberCopyWith(
          WatchPartyMember value, $Res Function(WatchPartyMember) _then) =
      _$WatchPartyMemberCopyWithImpl;
  @useResult
  $Res call({int userId, String displayName, String? avatarUrl, bool isHost});
}

/// @nodoc
class _$WatchPartyMemberCopyWithImpl<$Res>
    implements $WatchPartyMemberCopyWith<$Res> {
  _$WatchPartyMemberCopyWithImpl(this._self, this._then);

  final WatchPartyMember _self;
  final $Res Function(WatchPartyMember) _then;

  /// Create a copy of WatchPartyMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? isHost = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isHost: null == isHost
          ? _self.isHost
          : isHost // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [WatchPartyMember].
extension WatchPartyMemberPatterns on WatchPartyMember {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WatchPartyMember value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchPartyMember() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WatchPartyMember value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchPartyMember():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_WatchPartyMember value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchPartyMember() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            int userId, String displayName, String? avatarUrl, bool isHost)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatchPartyMember() when $default != null:
        return $default(
            _that.userId, _that.displayName, _that.avatarUrl, _that.isHost);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            int userId, String displayName, String? avatarUrl, bool isHost)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchPartyMember():
        return $default(
            _that.userId, _that.displayName, _that.avatarUrl, _that.isHost);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            int userId, String displayName, String? avatarUrl, bool isHost)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatchPartyMember() when $default != null:
        return $default(
            _that.userId, _that.displayName, _that.avatarUrl, _that.isHost);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WatchPartyMember implements WatchPartyMember {
  const _WatchPartyMember(
      {required this.userId,
      required this.displayName,
      this.avatarUrl,
      required this.isHost});
  factory _WatchPartyMember.fromJson(Map<String, dynamic> json) =>
      _$WatchPartyMemberFromJson(json);

  @override
  final int userId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final bool isHost;

  /// Create a copy of WatchPartyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WatchPartyMemberCopyWith<_WatchPartyMember> get copyWith =>
      __$WatchPartyMemberCopyWithImpl<_WatchPartyMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WatchPartyMemberToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WatchPartyMember &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isHost, isHost) || other.isHost == isHost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, displayName, avatarUrl, isHost);

  @override
  String toString() {
    return 'WatchPartyMember(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, isHost: $isHost)';
  }
}

/// @nodoc
abstract mixin class _$WatchPartyMemberCopyWith<$Res>
    implements $WatchPartyMemberCopyWith<$Res> {
  factory _$WatchPartyMemberCopyWith(
          _WatchPartyMember value, $Res Function(_WatchPartyMember) _then) =
      __$WatchPartyMemberCopyWithImpl;
  @override
  @useResult
  $Res call({int userId, String displayName, String? avatarUrl, bool isHost});
}

/// @nodoc
class __$WatchPartyMemberCopyWithImpl<$Res>
    implements _$WatchPartyMemberCopyWith<$Res> {
  __$WatchPartyMemberCopyWithImpl(this._self, this._then);

  final _WatchPartyMember _self;
  final $Res Function(_WatchPartyMember) _then;

  /// Create a copy of WatchPartyMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? isHost = null,
  }) {
    return _then(_WatchPartyMember(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      displayName: null == displayName
          ? _self.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isHost: null == isHost
          ? _self.isHost
          : isHost // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$PagedResult<T> {
  List<T> get items;
  int get totalCount;
  int get page;
  int get pageSize;
  bool get hasMore;

  /// Create a copy of PagedResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PagedResultCopyWith<T, PagedResult<T>> get copyWith =>
      _$PagedResultCopyWithImpl<T, PagedResult<T>>(
          this as PagedResult<T>, _$identity);

  /// Serializes this PagedResult to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PagedResult<T> &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(items),
      totalCount,
      page,
      pageSize,
      hasMore);

  @override
  String toString() {
    return 'PagedResult<$T>(items: $items, totalCount: $totalCount, page: $page, pageSize: $pageSize, hasMore: $hasMore)';
  }
}

/// @nodoc
abstract mixin class $PagedResultCopyWith<T, $Res> {
  factory $PagedResultCopyWith(
          PagedResult<T> value, $Res Function(PagedResult<T>) _then) =
      _$PagedResultCopyWithImpl;
  @useResult
  $Res call(
      {List<T> items, int totalCount, int page, int pageSize, bool hasMore});
}

/// @nodoc
class _$PagedResultCopyWithImpl<T, $Res>
    implements $PagedResultCopyWith<T, $Res> {
  _$PagedResultCopyWithImpl(this._self, this._then);

  final PagedResult<T> _self;
  final $Res Function(PagedResult<T>) _then;

  /// Create a copy of PagedResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = null,
    Object? page = null,
    Object? pageSize = null,
    Object? hasMore = null,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _self.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _self.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [PagedResult].
extension PagedResultPatterns<T> on PagedResult<T> {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PagedResult<T> value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PagedResult() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PagedResult<T> value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PagedResult():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PagedResult<T> value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PagedResult() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<T> items, int totalCount, int page, int pageSize,
            bool hasMore)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PagedResult() when $default != null:
        return $default(_that.items, _that.totalCount, _that.page,
            _that.pageSize, _that.hasMore);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<T> items, int totalCount, int page, int pageSize, bool hasMore)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PagedResult():
        return $default(_that.items, _that.totalCount, _that.page,
            _that.pageSize, _that.hasMore);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<T> items, int totalCount, int page, int pageSize,
            bool hasMore)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PagedResult() when $default != null:
        return $default(_that.items, _that.totalCount, _that.page,
            _that.pageSize, _that.hasMore);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _PagedResult<T> implements PagedResult<T> {
  const _PagedResult(
      {required final List<T> items,
      required this.totalCount,
      required this.page,
      required this.pageSize,
      required this.hasMore})
      : _items = items;
  factory _PagedResult.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PagedResultFromJson(json, fromJsonT);

  final List<T> _items;
  @override
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final bool hasMore;

  /// Create a copy of PagedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PagedResultCopyWith<T, _PagedResult<T>> get copyWith =>
      __$PagedResultCopyWithImpl<T, _PagedResult<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$PagedResultToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PagedResult<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      totalCount,
      page,
      pageSize,
      hasMore);

  @override
  String toString() {
    return 'PagedResult<$T>(items: $items, totalCount: $totalCount, page: $page, pageSize: $pageSize, hasMore: $hasMore)';
  }
}

/// @nodoc
abstract mixin class _$PagedResultCopyWith<T, $Res>
    implements $PagedResultCopyWith<T, $Res> {
  factory _$PagedResultCopyWith(
          _PagedResult<T> value, $Res Function(_PagedResult<T>) _then) =
      __$PagedResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<T> items, int totalCount, int page, int pageSize, bool hasMore});
}

/// @nodoc
class __$PagedResultCopyWithImpl<T, $Res>
    implements _$PagedResultCopyWith<T, $Res> {
  __$PagedResultCopyWithImpl(this._self, this._then);

  final _PagedResult<T> _self;
  final $Res Function(_PagedResult<T>) _then;

  /// Create a copy of PagedResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? totalCount = null,
    Object? page = null,
    Object? pageSize = null,
    Object? hasMore = null,
  }) {
    return _then(_PagedResult<T>(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<T>,
      totalCount: null == totalCount
          ? _self.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _self.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _self.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
