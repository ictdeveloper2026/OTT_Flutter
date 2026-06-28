// Plain (non-freezed) models for the IPTV "Live TV" feature. Kept codegen-free so the
// feature is self-contained — the backend (LiveTvController) returns simple flat maps.

class IptvChannel {
  final String id;
  final String name;
  final String? country;
  final String? countryName;
  final String? languages; // comma-separated
  final String? categories; // comma-separated
  final String? logoUrl;
  final String? streamUrl;
  final String? quality;

  const IptvChannel({
    required this.id,
    required this.name,
    this.country,
    this.countryName,
    this.languages,
    this.categories,
    this.logoUrl,
    this.streamUrl,
    this.quality,
  });

  factory IptvChannel.fromJson(Map<String, dynamic> j) => IptvChannel(
        id: (j['id'] ?? '').toString(),
        name: (j['name'] ?? '').toString(),
        country: j['country'] as String?,
        countryName: j['countryName'] as String?,
        languages: j['languages'] as String?,
        categories: j['categories'] as String?,
        logoUrl: j['logoUrl'] as String?,
        streamUrl: j['streamUrl'] as String?,
        quality: j['quality'] as String?,
      );

  String get subtitle => countryName ?? country ?? '';
}

/// One page of channel results (mirrors the backend's {items,totalCount,page,pageSize}).
class ChannelPage {
  final List<IptvChannel> items;
  final int total;
  final int page;
  const ChannelPage({required this.items, required this.total, required this.page});
}

/// A country/language facet with a channel count, used to build the filter dropdowns.
class ChannelFacet {
  final String code;
  final String? name;
  final int count;
  const ChannelFacet({required this.code, this.name, required this.count});

  factory ChannelFacet.fromJson(Map<String, dynamic> j) => ChannelFacet(
        code: (j['code'] ?? '').toString(),
        name: j['name'] as String?,
        count: (j['count'] as num?)?.toInt() ?? 0,
      );

  String get label => '${(name ?? code).toString()} ($count)';
}

class ChannelFilters {
  final int total;
  final List<ChannelFacet> countries;
  final List<ChannelFacet> languages;
  const ChannelFilters({required this.total, required this.countries, required this.languages});

  static List<ChannelFacet> _facets(dynamic raw) =>
      ((raw as List?) ?? const []).map((e) => ChannelFacet.fromJson(Map<String, dynamic>.from(e as Map))).toList();

  factory ChannelFilters.fromJson(Map<String, dynamic> j) => ChannelFilters(
        total: (j['total'] as num?)?.toInt() ?? 0,
        countries: _facets(j['countries']),
        languages: _facets(j['languages']),
      );

  static const empty = ChannelFilters(total: 0, countries: [], languages: []);
}
