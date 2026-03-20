import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dtos/book_search_dto.dart';
import '../services/book_service.dart';

final bookSearchRepositoryProvider = Provider<BookSearchRepository>((ref) {
  return BookSearchRepository(BookService());
});

class BookSearchRepository {
  BookSearchRepository(this._service);

  final BookService _service;

  Future<BookSearchResult?> searchBooks(String query, int page) async {
    final response = await _service.searchBooks(query, page);
    if (response?.statusCode == 200) {
      final List<dynamic> items = response?.data['data']['item'] ?? [];
      return BookSearchResult(
        totalCount: response?.data['data']['totalResults'] as int? ?? 0,
        items: items
            .map((json) => BookSearchDto(Map<String, dynamic>.from(json)).toEntity())
            .toList(),
      );
    }
    return null;
  }

  Future<int?> fetchBookByIsbn(String isbn13) async {
    final response = await _service.getBookByIsbn(isbn13);
    return response?.statusCode;
  }
}

class BookSearchResult {
  const BookSearchResult({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List items;
}

