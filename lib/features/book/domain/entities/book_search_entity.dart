class BookSearchEntity {
  const BookSearchEntity({
    required this.title,
    required this.author,
    required this.description,
    required this.isbn13,
    required this.cover,
    required this.publisher,
  });

  final String title;
  final String author;
  final String description;
  final String isbn13;
  final String cover;
  final String publisher;
}

