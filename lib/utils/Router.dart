import 'package:book_flutter/memo/MemoDetailPage.dart';
import 'package:book_flutter/memo/MemoWrite.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../ErrorPage.dart';
import '../garden/GardenPage.dart';
import '../memo/MemoPage.dart';
import '../memo/MemoBookPage.dart';
import '../mypage/MyPage.dart';
import '../mypage/AlertSettingPage.dart';
import '../mypage/AuthManagePage.dart';
import '../mypage/NickNamePage.dart';
import '../mypage/ProfileImagePage.dart';
import '../mypage/ProfilePage.dart';
import '../onboarding/LoginPage.dart';
import '../onboarding/PwdFindPage.dart';
import '../onboarding/PwdSettingPage.dart';
import '../onboarding/SignupPage.dart';
import '../onboarding/StartPage.dart';
import '../BottomNaviPage.dart';

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
          path: '/bottom-navi/memo',
          name: 'memo',
          builder: (context, state) => MemoPage(),
          routes: [
            GoRoute(
              path: 'memo-detail',
              name: 'memo-detail',
              builder: (context, state) => MemoDetailPage(),
            ),
            GoRoute(
                path: 'memo-book',
                name: 'memo-book',
                builder: (context, state) => MemoBookPage(),
                routes: [
                  GoRoute(
                    path: 'memo-write',
                    name: 'memo-write',
                    builder: (context, state) => MemoWritePage(),
                  ),
                ]),
          ]),
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
            ),
            GoRoute(
              path: 'alert',
              name: 'alert',
              builder: (context, state) => AlertSettingPage(),
            )
          ]),
      GoRoute(
          path: '/garden',
          name: 'garden',
          builder: (context, state) => GardenPage()),
    ]);
