import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_list_item_entity.freezed.dart';
part 'memo_list_item_entity.g.dart';

@freezed
abstract class MemoListItemEntity with _$MemoListItemEntity {
  const factory MemoListItemEntity({
    @Default(0) int id,
    @Default(0) int bookNo,
    @Default('') String bookTitle,
    @Default('') String bookAuthor,
    String? bookImageUrl,
    @Default('') String memoContent,
    @Default(false) bool memoLike,
    String? imageUrl,
    @Default('') String memoCreatedAt,
  }) = _MemoListItemEntity;

  factory MemoListItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MemoListItemEntityFromJson(json);
}
