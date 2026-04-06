import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_isbn_detail_entity.freezed.dart';
part 'book_isbn_detail_entity.g.dart';

@freezed
abstract class BookIsbnDetailEntity with _$BookIsbnDetailEntity {
  const BookIsbnDetailEntity._();

  const factory BookIsbnDetailEntity({
    required String title,
    required String author,
    required String description,
    required String isbn13,
    required String? cover,
    required String publisher,
    @JsonKey(name: 'itemPage') required int itemPage,
    int? bookNo,
  }) = _BookIsbnDetailEntity;

  factory BookIsbnDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$BookIsbnDetailEntityFromJson(json);

  static final empty = BookIsbnDetailEntity(
    title: '',
    author: '',
    description: '',
    isbn13: '',
    cover: null,
    publisher: '',
    itemPage: 0,
  );

  bool get isEmpty => title.isEmpty && author.isEmpty && isbn13.isEmpty;

  Map<String, dynamic> toRegisterPayload() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'isbn13': isbn13,
      'cover': cover,
      'publisher': publisher,
      'itemPage': itemPage,
      'book_no': bookNo,
    };
  }
}
