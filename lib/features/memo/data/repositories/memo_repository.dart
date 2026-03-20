import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/service/MemoService.dart';
import '../../domain/entities/memo_list_item_entity.dart';

final memoRepositoryProvider = Provider<MemoRepository>((ref) {
  return MemoRepository(memoService);
});

class MemoRepository {
  MemoRepository(this._service);

  final MemoService _service;

  Future<List<MemoListItemEntity>> fetchMemoList(int page) async {
    final response = await _service.getMemoList(page);
    if (response?.statusCode == 200) {
      final List<dynamic> memoList = response?.data['data']['list'] ?? [];
      return memoList
          .map((item) => MemoListItemEntity.fromMap(
              Map<String, dynamic>.from(item as Map)))
          .toList();
    }
    return [];
  }

  Future<bool> toggleMemoLike(int id) async {
    final response = await _service.putMemoLike(id);
    return response?.statusCode == 200;
  }

  Future<bool> deleteMemo(int id) async {
    final response = await _service.deleteMemo(id);
    return response?.statusCode == 200;
  }
}
