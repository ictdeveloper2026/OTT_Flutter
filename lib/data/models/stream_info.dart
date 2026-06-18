class StreamInfo {
  final String url;
  final String type; // hls, youtube, vimeo
  final String? youtubeVideoId;
  final String? vimeoVideoId;
  final bool isDrm;
  final String? drmLicenseUrl;
  final List<Map<String, dynamic>> qualities;
  final List<Map<String, dynamic>> subtitles;
  final List<Map<String, dynamic>> audioTracks;
  final int? watchedSeconds;

  const StreamInfo({
    required this.url,
    required this.type,
    this.youtubeVideoId,
    this.vimeoVideoId,
    this.isDrm = false,
    this.drmLicenseUrl,
    this.qualities = const [],
    this.subtitles = const [],
    this.audioTracks = const [],
    this.watchedSeconds,
  });

  factory StreamInfo.fromJson(Map<String, dynamic> json) {
    return StreamInfo(
      url: json['url'] ?? '',
      type: json['type'] ?? 'hls',
      youtubeVideoId: json['youtubeVideoId'],
      vimeoVideoId: json['vimeoVideoId'],
      isDrm: json['isDrm'] ?? false,
      drmLicenseUrl: json['drmLicenseUrl'],
      qualities: List<Map<String, dynamic>>.from(json['qualities'] ?? []),
      subtitles: List<Map<String, dynamic>>.from(json['subtitles'] ?? []),
      audioTracks: List<Map<String, dynamic>>.from(json['audioTracks'] ?? []),
      watchedSeconds: json['watchedSeconds'],
    );
  }

  bool get isYoutube => type == 'youtube' || youtubeVideoId != null;
  bool get isVimeo => type == 'vimeo' || vimeoVideoId != null;
  bool get isHls => type == 'hls';
}
