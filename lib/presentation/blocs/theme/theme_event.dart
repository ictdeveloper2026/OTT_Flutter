part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  @override
  List<Object?> get props => [];
}

class ThemeLoadRequested extends ThemeEvent {}

class ThemeUpdateRequested extends ThemeEvent {
  final BrandingConfig branding;
  const ThemeUpdateRequested({required this.branding});
  @override
  List<Object?> get props => [branding];
}

class ThemeModeToggled extends ThemeEvent {
  final bool isDark;
  const ThemeModeToggled({required this.isDark});
  @override
  List<Object?> get props => [isDark];
}
