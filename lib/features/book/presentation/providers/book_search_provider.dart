import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/book_search_repository.dart';
import '../../domain/entities/book_search_entity.dart';
import '../../domain/entities/bookshelf_book_entity.dart';

final bookTotalCountProvider = StateProvider<int>((ref) => 0);
final barcodeValueProvider = StateProvider<String>((ref) => '');
final bookshelfPageViewIndexProvider = StateProvider<int>((ref) => 0);
final bookshelfLoadingProvider = StateProvider<bool>((ref) => false);
final bookshelfCurrentPageProvider = StateProvider<int>((ref) => 1);
final bookshelfHasMoreProvider = StateProvider<bool>((ref) => true);

final bookSearchListProvider =
    StateNotifierProvider<BookSearchListNotifier, List<BookSearchEntity>>(
        (ref) {
  return BookSearchListNotifier();
});

final bookSearchRepositoryStateProvider = Provider<BookSearchRepository>((ref) {
  return ref.read(bookSearchRepositoryProvider);
});

final bookshelfBooksProvider =
    StateNotifierProvider<BookshelfBookListNotifier, List<BookshelfBookEntity>>(
        (ref) {
  return BookshelfBookListNotifier();
});

class BookSearchListNotifier extends StateNotifier<List<BookSearchEntity>> {
  BookSearchListNotifier() : super([]);

  void addBookSearchList(List<BookSearchEntity> newBookSearchList) {
    state = [...state, ...newBookSearchList];
  }

  void reset() {
    state = [];
  }
}

class BookshelfBookListNotifier
    extends StateNotifier<List<BookshelfBookEntity>> {
  BookshelfBookListNotifier() : super([]);

  void addBooks(List<BookshelfBookEntity> books) {
    state = [...state, ...books];
  }

  void reset() {
    state = [];
  }
}

Future<void> fetchBookshelfBooks(
  WidgetRef ref,
  int status, {
  bool scroll = false,
}) async {
  if (scroll && !ref.read(bookshelfHasMoreProvider)) return;

  if (ref.read(bookshelfLoadingProvider) && !scroll) {
    ref.read(bookshelfLoadingProvider.notifier).state = false;
  }

  ref.read(bookshelfLoadingProvider.notifier).state = true;

  if (!scroll) {
    ref.read(bookshelfHasMoreProvider.notifier).state = true;
  }

  final page = scroll ? ref.read(bookshelfCurrentPageProvider) : 1;
  final result = await ref
      .read(bookSearchRepositoryStateProvider)
      .fetchBookshelfBooks(status, page);

  // 응답 도착 시 현재 탭과 요청 탭이 다르면 무시
  if (ref.read(bookshelfPageViewIndexProvider) != status) {
    ref.read(bookshelfLoadingProvider.notifier).state = false;
    return;
  }

  if (!scroll) {
    ref.read(bookshelfBooksProvider.notifier).reset();
  }

  if (result.books.isNotEmpty) {
    ref.read(bookshelfBooksProvider.notifier).addBooks(result.books);
    ref.read(bookshelfCurrentPageProvider.notifier).state = page + 1;
  }

  if (result.currentPage >= result.maxPage) {
    ref.read(bookshelfHasMoreProvider.notifier).state = false;
  }

  ref.read(bookshelfLoadingProvider.notifier).state = false;
}

void resetBookshelf(WidgetRef ref) {
  ref.read(bookshelfBooksProvider.notifier).reset();
  ref.read(bookshelfCurrentPageProvider.notifier).state = 1;
  ref.read(bookshelfHasMoreProvider.notifier).state = true;
}
