import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Book.dart';

final bookStatusListProvider =
    StateNotifierProvider<BookStatusListNotifier, List<Book>>(
        (ref) => BookStatusListNotifier());

class BookStatusListNotifier extends StateNotifier<List<Book>> {
  BookStatusListNotifier() : super([]);

  void addBookStatusList(List<Book> newBookStatusList) {
    state = [...state, ...newBookStatusList];
  }

  void reset() {
    state = [];
  }
}
