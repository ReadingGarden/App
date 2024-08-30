// Memo 리스트를 관리하는 StateNotifierProvider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Memo.dart';

final memoListProvider =
    StateNotifierProvider<MemoListNotifier, List<Memo>>((ref) {
  return MemoListNotifier();
});

class MemoListNotifier extends StateNotifier<List<Memo>> {
  MemoListNotifier() : super([]);

  void addMemoList(List<Memo> newMemoList) {
    state = [...state, ...newMemoList];
  }
}
