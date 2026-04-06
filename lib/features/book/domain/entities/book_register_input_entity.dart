import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_register_input_entity.freezed.dart';
part 'book_register_input_entity.g.dart';

@freezed
abstract class BookRegisterInputEntity with _$BookRegisterInputEntity {
  const factory BookRegisterInputEntity({
    required String title,
    required String author,
    required String description,
    required String isbn13,
    required String? cover,
    required String publisher,
    @JsonKey(name: 'itemPage') required int itemPage,
    required int? bookNo,
  }) = _BookRegisterInputEntity;

  factory BookRegisterInputEntity.fromJson(Map<String, dynamic> json) =>
      _$BookRegisterInputEntityFromJson(json);
}
