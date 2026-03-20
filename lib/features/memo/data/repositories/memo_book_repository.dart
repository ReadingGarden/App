import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/service/BookService.dart';
import '../../domain/entities/memo_book_selector_entity.dart';

final memoBookRepositoryProvider = Provider<MemoBookRepository>((ref) {
  return MemoBookRepository(bookService);
});

class MemoBookRepository {
  MemoBookRepository(this._service);

  final BookService _service;

  Future<List<MemoBookSelectorEntity>> fetchSelectableBooks(int page) async {
    final response = await _service.getBookStatusList(3, page);
    if (response?.statusCode == 200) {
      final List<dynamic> bookList = response?.data['data']['list'] ?? [];
      return bookList
          .map((item) => MemoBookSelectorEntity.fromMap(
              Map<String, dynamic>.from(item as Map)))
          .toList();
    }
    return [];
  }
}
