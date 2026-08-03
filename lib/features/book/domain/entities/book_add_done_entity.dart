import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_add_done_entity.freezed.dart';
part 'book_add_done_entity.g.dart';

@freezed
abstract class BookAddDoneEntity with _$BookAddDoneEntity {
  const factory BookAddDoneEntity({
    @Default(0) int bookNo,
    @Default('') String bookTitle,
    @Default('') String bookTree,
    @Default('') String bookStartDate,
    @Default('') String bookEndDate,
  }) = _BookAddDoneEntity;

  factory BookAddDoneEntity.fromJson(Map<String, dynamic> json) =>
      _$BookAddDoneEntityFromJson(json);
}
