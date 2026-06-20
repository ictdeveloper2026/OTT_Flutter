import 'package:flutter/widgets.dart';

// Non-web platforms use the `video_player` package (native HLS), so this is never shown.
Widget buildHlsPlayer(String url) => const SizedBox.shrink();
