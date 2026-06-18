part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {}
class ThemeError extends ThemeState {
  final String message;
  const ThemeError({required this.message});
  @override
  List<Object?> get props => [message];
}

class ThemeLoaded extends ThemeState {
  final BrandingConfig branding;
  final ThemeData themeData;
  final bool isDark;

  const ThemeLoaded({
    required this.branding,
    required this.themeData,
    this.isDark = true,
  });

  ThemeLoaded copyWith({BrandingConfig? branding, ThemeData? themeData, bool? isDark}) {
    return ThemeLoaded(
      branding: branding ?? this.branding,
      themeData: themeData ?? this.themeData,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  List<Object?> get props => [branding, isDark];
}
