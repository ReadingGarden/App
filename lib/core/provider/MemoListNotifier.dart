import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Memo.dart';

final memoListProvider = StateNotifierProvider<MemoListNotifier, List<Memo>>(
    (ref) => MemoListNotifier());

class MemoListNotifier extends StateNotifier<List<Memo>> {
  MemoListNotifier() : super([]);

  void addMemoList(List<Memo> newMemoList) {
    state = [...state, ...newMemoList];
  }
}
