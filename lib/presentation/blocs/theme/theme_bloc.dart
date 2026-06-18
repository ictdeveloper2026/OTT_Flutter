import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../../core/network/api_service.dart';
import '../../../data/models/content.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ApiService _apiService;
  final Box _settingsBox;

  ThemeBloc(this._apiService, this._settingsBox) : super(ThemeInitial()) {
    on<ThemeLoadRequested>(_onLoad);
    on<ThemeUpdateRequested>(_onUpdate);
    on<ThemeModeToggled>(_onToggleMode);
  }

  Future<void> _onLoad(ThemeLoadRequested event, Emitter<ThemeState> emit) async {
    try {
      // Load cached branding first
      final cached = _settingsBox.get(AppConstants.brandingKey);
      if (cached != null) {
        final branding = BrandingConfig.fromJson(jsonDecode(cached));
        emit(ThemeLoaded(branding: branding, themeData: _buildTheme(branding)));
      }
      // Fetch fresh from API
      final branding = await _apiService.getBrandingConfig();
      await _settingsBox.put(AppConstants.brandingKey, jsonEncode(branding.toJson()));
      emit(ThemeLoaded(branding: branding, themeData: _buildTheme(branding)));
    } catch (e) {
      // Use default theme on error
      final defaultBranding = BrandingConfig.defaultConfig();
      emit(ThemeLoaded(branding: defaultBranding, themeData: _buildTheme(defaultBranding)));
    }
  }

  Future<void> _onUpdate(ThemeUpdateRequested event, Emitter<ThemeState> emit) async {
    try {
      await _apiService.updateBrandingConfig(event.branding);
      await _settingsBox.put(AppConstants.brandingKey, jsonEncode(event.branding.toJson()));
      emit(ThemeLoaded(branding: event.branding, themeData: _buildTheme(event.branding)));
    } catch (e) {
      emit(ThemeError(message: e.toString()));
    }
  }

  void _onToggleMode(ThemeModeToggled event, Emitter<ThemeState> emit) {
    if (state is ThemeLoaded) {
      final current = state as ThemeLoaded;
      emit(current.copyWith(isDark: event.isDark));
    }
  }

  ThemeData _buildTheme(BrandingConfig branding) {
    return AppTheme.buildDarkTheme(branding);
  }
}
