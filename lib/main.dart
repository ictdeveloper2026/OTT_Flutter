import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/theme/theme_bloc.dart';
import 'presentation/blocs/content/content_bloc.dart';
import 'presentation/blocs/profile/profile_bloc.dart';
import 'presentation/blocs/subscription/subscription_bloc.dart';
import 'presentation/blocs/search/search_bloc.dart';
import 'presentation/blocs/live/live_bloc.dart';
import 'presentation/blocs/admin/admin_bloc.dart';
import 'presentation/blocs/player/player_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized(); // video player backend
  await Hive.initFlutter();
  await configureDependencies(); // get_it: api client, repositories, blocs
  runApp(const StreamFlixApp());
}

class StreamFlixApp extends StatelessWidget {
  const StreamFlixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // App-wide blocs the router/shell depend on.
        BlocProvider(create: (_) => sl<AuthBloc>()..add(AuthCheckRequested())),
        BlocProvider(create: (_) => sl<ThemeBloc>()..add(ThemeLoadRequested())),
        // Feature blocs (one app-level instance each).
        BlocProvider(create: (_) => sl<ContentBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<SubscriptionBloc>()),
        BlocProvider(create: (_) => sl<SearchBloc>()),
        BlocProvider(create: (_) => sl<LiveBloc>()),
        BlocProvider(create: (_) => sl<AdminBloc>()),
        BlocProvider(create: (_) => sl<PlayerBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final theme = themeState is ThemeLoaded ? themeState.themeData : ThemeData.dark();
          return MaterialApp.router(
            title: 'StreamFlix',
            debugShowCheckedModeBanner: false,
            theme: theme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
