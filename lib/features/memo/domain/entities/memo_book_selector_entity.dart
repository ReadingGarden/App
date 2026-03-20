class MemoBookSelectorEntity {
  const MemoBookSelectorEntity({
    required this.bookNo,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImageUrl,
    required this.gardenNo,
  });

  final int bookNo;
  final String bookTitle;
  final String bookAuthor;
  final String? bookImageUrl;
  final int? gardenNo;

  factory MemoBookSelectorEntity.fromMap(Map<String, dynamic> map) {
    return MemoBookSelectorEntity(
      bookNo: map['book_no'] as int? ?? 0,
      bookTitle: map['book_title'] as String? ?? '',
      bookAuthor: map['book_author'] as String? ?? '',
      bookImageUrl: map['book_image_url'] as String?,
      gardenNo: map['garden_no'] as int?,
    );
  }

  Map<String, dynamic> toMemoWriteMap() {
    return {
      'book_no': bookNo,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_image_url': bookImageUrl,
      'garden_no': gardenNo,
    };
  }
}
