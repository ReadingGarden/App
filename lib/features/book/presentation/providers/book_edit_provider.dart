import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/Functions.dart';
import '../../data/repositories/book_edit_repository.dart';
import '../../domain/entities/book_edit_history_entity.dart';

final bookReadListProvider =
    StateProvider<List<BookEditHistoryEntity>>((ref) => []);

final bookEditRepositoryStateProvider = Provider<BookEditRepository>((ref) {
  return ref.read(bookEditRepositoryProvider);
});

Future<void> fetchBookReadList(WidgetRef ref, int bookNo) async {
  final list = await ref.read(bookEditRepositoryStateProvider).fetchBookReadList(
        bookNo,
      );
  ref.read(bookReadListProvider.notifier).state = list;
}

Future<void> updateBookReadDates(
  WidgetRef ref, {
  required List<BookEditHistoryEntity> bookReadList,
  required String startDate,
  required String endDate,
}) async {
  if (bookReadList.isEmpty) {
    return;
  }

  final repository = ref.read(bookEditRepositoryStateProvider);
  final firstHistory = bookReadList.first;
  final lastHistory = bookReadList.last;

  if (startDate.isNotEmpty &&
      startDate != Functions.formatBookReadDate(lastHistory.bookStartDate!)) {
    await repository.updateBookRead(lastHistory.id, {
      'book_start_date': Functions.formatBookReadString(startDate).toString(),
    });
  }

  if (endDate.isNotEmpty &&
      firstHistory.bookEndDate != null &&
      endDate != Functions.formatBookReadDate(firstHistory.bookEndDate!)) {
    await repository.updateBookRead(firstHistory.id, {
      'book_end_date': Functions.formatBookReadString(endDate).toString(),
    });
  }
}
