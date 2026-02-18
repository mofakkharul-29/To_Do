import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/router/routing_listenable.dart';
import 'package:to_do/core/router/routing_path.dart';
import 'package:to_do/features/home/presentation/home_screen.dart';
import 'package:to_do/features/onboarding/presentation/onboarding_screen.dart';
import 'package:to_do/features/splash/presentation/splash_screen.dart';

class RouterConfiguration {
  static final _rootNavigationKey =
      GlobalKey<NavigatorState>();

  static final routerProvider = Provider<GoRouter>((ref) {
    final routerNotifier = ref.watch(
      routingListenableProvider,
    );

    return GoRouter(
      redirect: (context, state) {
        final String path = state.uri.path;

        final bool isSplashDone =
            routerNotifier.isSplashDone;
        final bool isFirstLaunch =
            routerNotifier.isFirstLaunch;
        final user = routerNotifier.currentUser;
        final bool isLoading = routerNotifier.isAppLoading;

        if (isLoading || !isSplashDone) {
          return path == '/splash' ? null : '/splash';
        }

        if (isFirstLaunch) {
          return path == '/onboarding'
              ? null
              : '/onboarding';
        }

        final authPaths = ['/login', '/register'];
        if (user == null) {
          return authPaths.contains(path) ? null : '/login';
        }
        if (authPaths.contains(path) ||
            path == '/onboarding' ||
            path == '/splash') {
          return '/home';
        }

        return null;
      },
      initialLocation: '/splash',
      refreshListenable: routerNotifier,
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigationKey,
      routes: [
        GoRoute(
          path: '/splash',
          name: splashRoute,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: onboardingRoute,
          builder: (context, state) =>
              const OnboardingScreen(),
        ),
        GoRoute(
          path: '/home',
          name: homeRoute,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  });
}
