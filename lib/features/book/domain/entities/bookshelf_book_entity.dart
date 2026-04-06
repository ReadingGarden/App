import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookshelf_book_entity.freezed.dart';
part 'bookshelf_book_entity.g.dart';

@freezed
abstract class BookshelfBookEntity with _$BookshelfBookEntity {
  const factory BookshelfBookEntity({
    @Default(0) int bookNo,
    @Default('') String bookTitle,
    @Default('') String bookAuthor,
    @Default('') String bookPublisher,
    @Default('') String bookInfo,
    String? bookImageUrl,
    String? bookTree,
    @Default(0) int bookStatus,
    @Default(0) double percent,
    @Default(0) int bookPage,
    int? gardenNo,
  }) = _BookshelfBookEntity;

  factory BookshelfBookEntity.fromJson(Map<String, dynamic> json) =>
      _$BookshelfBookEntityFromJson(json);
}
