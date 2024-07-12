import 'package:book_flutter/book/BookAddGardenPage.dart';
import 'package:book_flutter/book/BookAddPage.dart';
import 'package:book_flutter/book/BookSerachPage.dart';
import 'package:book_flutter/book/BookUserWritePage.dart';
import 'package:book_flutter/book/BookshelfPage.dart';
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
                              final String user_email = (state.extra
                                  as Map<String, dynamic>)['user_email'];
                              final bool isLoginPage = (state.extra
                                  as Map<String, dynamic>)['isLoginPage'];
                              return PwdSettingPage(
                                  user_email: user_email,
                                  isLoginPage: isLoginPage);
                            })
                      ])
                ]),
          ]),
      GoRoute(
        path: '/bottom-navi',
        name: 'bottom-navi',
        builder: (context, state) => const BottomNaviPage(),
      ),
      GoRoute(
          path: '/bottom-navi/book-serach',
          name: 'book-serach',
          builder: (context, state) => BookSerachPage(),
          routes: [
            GoRoute(
                path: 'book-add-garden',
                name: 'book-add-garden',
                builder: (context, state) => BookAddGardenPage()),
            GoRoute(
                path: 'book-user-write',
                name: 'book-user-write',
                builder: (context, state) => BookUserWritePage()),
          ]),
      GoRoute(
          path: '/bottom-navi/bookshelf',
          name: 'bookshelf',
          builder: (context, state) => BookAddPage()),
      GoRoute(
          path: '/bottom-navi/memo',
          name: 'memo',
          builder: (context, state) => MemoPage(),
          routes: [
            GoRoute(
                path: 'memo-detail',
                name: 'memo-detail',
                routes: [
                  GoRoute(
                    path: 'memo-update',
                    name: 'memo-update',
                    builder: (context, state) {
                      final Map book = state.extra as Map;
                      return MemoWritePage(book: book);
                    },
                  ),
                ],
                builder: (context, state) {
                  final Map memo = state.extra as Map;
                  return MemoDetailPage(
                    memo: memo,
                  );
                }),
            GoRoute(
                path: 'memo-book',
                name: 'memo-book',
                builder: (context, state) => MemoBookPage(),
                routes: [
                  GoRoute(
                    path: 'memo-write',
                    name: 'memo-write',
                    builder: (context, state) {
                      final Map book = state.extra as Map;
                      // final Map? memo = state.extra as Map;
                      return MemoWritePage(book: book);
                    },
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
