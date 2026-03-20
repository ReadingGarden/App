import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/book_edit_history_entity.dart';
import '../services/book_service.dart';

final bookEditRepositoryProvider = Provider<BookEditRepository>((ref) {
  return BookEditRepository(BookService());
});

class BookEditRepository {
  BookEditRepository(this._service);

  final BookService _service;

  Future<List<BookEditHistoryEntity>> fetchBookReadList(int bookNo) async {
    final response = await _service.getBookRead(bookNo);
    if (response?.statusCode == 200) {
      final List list = response?.data['data']['book_read_list'] ?? [];
      return list
          .map((item) => BookEditHistoryEntity(
                id: (item as Map)['id'] as int? ?? 0,
                bookStartDate: item['book_start_date'] as String?,
                bookEndDate: item['book_end_date'] as String?,
              ))
          .toList();
    }
    return [];
  }

  Future<bool> updateBookRead(int id, Map<String, dynamic> data) async {
    final response = await _service.putBookRead(id, data);
    return response?.statusCode == 200;
  }
}

