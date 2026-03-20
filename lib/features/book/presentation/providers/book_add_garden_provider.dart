import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/book_add_garden_repository.dart';
import '../../domain/entities/book_isbn_detail_entity.dart';

final buttonCheckProvider = StateProvider<bool>((ref) => false);
final bookNoProvider = StateProvider<int?>((ref) => null);

final detailIsbnProvider =
    StateNotifierProvider<BookAddGardenNotifier, BookIsbnDetailEntity>((ref) {
  return BookAddGardenNotifier(ref.read(bookAddGardenRepositoryProvider));
});

class BookAddGardenNotifier extends StateNotifier<BookIsbnDetailEntity> {
  BookAddGardenNotifier(this._repository) : super(BookIsbnDetailEntity.empty);

  final BookAddGardenRepository _repository;

  void reset() {
    state = BookIsbnDetailEntity.empty;
  }

  void setInitialBook(Map book) {
    state = BookIsbnDetailEntity(
      title: book['title'] as String? ?? '',
      author: book['author'] as String? ?? '',
      description: book['description'] as String? ?? '',
      isbn13: book['isbn13'] as String? ?? '',
      cover: book['cover'] as String?,
      publisher: book['publisher'] as String? ?? '',
      itemPage: book['itemPage'] as int? ?? 0,
      bookNo: book['book_no'] as int?,
    );
  }

  Future<void> fetchBookDetail(String isbn) async {
    final detail = await _repository.fetchBookDetailByIsbn(isbn);
    if (detail != null) {
      state = detail;
    }
  }

  Future<int?> createWishBook() {
    return _repository.createWishBook(state);
  }

  Future<int?> deleteWishBook(int bookNo) {
    return _repository.deleteWishBook(bookNo);
  }

  Future<int?> checkDuplication(String isbn13) {
    return _repository.checkDuplication(isbn13);
  }
}
