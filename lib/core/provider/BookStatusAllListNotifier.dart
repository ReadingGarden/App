import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Book.dart';

final bookStatusAllListProvider =
    StateNotifierProvider<BookStatusAllListNotifier, List<Book>>(
        (ref) => BookStatusAllListNotifier());

//책 상태(목록) 모든 리스트 조회 Notifier
class BookStatusAllListNotifier extends StateNotifier<List<Book>> {
  BookStatusAllListNotifier() : super([]);

  void addBookStatusAllList(List<Book> newBookStatusAllList) {
    state = [...state, ...newBookStatusAllList];
  }
}
