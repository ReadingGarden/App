import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_edit_input_entity.freezed.dart';
part 'book_edit_input_entity.g.dart';

@freezed
abstract class BookEditInputEntity with _$BookEditInputEntity {
  const factory BookEditInputEntity({
    required int bookNo,
    required String bookTitle,
    required String bookAuthor,
    required String? bookImageUrl,
  }) = _BookEditInputEntity;

  factory BookEditInputEntity.fromJson(Map<String, dynamic> json) =>
      _$BookEditInputEntityFromJson(json);
}
