class BookAddDoneEntity {
  const BookAddDoneEntity({
    required this.bookTitle,
    required this.bookTree,
    required this.bookStartDate,
    required this.bookEndDate,
  });

  final String bookTitle;
  final String bookTree;
  final String bookStartDate;
  final String bookEndDate;

  factory BookAddDoneEntity.fromMap(Map map) {
    return BookAddDoneEntity(
      bookTitle: map['book_title'] as String? ?? '',
      bookTree: map['book_tree'] as String? ?? '',
      bookStartDate: map['book_start_date'] as String? ?? '',
      bookEndDate: map['book_end_date'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'book_title': bookTitle,
      'book_tree': bookTree,
      'book_start_date': bookStartDate,
      'book_end_date': bookEndDate,
    };
  }
}

