import 'package:book_flutter/BottomNaviPage.dart';
import 'package:book_flutter/ErrorPage.dart';
import 'package:book_flutter/book/BookAddGardenPage.dart';
import 'package:book_flutter/book/BookAddPage.dart';
import 'package:book_flutter/book/BookDetailPage.dart';
import 'package:book_flutter/book/BookEditPage.dart';
import 'package:book_flutter/book/BookRegisterPage.dart';
import 'package:book_flutter/book/BookSearchPage.dart';
import 'package:book_flutter/book/BookUserWritePage.dart';
import 'package:book_flutter/book/BookshelfPage.dart';
import 'package:book_flutter/features/book/domain/entities/book_add_done_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_edit_input_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_register_input_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_read_input_entity.dart';
import 'package:book_flutter/garden/GardenAddPage.dart';
import 'package:book_flutter/garden/GardenBookListPage.dart';
import 'package:book_flutter/garden/GardenEditPage.dart';
import 'package:book_flutter/garden/GardenInvitePage.dart';
import 'package:book_flutter/garden/GardenLeaderPage.dart';
import 'package:book_flutter/garden/GardenMemberPage.dart';
import 'package:book_flutter/garden/GardenPage.dart';
import 'package:book_flutter/main.dart';
import 'package:book_flutter/memo/MemoBookPage.dart';
import 'package:book_flutter/memo/MemoDetailPage.dart';
import 'package:book_flutter/memo/MemoPage.dart';
import 'package:book_flutter/memo/MemoWrite.dart';
import 'package:book_flutter/features/memo/domain/entities/memo_list_item_entity.dart';
import 'package:book_flutter/features/memo/domain/entities/memo_write_input_entity.dart';
import 'package:book_flutter/mypage/AlertSettingPage.dart';
import 'package:book_flutter/mypage/AuthManagePage.dart';
import 'package:book_flutter/mypage/MyPage.dart';
import 'package:book_flutter/mypage/NickNamePage.dart';
import 'package:book_flutter/mypage/ProfileImagePage.dart';
import 'package:book_flutter/mypage/ProfilePage.dart';
import 'package:book_flutter/mypage/TosPage.dart';
import 'package:book_flutter/onboarding/LoginPage.dart';
import 'package:book_flutter/onboarding/PwdFindPage.dart';
import 'package:book_flutter/onboarding/PwdSettingPage.dart';
import 'package:book_flutter/onboarding/SignupPage.dart';
import 'package:book_flutter/onboarding/StartPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: navigatorKey, // NavigatorKey 설정
    initialLocation: '/',
    errorBuilder: (context, state) => ErrorPage(),
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) => SplashPage(),
      ),
      GoRoute(
        path: '/error',
        name: 'error',
        builder: (context, state) {
          return ErrorPage();
        },
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
                            builder: (context, state) {
                              final String user_nick = state.extra as String;
                              return SignupDonePage(user_nick: user_nick);
                            })
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
                        return BookRegisterPage(
                          book: BookRegisterInputEntity.fromMap(book),
                        );
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
                      return BookEditPage(
                        book: BookEditInputEntity.fromMap(book),
                      );
                    },
                  ),
                  GoRoute(
                      path: 'book-add',
                      name: 'book-add',
                      builder: (context, state) {
                        final bookRead = state.extra as Map;
                        return BookAddPage(
                          bookRead: BookReadInputEntity.fromMap(bookRead),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'book-add-done',
                          name: 'book-add-done',
                          builder: (context, state) {
                            final bookRead = state.extra as Map;
                            return BookAddDonePage(
                              bookRead: BookAddDoneEntity.fromMap(bookRead),
                            );
                          },
                        )
                      ])
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
                      return MemoWritePage(
                        book: MemoWriteInputEntity.fromMap(
                          book.cast<String, dynamic>(),
                        ),
                      );
                    },
                  ),
                ],
                builder: (context, state) {
                  final Map memo = state.extra as Map;
                  return MemoDetailPage(
                    memo: MemoListItemEntity.fromMap(memo.cast<String, dynamic>()),
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
                      return MemoWritePage(
                        book: MemoWriteInputEntity.fromMap(
                          book.cast<String, dynamic>(),
                        ),
                      );
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
            ),
            GoRoute(
              path: 'tos',
              name: 'tos',
              builder: (context, state) => TosPage(),
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
                path: 'invite',
                name: 'invite',
                builder: (context, state) {
                  final int garden_no = state.extra as int;
                  return GardenInvitePage(garden_no: garden_no);
                }),
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
