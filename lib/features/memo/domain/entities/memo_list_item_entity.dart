import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_list_item_entity.freezed.dart';
part 'memo_list_item_entity.g.dart';

@freezed
abstract class MemoListItemEntity with _$MemoListItemEntity {
  const factory MemoListItemEntity({
    required int id,
    required int bookNo,
    required String bookTitle,
    required String bookAuthor,
    required String? bookImageUrl,
    required String memoContent,
    required bool memoLike,
    required String? imageUrl,
    required String memoCreatedAt,
  }) = _MemoListItemEntity;

  factory MemoListItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MemoListItemEntityFromJson(json);
}
