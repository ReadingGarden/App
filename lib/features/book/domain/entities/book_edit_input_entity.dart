class BookEditInputEntity {
  const BookEditInputEntity({
    required this.bookNo,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImageUrl,
  });

  final int bookNo;
  final String bookTitle;
  final String bookAuthor;
  final String? bookImageUrl;

  factory BookEditInputEntity.fromMap(Map map) {
    return BookEditInputEntity(
      bookNo: map['book_no'] as int? ?? 0,
      bookTitle: map['book_title'] as String? ?? '',
      bookAuthor: map['book_author'] as String? ?? '',
      bookImageUrl: map['book_image_url'] as String?,
    );
  }
}

