class BookshelfBookEntity {
  const BookshelfBookEntity({
    required this.bookNo,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookPublisher,
    required this.bookInfo,
    required this.bookImageUrl,
    required this.bookTree,
    required this.bookStatus,
    required this.percent,
    required this.bookPage,
    required this.gardenNo,
  });

  final int bookNo;
  final String bookTitle;
  final String bookAuthor;
  final String bookPublisher;
  final String bookInfo;
  final String? bookImageUrl;
  final String? bookTree;
  final int bookStatus;
  final double percent;
  final int bookPage;
  final int? gardenNo;

  factory BookshelfBookEntity.fromMap(Map<String, dynamic> map) {
    return BookshelfBookEntity(
      bookNo: map['book_no'] as int? ?? 0,
      bookTitle: map['book_title'] as String? ?? '',
      bookAuthor: map['book_author'] as String? ?? '',
      bookPublisher: map['book_publisher'] as String? ?? '',
      bookInfo: map['book_info'] as String? ?? '',
      bookImageUrl: map['book_image_url'] as String?,
      bookTree: map['book_tree'] as String?,
      bookStatus: map['book_status'] as int? ?? 0,
      percent: (map['percent'] as num?)?.toDouble() ?? 0,
      bookPage: map['book_page'] as int? ?? 0,
      gardenNo: map['garden_no'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'book_no': bookNo,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_publisher': bookPublisher,
      'book_info': bookInfo,
      'book_image_url': bookImageUrl,
      'book_tree': bookTree,
      'book_status': bookStatus,
      'percent': percent,
      'book_page': bookPage,
      'garden_no': gardenNo,
    };
  }
}
