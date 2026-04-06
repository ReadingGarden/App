import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_write_input_entity.freezed.dart';
part 'memo_write_input_entity.g.dart';

@freezed
abstract class MemoWriteInputEntity with _$MemoWriteInputEntity {
  const MemoWriteInputEntity._();

  const factory MemoWriteInputEntity({
    @Default(0) int bookNo,
    @Default('') String bookTitle,
    @Default('') String bookAuthor,
    String? bookImageUrl,
    @Default('') String memoContent,
    String? imageUrl,
    int? gardenNo,
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
