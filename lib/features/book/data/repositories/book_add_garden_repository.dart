import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/book_isbn_detail_entity.dart';
import '../dtos/book_isbn_detail_dto.dart';
import '../services/book_service.dart';

final bookAddGardenRepositoryProvider =
    Provider<BookAddGardenRepository>((ref) {
  return BookAddGardenRepository(BookService());
});

class BookAddGardenRepository {
  BookAddGardenRepository(this._service);

  final BookService _service;

  Future<BookIsbnDetailEntity?> fetchBookDetailByIsbn(String isbn) async {
    final response = await _service.getBookByIsbn(isbn);
    if (response?.statusCode == 200) {
      return BookIsbnDetailDto(
        Map<String, dynamic>.from(response?.data['data'] ?? {}),
      ).toEntity();
    }
    return null;
  }

  Future<int?> createWishBook(BookIsbnDetailEntity book) async {
    final response = await _service.createWishBook({
      'book_title': book.title,
      'book_author': book.author,
      'book_publisher': book.publisher,
      'book_info': book.description,
      'book_status': 2,
      'book_page': book.itemPage,
      'book_image_url': book.cover,
    });
    if (response?.statusCode == 201) {
      return response?.data['data']['book_no'] as int?;
    }
    return null;
  }

  Future<int?> deleteWishBook(int bookNo) async {
    final response = await _service.deleteBook(bookNo);
    return response?.statusCode;
  }

  Future<int?> checkDuplication(String isbn13) async {
    final response = await _service.checkBookDuplication(isbn13);
    return response?.statusCode;
  }
}

