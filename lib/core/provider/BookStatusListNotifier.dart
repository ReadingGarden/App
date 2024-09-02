import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Book.dart';

final bookStatusListProvider =
    StateNotifierProvider<BookStatusListNotifier, List<Book>>(
        (ref) => BookStatusListNotifier());

//책 상태(목록) 리스트 조회 Notifier
class BookStatusListNotifier extends StateNotifier<List<Book>> {
  BookStatusListNotifier() : super([]);

  void addBookStatusList(List<Book> newBookStatusList) {
    state = [...state, ...newBookStatusList];
  }

  void reset() {
    state = [];
  }
}
