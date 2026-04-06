import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_write_input_entity.freezed.dart';
part 'memo_write_input_entity.g.dart';

@freezed
abstract class MemoWriteInputEntity with _$MemoWriteInputEntity {
  const MemoWriteInputEntity._();

  const factory MemoWriteInputEntity({
    required int bookNo,
    required String bookTitle,
    required String bookAuthor,
    required String? bookImageUrl,
    required String memoContent,
    required String? imageUrl,
    required int? gardenNo,
    int? id,
  }) = _MemoWriteInputEntity;

  factory MemoWriteInputEntity.fromJson(Map<String, dynamic> json) =>
      _$MemoWriteInputEntityFromJson(json);

  bool get isEdit => id != null;

  Map<String, dynamic> toRequestMap(String content) {
    return {
      'book_no': bookNo,
      'memo_content': content,
    };
  }
}
