import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_search_entity.freezed.dart';
part 'book_search_entity.g.dart';

@freezed
abstract class BookSearchEntity with _$BookSearchEntity {
  const factory BookSearchEntity({
    required String title,
    required String author,
    required String description,
    required String isbn13,
    required String cover,
    required String publisher,
  }) = _BookSearchEntity;

  factory BookSearchEntity.fromJson(Map<String, dynamic> json) =>
      _$BookSearchEntityFromJson(json);
}
