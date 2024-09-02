import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Book.dart';

final bookStatusAllListProvider =
    StateNotifierProvider<BookStatusAllListNotifier, List<Book>>(
        (ref) => BookStatusAllListNotifier());

class BookStatusAllListNotifier extends StateNotifier<List<Book>> {
  BookStatusAllListNotifier() : super([]);

  void addBookStatusAllList(List<Book> newBookStatusAllList) {
    state = [...state, ...newBookStatusAllList];
  }
}
