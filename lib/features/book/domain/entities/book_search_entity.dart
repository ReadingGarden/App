import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_search_entity.freezed.dart';
part 'book_search_entity.g.dart';

@freezed
abstract class BookSearchEntity with _$BookSearchEntity {
  const factory BookSearchEntity({
    @Default('') String title,
    @Default('') String author,
    @Default('') String description,
    @Default('') String isbn13,
    @Default('') String cover,
    @Default('') String publisher,
  }) = _BookSearchEntity;

  factory BookSearchEntity.fromJson(Map<String, dynamic> json) =>
      _$BookSearchEntityFromJson(json);
}
