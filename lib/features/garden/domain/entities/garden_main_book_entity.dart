import 'package:freezed_annotation/freezed_annotation.dart';

part 'garden_main_book_entity.freezed.dart';
part 'garden_main_book_entity.g.dart';

@freezed
abstract class GardenMainBookEntity with _$GardenMainBookEntity {
  const factory GardenMainBookEntity({
    @Default(0) int bookNo,
    @Default('') String bookTitle,
    @Default('') String bookAuthor,
    @Default('') String bookImageUrl,
    @Default('') String bookTree,
    @Default(0) double percent,
    @Default(0) int userNo,
  }) = _GardenMainBookEntity;

  factory GardenMainBookEntity.fromJson(Map<String, dynamic> json) =>
      _$GardenMainBookEntityFromJson(json);
}
