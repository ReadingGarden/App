import 'package:book_flutter/mypage/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../ErrorPage.dart';
import '../garden/GardenPage.dart';
import '../mypage/MyPage.dart';
import '../onboarding/LoginPage.dart';
import '../onboarding/PwdFindPage.dart';
import '../onboarding/PwdSettingPage.dart';
import '../onboarding/SignupPage.dart';
import '../onboarding/StartPage.dart';

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
          path: '/start',
          name: 'start',
          builder: (context, state) => StartPage(),
          routes: [
            GoRoute(
                path: 'login',
                name: 'login',
                builder: (BuildContext context, GoRouterState state) =>
                    LoginPage(),
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
                      builder: (context, state) => PwdFindPage(),
                      routes: [
                        GoRoute(
                            path: 'pwd-setting',
                            name: 'pwd-setting',
                            builder: (context, state) {
                              final String user_email = state.extra as String;
                              return PwdSettingPage(
                                user_email: user_email,
                              );
                            })
                      ])
                ]),
          ]),
      GoRoute(
          path: '/garden',
          name: 'garden',
          builder: (context, state) => GardenPage()),
      GoRoute(
          path: '/mypage',
          name: 'mypage',
          builder: (context, state) => MyPage(),
          routes: [
            GoRoute(
              path: 'profile',
              name: 'profile',
              builder: (context, state) => ProfilePage(),
            )
          ]),
    ]);
