class BookReadInputEntity {
  const BookReadInputEntity({
    required this.bookNo,
    required this.bookTitle,
    required this.bookTree,
    required this.bookPage,
    required this.bookCurrentPage,
    required this.bookReadList,
  });

  final int bookNo;
  final String bookTitle;
  final String bookTree;
  final int bookPage;
  final int bookCurrentPage;
  final List<Map<String, dynamic>> bookReadList;

  factory BookReadInputEntity.fromMap(Map map) {
    return BookReadInputEntity(
      bookNo: map['book_no'] as int? ?? 0,
      bookTitle: map['book_title'] as String? ?? '',
      bookTree: map['book_tree'] as String? ?? '',
      bookPage: map['book_page'] as int? ?? 0,
      bookCurrentPage: map['book_current_page'] as int? ?? 0,
      bookReadList: (map['book_read_list'] as List? ?? [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'book_no': bookNo,
      'book_title': bookTitle,
      'book_tree': bookTree,
      'book_page': bookPage,
      'book_current_page': bookCurrentPage,
      'book_read_list': bookReadList,
    };
  }
}

