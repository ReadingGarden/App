import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:book_flutter/shared/constants/app_constant.dart';
import '../../data/repositories/book_register_repository.dart';
import '../../domain/entities/book_register_input_entity.dart';

final bookRegisterRepositoryStateProvider =
    Provider<BookRegisterRepository>((ref) {
  return ref.read(bookRegisterRepositoryProvider);
});

class BookRegisterSaveResult {
  const BookRegisterSaveResult({
    required this.statusCode,
    required this.gardenTitle,
  });

  final int? statusCode;
  final String gardenTitle;
}

Future<BookRegisterSaveResult> saveBookRegistration(
  WidgetRef ref, {
  required BookRegisterInputEntity book,
  required List gardens,
  required int selectedGardenIndex,
  required int selectedFlowerIndex,
  required String startDate,
}) async {
  final repository = ref.read(bookRegisterRepositoryStateProvider);
  final selectedGarden = gardens[selectedGardenIndex];
  final gardenTitle = selectedGarden['garden_title'] as String? ?? '';

  final bookData = <String, dynamic>{
    'garden_no': selectedGarden['garden_no'],
    'book_title': book.title,
    'book_author': book.author,
    'book_publisher': book.publisher,
    'book_info': book.description,
    'book_tree': Constant.FLOWER_LIST[selectedFlowerIndex],
    'book_status': 0,
    'book_page': book.itemPage,
  };

  if (book.isbn13.isNotEmpty) {
    bookData['book_isbn'] = book.isbn13;
  }
  if (book.cover != null) {
    bookData['book_image_url'] = book.cover;
  }

  int? statusCode;
  int? bookNo = book.bookNo;

  if (bookNo == null) {
    final result = await repository.createBook(bookData);
    statusCode = result.statusCode;
    bookNo = result.bookNo;
  } else {
    statusCode = await repository.updateBook(bookNo, {
      'garden_no': selectedGarden['garden_no'],
      'book_tree': Constant.FLOWER_LIST[selectedFlowerIndex],
      'book_status': 0,
    });
  }

  if ((statusCode == 200 || statusCode == 201) &&
      startDate.isNotEmpty &&
      bookNo != null) {
    final bookStartDate = DateTime.parse(startDate.replaceAll('.', ''));
    statusCode = await repository.createBookRead({
      'book_no': bookNo,
      'book_start_date': bookStartDate.toString(),
      'book_current_page': 0,
    });
  }

  return BookRegisterSaveResult(
    statusCode: statusCode,
    gardenTitle: gardenTitle,
  );
}
