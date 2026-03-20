import 'package:book_flutter/features/memo/domain/entities/memo_list_item_entity.dart';
import 'package:book_flutter/features/memo/domain/entities/memo_write_input_entity.dart';
import 'package:book_flutter/features/memo/presentation/pages/memo_book_page.dart';
import 'package:book_flutter/features/memo/presentation/pages/memo_detail_page.dart';
import 'package:book_flutter/features/memo/presentation/pages/memo_page.dart';
import 'package:book_flutter/features/memo/presentation/pages/memo_write_page.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> get memoRoutes => [
      GoRoute(
        path: '/bottom-navi/memo',
        name: 'memo',
        builder: (context, state) => const MemoPage(),
        routes: [
          GoRoute(
            path: 'memo-detail',
            name: 'memo-detail',
            builder: (context, state) {
              final memo = state.extra as Map;
              return MemoDetailPage(
                memo: MemoListItemEntity.fromMap(memo.cast<String, dynamic>()),
              );
            },
            routes: [
              GoRoute(
                path: 'memo-update',
                name: 'memo-update',
                builder: (context, state) {
                  final book = state.extra as Map;
                  return MemoWritePage(
                    book: MemoWriteInputEntity.fromMap(
                      book.cast<String, dynamic>(),
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: 'memo-book',
            name: 'memo-book',
            builder: (context, state) => const MemoBookPage(),
            routes: [
              GoRoute(
                path: 'memo-write',
                name: 'memo-write',
                builder: (context, state) {
                  final book = state.extra as Map;
                  return MemoWritePage(
                    book: MemoWriteInputEntity.fromMap(
                      book.cast<String, dynamic>(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ];
