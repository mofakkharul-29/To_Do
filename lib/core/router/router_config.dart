import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/core/router/routing_listenable.dart';
import 'package:to_do/core/router/routing_path.dart';
import 'package:to_do/features/auth/presentation/login_screen.dart';
import 'package:to_do/features/auth/presentation/register_screen.dart';
import 'package:to_do/features/home/presentation/home_screen.dart';
import 'package:to_do/features/onboarding/presentation/onboarding_screen.dart';
import 'package:to_do/features/profile/presentation/profile_screen.dart';
import 'package:to_do/features/splash/presentation/splash_screen.dart';
import 'package:to_do/features/tasks/presentation/add_task_page.dart';
import 'package:to_do/features/tasks/presentation/task_screen.dart';
import 'package:to_do/history/presentation/history_screen.dart';

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

        if (isLoading) {
          if (path != '/splash') return '/splash';
          return null;
        }

        if (!isSplashDone) {
          if (path != '/splash') return '/splash';
          return null;
        }

        if (isFirstLaunch) {
          if (path != '/onboarding') return '/onboarding';
          return null;
        }

        final authPaths = ['/login', '/register'];
        if (user == null) {
          if (!authPaths.contains(path)) return '/login';
          return null;
        }

        if (authPaths.contains(path) ||
            path == '/onboarding' ||
            path == '/splash') {
          // return '/home';
          return '/tasks';
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
          path: '/login',
          name: loginRoute,
          pageBuilder: (context, state) =>
              CustomTransitionPage(
                key: state.pageKey,
                child: const LoginScreen(),
                transitionsBuilder:
                    (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
              ),
        ),
        GoRoute(
          path: '/register',
          name: registerRoute,
          pageBuilder: (context, state) =>
              CustomTransitionPage(
                key: state.pageKey,
                child: const RegisterScreen(),
                transitionsBuilder:
                    (
                      context,
                      animation,
                      secondaryAnimation,
                      child,
                    ) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
              ),
        ),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: _rootNavigationKey,
          builder: (context, state, navigationShell) {
            final String path = state.uri.path;
            return HomeScreen(
              navigationShell: navigationShell,
              path: path,
            );
          },
          branches: [
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: '/tasks',
                  name: tasksRoute,
                  builder: (context, state) =>
                      const TaskScreen(),
                  routes: [
                    GoRoute(
                      path: 'add',
                      name: addTaskPageRoute,
                      // builder: (context, state) =>
                      //     const AddTaskPage(),
                      pageBuilder: (context, state) =>
                          CustomTransitionPage(
                            key: state.pageKey,
                            child: const AddTaskPage(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                          ),
                    ),
                  ],
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/history',
                  name: historyRoute,
                  builder: (context, state) =>
                      const HistoryScreen(),
                ),
              ],
            ),

            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  name: profileRoute,
                  builder: (context, state) =>
                      const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  });
}
