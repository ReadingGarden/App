import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/book_search_repository.dart';
import '../../domain/entities/book_search_entity.dart';

final bookTotalCountProvider = StateProvider<int>((ref) => 0);
final barcodeValueProvider = StateProvider<String>((ref) => '');

final bookSearchListProvider = StateNotifierProvider<BookSearchListNotifier,
    List<BookSearchEntity>>((ref) {
  return BookSearchListNotifier();
});

final bookSearchRepositoryStateProvider = Provider<BookSearchRepository>((ref) {
  return ref.read(bookSearchRepositoryProvider);
});

class BookSearchListNotifier extends StateNotifier<List<BookSearchEntity>> {
  BookSearchListNotifier() : super([]);

  void addBookSearchList(List<BookSearchEntity> newBookSearchList) {
    state = [...state, ...newBookSearchList];
  }

  void reset() {
    state = [];
  }
}
