import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/memo_repository.dart';
import '../../domain/entities/memo_list_item_entity.dart';

final memoListStateProvider =
    StateProvider<List<MemoListItemEntity>>((ref) => []);
final memoListPageProvider = StateProvider<int>((ref) => 1);
final memoListLoadingProvider = StateProvider<bool>((ref) => false);

final memoRepositoryStateProvider = Provider<MemoRepository>((ref) {
  return ref.read(memoRepositoryProvider);
});

Future<void> resetMemoList(WidgetRef ref) async {
  ref.read(memoListStateProvider.notifier).state = [];
  ref.read(memoListPageProvider.notifier).state = 1;
  ref.read(memoListLoadingProvider.notifier).state = false;
}

Future<void> fetchMemoList(WidgetRef ref, {bool scroll = false}) async {
  if (ref.read(memoListLoadingProvider)) {
    return;
  }

  ref.read(memoListLoadingProvider.notifier).state = true;
  final page = ref.read(memoListPageProvider);
  final repository = ref.read(memoRepositoryStateProvider);
  final memos = await repository.fetchMemoList(page);

  if (memos.isNotEmpty) {
    ref.read(memoListStateProvider.notifier).state = [
      ...ref.read(memoListStateProvider),
      ...memos,
    ];
    ref.read(memoListPageProvider.notifier).state = page + 1;
  }

  ref.read(memoListLoadingProvider.notifier).state = false;
}

Future<void> refreshMemoList(WidgetRef ref) async {
  await resetMemoList(ref);
  await fetchMemoList(ref);
}

Future<void> toggleMemoLike(WidgetRef ref, int index, int id) async {
  final repository = ref.read(memoRepositoryStateProvider);
  final updated = await repository.toggleMemoLike(id);
  if (!updated) {
    return;
  }

  final current = [...ref.read(memoListStateProvider)];
  current[index] = current[index].copyWith(memoLike: !current[index].memoLike);
  ref.read(memoListStateProvider.notifier).state = current;
}
