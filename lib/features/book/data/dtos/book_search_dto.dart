import '../../domain/entities/book_search_entity.dart';

class BookSearchDto {
  const BookSearchDto(this.json);

  final Map<String, dynamic> json;

  BookSearchEntity toEntity() {
    return BookSearchEntity(
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isbn13: json['isbn13'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      publisher: json['publisher'] as String? ?? '',
    );
  }
}
