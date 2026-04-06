import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookshelf_book_entity.freezed.dart';
part 'bookshelf_book_entity.g.dart';

@freezed
abstract class BookshelfBookEntity with _$BookshelfBookEntity {
  const factory BookshelfBookEntity({
    required int bookNo,
    required String bookTitle,
    required String bookAuthor,
    required String bookPublisher,
    required String bookInfo,
    required String? bookImageUrl,
    required String? bookTree,
    required int bookStatus,
    required double percent,
    required int bookPage,
    required int? gardenNo,
  }) = _BookshelfBookEntity;

  factory BookshelfBookEntity.fromJson(Map<String, dynamic> json) =>
      _$BookshelfBookEntityFromJson(json);
}
