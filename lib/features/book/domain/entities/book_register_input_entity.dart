class BookRegisterInputEntity {
  const BookRegisterInputEntity({
    required this.title,
    required this.author,
    required this.description,
    required this.isbn13,
    required this.cover,
    required this.publisher,
    required this.itemPage,
    required this.bookNo,
  });

  final String title;
  final String author;
  final String description;
  final String isbn13;
  final String? cover;
  final String publisher;
  final int itemPage;
  final int? bookNo;

  factory BookRegisterInputEntity.fromMap(Map map) {
    return BookRegisterInputEntity(
      title: map['title'] as String? ?? '',
      author: map['author'] as String? ?? '',
      description: map['description'] as String? ?? '',
      isbn13: map['isbn13'] as String? ?? '',
      cover: map['cover'] as String?,
      publisher: map['publisher'] as String? ?? '',
      itemPage: map['itemPage'] as int? ?? map['page'] as int? ?? 0,
      bookNo: map['book_no'] as int?,
    );
  }
}

