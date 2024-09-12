import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../book/BookAddGardenPage.dart';
import '../book/BookAddPage.dart';
import '../book/BookshelfPage.dart';
import '../book/BookDetailPage.dart';
import '../book/BookEditPage.dart';
import '../book/BookRegisterPage.dart';
import '../book/BookSearchPage.dart';
import '../book/BookUserWritePage.dart';
import '../garden/GardenAddPage.dart';
import '../garden/GardenBookListPage.dart';
import '../garden/GardenEditPage.dart';
import '../garden/GardenLeaderPage.dart';
import '../garden/GardenMemberPage.dart';
import '../main.dart';
import '../ErrorPage.dart';
import '../garden/GardenPage.dart';
import '../memo/MemoDetailPage.dart';
import '../memo/MemoPage.dart';
import '../memo/MemoBookPage.dart';
import '../memo/MemoWrite.dart';
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
                          path: 'signup-done',
                          name: 'signup-done',
                          builder: (context, state) => SignupDonePage(),
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
          builder: (context, state) => BookSearchPage(),
          routes: [
            GoRoute(
                path: 'book-add-garden',
                name: 'book-add-garden',
                builder: (context, state) {
                  final String isbn13 =
                      (state.extra as Map)['isbn13'] as String;
                  final Map? book = (state.extra as Map?)?['book'];
                  return BookAddGardenPage(book, isbn13: isbn13);
                },
                routes: [
                  GoRoute(
                      path: 'book-register',
                      name: 'book-register',
                      builder: (context, state) {
                        final book = state.extra as Map;
                        return BookRegisterPage(book: book);
                      },
                      routes: [
                        GoRoute(
                            path: 'book-register-done',
                            name: 'book-register-done',
                            builder: (context, state) {
                              String gardenName = state.extra as String;
                              return BookRegisterDonePage(
                                gardenName: gardenName,
                              );
                            })
                      ]),
                ]),
            GoRoute(
                path: 'book-user-write',
                name: 'book-user-write',
                builder: (context, state) => BookUserWritePage()),
          ]),
      GoRoute(
          path: '/bottom-navi/bookshelf',
          name: 'bookshelf',
          builder: (context, state) => BookShelfPage(),
          routes: [
            GoRoute(
                path: 'book-detail',
                name: 'book-detail',
                builder: (context, state) {
                  final book_no = state.extra as int;
                  return BookDetailPage(book_no: book_no);
                },
                routes: [
                  GoRoute(
                    path: 'book-edit',
                    name: 'book-edit',
                    builder: (context, state) {
                      final book = state.extra as Map;
                      return BookEditPage(book: book);
                    },
                  ),
                  GoRoute(
                      path: 'book-add',
                      name: 'book-add',
                      builder: (context, state) {
                        final bookRead = state.extra as Map;
                        return BookAddPage(
                          bookRead: bookRead,
                        );
                      })
                ]),
          ]),
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
          path: '/bottom-navi/garden',
          name: 'garden',
          builder: (context, state) {
            return GardenPage();
          },
          routes: [
            // GoRoute(
            //     path: 'book-detail',
            //     name: 'book-detail',
            //     builder: (context, state) => BookDetailPage(),
            //     routes: [
            //       GoRoute(
            //         path: 'book-edit',
            //         name: 'book-edit',
            //         builder: (context, state) {
            //           final book = state.extra as Map;
            //           return BookEditPage(book: book);
            //         },
            //       )
            //     ]),
            GoRoute(
                path: 'garden-edit',
                name: 'garden-edit',
                builder: (context, state) {
                  // final Map garden = state.extra as Map;
                  return GardenEditPage();
                }),
            GoRoute(
                path: 'garden-book',
                name: 'garden-book',
                builder: (context, state) {
                  final Map garden = state.extra as Map;
                  return GardenBookListPage(garden: garden);
                }),
            GoRoute(
                path: 'garden-member',
                name: 'garden-member',
                builder: (context, state) {
                  final int garden_no = state.extra as int;
                  return GardenMemberPage(garden_no: garden_no);
                },
                routes: [
                  GoRoute(
                    path: 'garden-leader',
                    name: 'garden-leader',
                    builder: (context, state) => GardenLeaderPage(),
                  )
                ]),
            GoRoute(
                path: 'garden-add',
                name: 'garden-add',
                builder: (context, state) => GardenAddPage(),
                routes: [
                  GoRoute(
                      path: 'garden-add-done',
                      name: 'garden-add-done',
                      builder: (context, state) => GardenAddDonePage())
                ])
          ]),
    ]);
