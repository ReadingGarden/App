import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/book_detail_repository.dart';
import '../../domain/entities/book_detail_entity.dart';
import '../../domain/entities/book_memo_summary_entity.dart';

final bookDetailMemoListProvider =
    StateProvider<List<BookMemoSummaryEntity>>((ref) => []);
final bookDetailMemoSelectIndexListProvider =
    StateProvider<List<bool>>((ref) => []);

final bookDetailProvider =
    StateNotifierProvider<BookDetailNotifier, BookDetailEntity>((ref) {
  return BookDetailNotifier(ref.read(bookDetailRepositoryProvider));
});

class BookDetailNotifier extends StateNotifier<BookDetailEntity> {
  BookDetailNotifier(this._repository) : super(BookDetailEntity.empty);

  final BookDetailRepository _repository;

  void updateBookDetail(BookDetailEntity data) {
    state = data;
  }

  void updateGardenDetail(Map<String, String> gardenDetail) {
    state = state.copyWith(
      gardenTitle: gardenDetail['garden_title'] ?? '',
      gardenColor: gardenDetail['garden_color'] ?? '',
    );
  }

  void reset(WidgetRef ref) {
    state = BookDetailEntity.empty;
    ref.read(bookDetailMemoListProvider.notifier).state = [];
    ref.read(bookDetailMemoSelectIndexListProvider.notifier).state = [];
  }

  Future<void> fetchDetail(WidgetRef ref, int bookNo) async {
    final detail = await _repository.fetchBookDetail(bookNo);
    if (detail == null) {
      return;
    }

    updateBookDetail(detail);

    final memoList = detail.memoList;
    ref.read(bookDetailMemoListProvider.notifier).state = memoList;
    ref.read(bookDetailMemoSelectIndexListProvider.notifier).state =
        memoList.map((memo) => memo.memoLike).toList();

    final gardenNo = detail.gardenNo;
    if (gardenNo is int) {
      final gardenDetail = await _repository.fetchGardenDetail(gardenNo);
      if (gardenDetail != null) {
        updateGardenDetail(gardenDetail);
      }
    }
  }

  Future<int?> moveBook(WidgetRef ref, int bookNo, int toGardenNo) async {
    final statusCode = await _repository.moveBook(bookNo, toGardenNo);
    if (statusCode == 200) {
      await fetchDetail(ref, bookNo);
    }
    return statusCode;
  }

  Future<int?> deleteBook(int bookNo) {
    return _repository.deleteBook(bookNo);
  }

  Future<int?> toggleMemoLike(WidgetRef ref, int index, int memoId) async {
    final statusCode = await _repository.toggleMemoLike(memoId);
    if (statusCode == 200) {
      ref.read(bookDetailMemoSelectIndexListProvider.notifier).update((state) {
        final nextState = List<bool>.from(state);
        if (index < nextState.length) {
          nextState[index] = !nextState[index];
        }
        return nextState;
      });
    }
    return statusCode;
  }
}
