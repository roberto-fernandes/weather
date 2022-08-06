import 'package:go_router/go_router.dart';
import 'package:weather/routing/not_found_screen.dart';
import 'package:weather/view/home/home_screen.dart';
import 'package:weather/view/settings/settings_screen.dart';

enum AppRoute {
  home,
  settings
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'settings',
          name: AppRoute.settings.name,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
