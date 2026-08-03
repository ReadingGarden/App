import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/book_add_repository.dart';
import '../../domain/entities/book_add_done_entity.dart';
import '../../domain/entities/book_read_input_entity.dart';

final bookAddRepositoryStateProvider = Provider<BookAddRepository>((ref) {
  return ref.read(bookAddRepositoryProvider);
});

class BookReadSaveResult {
  const BookReadSaveResult({
    required this.statusCode,
    this.done,
  });

  final int? statusCode;
  final BookAddDoneEntity? done;
}

Future<BookReadSaveResult> saveBookRead(
  WidgetRef ref, {
  required BookReadInputEntity bookRead,
  required int currentPage,
}) async {
  final Map<String, dynamic> data = {
    'book_no': bookRead.bookNo,
    'book_current_page': currentPage,
  };

  if (bookRead.bookCurrentPage == 0) {
    data['book_start_date'] = DateTime.now().toString();
  }

  if (currentPage == bookRead.bookPage) {
    data['book_end_date'] = DateTime.now().toString();
  }

  final statusCode =
      await ref.read(bookAddRepositoryStateProvider).saveBookRead(data);

  if (statusCode == 201 && currentPage == bookRead.bookPage) {
    final lastHistory =
        bookRead.bookReadList.isNotEmpty ? bookRead.bookReadList.last : {};
    return BookReadSaveResult(
      statusCode: statusCode,
      done: BookAddDoneEntity(
        bookNo: bookRead.bookNo,
        bookTitle: bookRead.bookTitle,
        bookTree: bookRead.bookTree,
        bookStartDate: lastHistory['book_start_date'] as String? ??
            DateTime.now().toString(),
        bookEndDate: DateTime.now().toString(),
      ),
    );
  }

  return BookReadSaveResult(statusCode: statusCode);
}

//완독 별점 저장 (1~5, 0은 미선택이라 호출하지 않음)
Future<int?> saveBookRating(
  WidgetRef ref, {
  required int bookNo,
  required int rating,
}) {
  return ref.read(bookAddRepositoryStateProvider).saveBookRating(bookNo, rating);
}
