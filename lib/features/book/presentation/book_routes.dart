import 'package:flutter/material.dart';
import 'package:book_flutter/features/book/domain/entities/book_add_done_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_edit_input_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_read_input_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_register_input_entity.dart';
import 'package:book_flutter/features/book/presentation/pages/book_add_garden_page.dart';
import 'package:book_flutter/features/book/presentation/pages/book_add_page.dart';
import 'package:book_flutter/features/book/presentation/pages/book_detail_page.dart';
import 'package:book_flutter/features/book/presentation/pages/book_edit_page.dart';
import 'package:book_flutter/features/book/presentation/pages/book_register_page.dart';
import 'package:book_flutter/features/book/presentation/pages/book_search_page.dart';
import 'package:book_flutter/features/book/presentation/pages/book_user_write_page.dart';
import 'package:book_flutter/features/book/presentation/pages/bookshelf_page.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> get bookRoutes => [
      GoRoute(
        path: '/bottom-navi/book-serach',
        name: 'book-serach',
        builder: (context, state) => const BookSearchPage(),
        routes: [
          GoRoute(
            path: 'book-add-garden',
            name: 'book-add-garden',
            builder: (context, state) {
              final extra = state.extra as Map;
              final isbn13 = extra['isbn13'] as String;
              final Map? book = extra['book'] as Map?;
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
                      final gardenName = state.extra as String;
                      return BookRegisterDonePage(gardenName: gardenName);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'book-user-write',
            name: 'book-user-write',
            builder: (context, state) => const BookUserWritePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/bottom-navi/bookshelf',
        name: 'bookshelf',
        builder: (context, state) => const BookShelfPage(),
        routes: [
          GoRoute(
            path: 'book-detail',
            name: 'book-detail',
            builder: (context, state) {
              final bookNo = state.extra as int;
              return BookDetailPage(bookNo: bookNo);
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
                    pageBuilder: (context, state) {
                      final bookRead = state.extra as Map;
                      return CustomTransitionPage(
                        child: BookAddDonePage(
                          bookRead: BookAddDoneEntity.fromMap(bookRead),
                        ),
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: Tween<double>(begin: 0.85, end: 1.0)
                                  .animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              )),
                              child: child,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
