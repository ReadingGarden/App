import 'package:book_flutter/onboarding/PwdFindPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../ErrorPage.dart';
import '../garden/GardenPage.dart';
import '../onboarding/LoginPage.dart';
import '../onboarding/SignupPage.dart';

final GoRouter router = GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => ErrorPage(),
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) => SplashPage(),
      ),
      GoRoute(
          path: '/garden',
          name: 'garden',
          builder: (context, state) => GardenPage()),
      GoRoute(
          path: '/login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) => LoginPage(),
          routes: [
            GoRoute(
                path: 'signup',
                name: 'signup',
                builder: (BuildContext context, GoRouterState state) =>
                    SignupPage(),
                routes: [
                  GoRoute(
                    path: 'signup-end',
                    name: 'signup-end',
                    builder: (context, state) => SignupEndPage(),
                  )
                ]),
            GoRoute(
                path: 'pwd-find',
                name: 'pwd-find',
                builder: (context, state) => PwdFindPage())
          ]),
    ]);
