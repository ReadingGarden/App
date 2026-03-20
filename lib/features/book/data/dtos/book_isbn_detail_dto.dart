import '../../domain/entities/book_isbn_detail_entity.dart';

class BookIsbnDetailDto {
  const BookIsbnDetailDto(this.json);

  final Map<String, dynamic> json;

  BookIsbnDetailEntity toEntity() {
    return BookIsbnDetailEntity(
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isbn13: json['isbn13'] as String? ?? '',
      cover: json['cover'] as String?,
      publisher: json['publisher'] as String? ?? '',
      itemPage: json['itemPage'] as int? ?? 0,
      bookNo: json['book_no'] as int?,
    );
  }
}

