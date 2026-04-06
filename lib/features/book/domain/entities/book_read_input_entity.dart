import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_read_input_entity.freezed.dart';
part 'book_read_input_entity.g.dart';

@freezed
abstract class BookReadInputEntity with _$BookReadInputEntity {
  const factory BookReadInputEntity({
    required int bookNo,
    required String bookTitle,
    required String bookTree,
    required int bookPage,
    required int bookCurrentPage,
    required List<Map<String, dynamic>> bookReadList,
  }) = _BookReadInputEntity;

  factory BookReadInputEntity.fromJson(Map<String, dynamic> json) =>
      _$BookReadInputEntityFromJson(json);
}
