import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/branding_config.dart';

class AppTheme {
  AppTheme._();

  static ThemeData buildDarkTheme(BrandingConfig? branding) {
    final primary = _parseColor(branding?.primaryColor, const Color(0xFFE50914));
    final secondary = _parseColor(branding?.secondaryColor, const Color(0xFF141414));
    final accent = _parseColor(branding?.accentColor, const Color(0xFFF5C518));
    final bg = _parseColor(branding?.backgroundColor, const Color(0xFF000000));
    final surface = _parseColor(branding?.surfaceColor, const Color(0xFF1A1A1A));
    final textPrimary = _parseColor(branding?.textPrimaryColor, const Color(0xFFFFFFFF));
    final textSecondary = _parseColor(branding?.textSecondaryColor, const Color(0xFFB3B3B3));
    final fontFamily = branding?.fontFamily ?? 'Poppins';

    final colorScheme = ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: surface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      tertiary: secondary,
      error: const Color(0xFFCF6679),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: bg,
      textTheme: _buildTextTheme(fontFamily, textPrimary, textSecondary),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.getFont(
          fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF0D0D0D),
        selectedItemColor: primary,
        unselectedItemColor: textSecondary,
        selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primary),
        unselectedLabelStyle: TextStyle(fontSize: 11, color: textSecondary),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: const Color(0xFF0D0D0D),
        selectedIconTheme: IconThemeData(color: primary),
        unselectedIconTheme: IconThemeData(color: textSecondary),
        selectedLabelTextStyle: TextStyle(color: primary, fontWeight: FontWeight.w600),
        unselectedLabelTextStyle: TextStyle(color: textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.getFont(fontFamily, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: BorderSide(color: textSecondary.withOpacity(0.4)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.getFont(fontFamily, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: GoogleFonts.getFont(fontFamily, fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: textSecondary.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: textSecondary.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFCF6679)),
        ),
        labelStyle: TextStyle(color: textSecondary),
        hintStyle: TextStyle(color: textSecondary.withOpacity(0.6)),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: primary.withOpacity(0.2),
        labelStyle: TextStyle(color: textPrimary, fontSize: 12),
        side: BorderSide(color: textSecondary.withOpacity(0.2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: primary,
        unselectedLabelColor: textSecondary,
        indicatorColor: primary,
        labelStyle: GoogleFonts.getFont(fontFamily, fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle: GoogleFonts.getFont(fontFamily, fontWeight: FontWeight.w500, fontSize: 13),
      ),
      dividerTheme: DividerThemeData(color: textSecondary.withOpacity(0.1), thickness: 1),
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: textSecondary.withOpacity(0.3),
        thumbColor: primary,
        overlayColor: primary.withOpacity(0.2),
        trackHeight: 3,
      ),
      extensions: [
        OttColors(
          primary: primary,
          secondary: secondary,
          accent: accent,
          bg: bg,
          surface: surface,
          textPrimary: textPrimary,
          textSecondary: textSecondary,
          cardGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, bg.withOpacity(0.9), bg],
          ),
          heroGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, bg.withOpacity(0.5), bg],
          ),
          shimmerBase: surface,
          shimmerHighlight: surface.withOpacity(0.5),
        ),
      ],
    );
  }

  static ThemeData buildTheme(BrandingConfig? branding) => buildDarkTheme(branding);

  static TextTheme _buildTextTheme(String fontFamily, Color primary, Color secondary) {
    TextStyle base(double size, FontWeight weight, Color color) =>
        GoogleFonts.getFont(fontFamily, fontSize: size, fontWeight: weight, color: color, letterSpacing: 0.2);

    return TextTheme(
      displayLarge:  base(57, FontWeight.w800, primary),
      displayMedium: base(45, FontWeight.w700, primary),
      displaySmall:  base(36, FontWeight.w700, primary),
      headlineLarge: base(32, FontWeight.w700, primary),
      headlineMedium:base(28, FontWeight.w600, primary),
      headlineSmall: base(24, FontWeight.w600, primary),
      titleLarge:    base(22, FontWeight.w600, primary),
      titleMedium:   base(16, FontWeight.w500, primary),
      titleSmall:    base(14, FontWeight.w500, primary),
      bodyLarge:     base(16, FontWeight.w400, primary),
      bodyMedium:    base(14, FontWeight.w400, primary),
      bodySmall:     base(12, FontWeight.w400, secondary),
      labelLarge:    base(14, FontWeight.w600, primary),
      labelMedium:   base(12, FontWeight.w500, primary),
      labelSmall:    base(11, FontWeight.w500, secondary),
    );
  }

  static Color _parseColor(String? hex, Color fallback) {
    if (hex == null || hex.isEmpty) return fallback;
    try {
      final clean = hex.replaceAll('#', '');
      return Color(int.parse('FF$clean', radix: 16));
    } catch (_) {
      return fallback;
    }
  }
}

class OttColors extends ThemeExtension<OttColors> {
  final Color primary, secondary, accent, bg, surface, textPrimary, textSecondary, shimmerBase, shimmerHighlight;
  final LinearGradient cardGradient, heroGradient;

  const OttColors({
    required this.primary, required this.secondary, required this.accent,
    required this.bg, required this.surface, required this.textPrimary,
    required this.textSecondary, required this.cardGradient, required this.heroGradient,
    required this.shimmerBase, required this.shimmerHighlight,
  });

  // Convenience aliases used across screens/widgets.
  Color get background => bg;
  Color get divider => textSecondary.withOpacity(0.12);
  Color get card => surface;
  Color get textMuted => textSecondary;

  @override
  OttColors copyWith({Color? primary, Color? secondary, Color? accent, Color? bg,
    Color? surface, Color? textPrimary, Color? textSecondary, LinearGradient? cardGradient,
    LinearGradient? heroGradient, Color? shimmerBase, Color? shimmerHighlight}) {
    return OttColors(
      primary: primary ?? this.primary, secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent, bg: bg ?? this.bg, surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary, textSecondary: textSecondary ?? this.textSecondary,
      cardGradient: cardGradient ?? this.cardGradient, heroGradient: heroGradient ?? this.heroGradient,
      shimmerBase: shimmerBase ?? this.shimmerBase, shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  OttColors lerp(OttColors? other, double t) => this;
}
