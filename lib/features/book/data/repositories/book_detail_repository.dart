import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/book_detail_entity.dart';
import '../dtos/book_detail_dto.dart';
import '../services/book_service.dart';
import '../../../garden/data/services/garden_service.dart';
import '../../../memo/data/services/memo_service.dart';

final bookDetailRepositoryProvider = Provider<BookDetailRepository>((ref) {
  return BookDetailRepository(
    bookService: BookService(),
    gardenService: gardenService,
    memoService: memoService,
  );
});

class BookDetailRepository {
  BookDetailRepository({
    required this.bookService,
    required this.gardenService,
    required this.memoService,
  });

  final BookService bookService;
  final GardenService gardenService;
  final MemoService memoService;

  Future<BookDetailEntity?> fetchBookDetail(int bookNo) async {
    final response = await bookService.getBookRead(bookNo);
    if (response?.statusCode == 200) {
      final data = Map<String, dynamic>.from(response?.data['data'] ?? {});
      data['book_no'] ??= bookNo;
      return BookDetailDto(data).toEntity();
    }
    return null;
  }

  Future<Map<String, String>?> fetchGardenDetail(int gardenNo) async {
    final response = await gardenService.getGardenDetail(gardenNo);
    if (response?.statusCode == 200) {
      return {
        'garden_title': response?.data['data']['garden_title'] as String? ?? '',
        'garden_color': response?.data['data']['garden_color'] as String? ?? '',
      };
    }
    return null;
  }

  Future<int?> moveBook(int bookNo, int toGardenNo) async {
    final response = await bookService.putBook(bookNo, {
      'garden_no': toGardenNo,
    });
    return response?.statusCode;
  }

  Future<int?> deleteBook(int bookNo) async {
    final response = await bookService.deleteBook(bookNo);
    return response?.statusCode;
  }

  Future<int?> toggleMemoLike(int memoId) async {
    final response = await memoService.putMemoLike(memoId);
    return response?.statusCode;
  }
}
