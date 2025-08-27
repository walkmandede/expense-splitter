import 'dart:async';

import 'package:expense_splitter/common/bloc/authentication/authentication_bloc.dart';
import 'package:expense_splitter/core/configs/router-configs/route_names.dart';
import 'package:expense_splitter/src/presentation/screens/auth/sign_in_page.dart';
import 'package:expense_splitter/src/presentation/screens/home/home_page.dart';
import 'package:expense_splitter/src/presentation/screens/profile/profile_page.dart';
import 'package:expense_splitter/src/presentation/screens/splash/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
part 'redirection.dart';

final router = GoRouter(
  initialLocation: "/splash-screen",
  errorBuilder: (context, state) {
    return const Scaffold(body: Center(child: Text("Page not found")));
  },
  redirect: (context, state) {
    final redirect = handleRedirect(context, state);
    return redirect;
  },
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: RouteNames.splash,
      path: RouteNames.splash,
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      name: RouteNames.signIn,
      path: RouteNames.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      name: RouteNames.home,
      path: RouteNames.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: RouteNames.profile,
      path: RouteNames.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    // StatefulShellRoute.indexedStack(
    //   builder: (context, state, navigationShell) {
    //     return MainScreen(navigationShell: navigationShell);
    //   },
    //   branches: [
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           name: RouteNames.workoutList,
    //           path: "/workout-list",
    //           builder: (context, state) => const WorkoutListScreen(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           name: RouteNames.profile,
    //           path: "/profile",
    //           builder: (context, state) => const ProfileScreen(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ],
);
