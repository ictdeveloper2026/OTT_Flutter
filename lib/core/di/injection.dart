import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/network/api_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/content_repository.dart';
import '../../data/repositories/subscription_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/live_repository.dart';
import '../../data/repositories/admin_repository.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/theme/theme_bloc.dart';
import '../../presentation/blocs/content/content_bloc.dart';
import '../../presentation/blocs/player/player_bloc.dart';
import '../../presentation/blocs/profile/profile_bloc.dart';
import '../../presentation/blocs/subscription/subscription_bloc.dart';
import '../../presentation/blocs/search/search_bloc.dart';
import '../../presentation/blocs/live/live_bloc.dart';
import '../../presentation/blocs/admin/admin_bloc.dart';
import '../constants/app_constants.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  sl.registerLazySingleton(() => Connectivity());

  // Hive boxes
  final settingsBox = await Hive.openBox(AppConstants.settingsBox);
  final cacheBox = await Hive.openBox(AppConstants.cacheBox);
  final downloadsBox = await Hive.openBox(AppConstants.downloadsBox);
  sl.registerSingleton<Box>(settingsBox, instanceName: 'settings');
  sl.registerSingleton<Box>(cacheBox, instanceName: 'cache');
  sl.registerSingleton<Box>(downloadsBox, instanceName: 'downloads');

  // Core
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => Logger());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<FlutterSecureStorage>(), sl<Logger>()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl<ApiService>()));
  sl.registerLazySingleton<ContentRepository>(() => ContentRepository(sl<ApiService>()));
  sl.registerLazySingleton<SubscriptionRepository>(() => SubscriptionRepository(sl<ApiService>()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository(sl<ApiService>()));
  sl.registerLazySingleton<LiveRepository>(() => LiveRepository(sl<ApiService>()));
  sl.registerLazySingleton<AdminRepository>(() => AdminRepository(sl<ApiService>()));

  // BLoCs (factory - new instance per use)
  sl.registerFactory(() => AuthBloc(sl<AuthRepository>()));
  sl.registerFactory(() => ThemeBloc(sl<ApiService>(), sl<Box>(instanceName: 'settings')));
  sl.registerFactory(() => ContentBloc(sl<ContentRepository>()));
  sl.registerFactory(() => PlayerBloc(sl<ContentRepository>()));
  sl.registerFactory(() => ProfileBloc(sl<ProfileRepository>()));
  sl.registerFactory(() => SubscriptionBloc(sl<SubscriptionRepository>()));
  sl.registerFactory(() => SearchBloc(sl<ContentRepository>()));
  sl.registerFactory(() => LiveBloc(sl<LiveRepository>()));
  sl.registerFactory(() => AdminBloc(sl<AdminRepository>()));
}
