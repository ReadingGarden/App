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

  Future<int?> createMemo(Map<String, dynamic> data) async {
    final response = await _service.postMemo(data);
    if (response?.statusCode == 201) {
      return response?.data['data']['id'] as int?;
    }
    return null;
  }

  Future<bool> updateMemo(int id, Map<String, dynamic> data) async {
    final response = await _service.putMemo(id, data);
    return response?.statusCode == 200;
  }

  Future<bool> uploadMemoImage(int id, String imagePath) async {
    final response = await _service.postMemoImage(id, imagePath);
    return response?.statusCode == 201;
  }

  Future<bool> deleteMemoImage(int id) async {
    final response = await _service.deleteMemoImage(id);
    return response?.statusCode == 201;
  }
}
