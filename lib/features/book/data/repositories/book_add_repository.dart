import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/book_service.dart';

final bookAddRepositoryProvider = Provider<BookAddRepository>((ref) {
  return BookAddRepository(BookService());
});

class BookAddRepository {
  BookAddRepository(this._service);

  final BookService _service;

  Future<int?> saveBookRead(Map<String, dynamic> data) async {
    final response = await _service.postBookRead(data);
    return response?.statusCode;
  }
}

