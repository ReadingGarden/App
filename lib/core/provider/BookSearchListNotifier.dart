import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/BookSearch.dart';

final bookSearchListProvider =
    StateNotifierProvider<BookSearchListNotifier, List<BookSearch>>(
        (ref) => BookSearchListNotifier());

//책 검색 리스트 조회 Notifier
class BookSearchListNotifier extends StateNotifier<List<BookSearch>> {
  BookSearchListNotifier() : super([]);

  void addBookSearchList(List<BookSearch> newBookSearchList) {
    state = [...state, ...newBookSearchList];
  }

  void reset() {
    state = [];
  }
}
