import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/memo_book_repository.dart';
import '../../domain/entities/memo_book_selector_entity.dart';

final memoBookListProvider =
    StateProvider<List<MemoBookSelectorEntity>>((ref) => []);
final memoBookPageProvider = StateProvider<int>((ref) => 1);
final memoBookLoadingProvider = StateProvider<bool>((ref) => false);

Future<void> resetMemoBookList(WidgetRef ref) async {
  ref.read(memoBookListProvider.notifier).state = [];
  ref.read(memoBookPageProvider.notifier).state = 1;
  ref.read(memoBookLoadingProvider.notifier).state = false;
}

Future<void> fetchMemoBookList(WidgetRef ref) async {
  if (ref.read(memoBookLoadingProvider)) {
    return;
  }

  ref.read(memoBookLoadingProvider.notifier).state = true;
  final repository = ref.read(memoBookRepositoryProvider);
  final page = ref.read(memoBookPageProvider);
  final books = await repository.fetchSelectableBooks(page);

  if (books.isNotEmpty) {
    ref.read(memoBookListProvider.notifier).state = [
      ...ref.read(memoBookListProvider),
      ...books,
    ];
    ref.read(memoBookPageProvider.notifier).state = page + 1;
  }

  ref.read(memoBookLoadingProvider.notifier).state = false;
}
