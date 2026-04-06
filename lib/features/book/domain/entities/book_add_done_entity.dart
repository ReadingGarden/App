import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_add_done_entity.freezed.dart';
part 'book_add_done_entity.g.dart';

@freezed
abstract class BookAddDoneEntity with _$BookAddDoneEntity {
  const factory BookAddDoneEntity({
    required String bookTitle,
    required String bookTree,
    required String bookStartDate,
    required String bookEndDate,
  }) = _BookAddDoneEntity;

  factory BookAddDoneEntity.fromJson(Map<String, dynamic> json) =>
      _$BookAddDoneEntityFromJson(json);
}
