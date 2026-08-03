import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/book_service.dart';

final bookRegisterRepositoryProvider = Provider<BookRegisterRepository>((ref) {
  return BookRegisterRepository(BookService());
});

class BookRegisterRepository {
  BookRegisterRepository(this._service);

  final BookService _service;

  Future<BookRegisterResult> createBook(Map<String, dynamic> data) async {
    final response = await _service.createWishBook(data);
    return BookRegisterResult(
      statusCode: response?.statusCode,
      bookNo: response?.data['data']['book_no'] as int?,
    );
  }

  Future<int?> updateBook(int bookNo, Map<String, dynamic> data) async {
    final response = await _service.putBook(bookNo, data);
    return response?.statusCode;
  }

  Future<int?> createBookRead(Map<String, dynamic> data) async {
    final response = await _service.postBookRead(data);
    return response?.statusCode;
  }
}

class BookRegisterResult {
  const BookRegisterResult({required this.statusCode, required this.bookNo});

  final int? statusCode;
  final int? bookNo;
}
