import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashboard/dashboard.dart';
import 'package:flutter_application_1/pages/intro_screen/onboarding_screen.dart';
import 'package:flutter_application_1/pages/leave/leave.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/profile/profile.dart';
import 'package:flutter_application_1/splash_screen.dart';
import 'package:flutter_application_1/starter_page.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initR = '/splash';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>();
  static final _rootNavigatorLeave = GlobalKey<NavigatorState>();
  static final _rootNavigatorProfile = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'Splash',
        builder: (context, state) {
          return SplashScreen(
            key: state.pageKey,
          );
        },
      ),

      // Onboarding page
      GoRoute(
        path: '/onboarding',
        name: 'Onboarding',
        builder: (context, state) {
          return OnboardingScreen(
            key: state.pageKey,
          );
        },
      ),

      // Login page
      GoRoute(
        path: '/login',
        name: 'Login',
        builder: (context, state) {
          return LoginPage(
            key: state.pageKey,
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return StarterPage(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          // Home / Dashboard
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: '/home',
                name: 'Home',
                builder: (context, state) {
                  return DashboardPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          // Leave
          StatefulShellBranch(
            navigatorKey: _rootNavigatorLeave,
            routes: [
              GoRoute(
                path: '/leave',
                name: 'Leave',
                builder: (context, state) {
                  return LeavePage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          // Profile
          StatefulShellBranch(
            navigatorKey: _rootNavigatorProfile,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'Profile',
                builder: (context, state) {
                  return ProfilePage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      if (state.uri.toString() == '/splash') {
        Future.delayed(const Duration(seconds: 3), () {
          GoRouter.of(context).go('/onboarding');
        });
        return null;
      }

      return null;
    },
  );
}
