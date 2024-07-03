import 'package:book_flutter/BottomNaviPage.dart';
import 'package:book_flutter/mypage/AuthManagePage.dart';
import 'package:book_flutter/mypage/NickNamePage.dart';
import 'package:book_flutter/mypage/ProfileImagePage.dart';
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
        path: '/bottom-navi',
        name: 'bottom-navi',
        builder: (context, state) => BottomNaviPage(),
      ),
      GoRoute(
          path: '/bottom-navi/mypage',
          name: 'mypage',
          builder: (context, state) => MyPage(),
          routes: [
            GoRoute(
                path: 'profile',
                name: 'profile',
                builder: (context, state) => ProfilePage(),
                routes: [
                  GoRoute(
                    path: 'nickname',
                    name: 'nickname',
                    builder: (context, state) => NickNamePage(),
                  ),
                  GoRoute(
                    path: 'profile-image',
                    name: 'profile-image',
                    builder: (context, state) => ProfileImagePage(),
                  )
                ]),
            GoRoute(
              path: 'auth-manage',
              name: 'auth-manage',
              builder: (context, state) => AuthManagePage(),
            )
          ]),
      GoRoute(
          path: '/garden',
          name: 'garden',
          builder: (context, state) => GardenPage()),
    ]);
