class BookDetailEntity {
  const BookDetailEntity({
    required this.bookNo,
    required this.userNo,
    required this.gardenNo,
    required this.gardenTitle,
    required this.gardenColor,
    required this.bookStatus,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookPublisher,
    required this.bookInfo,
    required this.bookImageUrl,
    required this.bookTree,
    required this.bookCurrentPage,
    required this.bookPage,
    required this.bookReadList,
    required this.memoList,
  });

  final int? bookNo;
  final int? userNo;
  final int? gardenNo;
  final String gardenTitle;
  final String gardenColor;
  final int bookStatus;
  final String bookTitle;
  final String bookAuthor;
  final String bookPublisher;
  final String bookInfo;
  final String? bookImageUrl;
  final String bookTree;
  final int bookCurrentPage;
  final int bookPage;
  final List<Map<String, dynamic>> bookReadList;
  final List<Map<String, dynamic>> memoList;

  static const empty = BookDetailEntity(
    bookNo: null,
    userNo: null,
    gardenNo: null,
    gardenTitle: '',
    gardenColor: '',
    bookStatus: 0,
    bookTitle: '',
    bookAuthor: '',
    bookPublisher: '',
    bookInfo: '',
    bookImageUrl: null,
    bookTree: '',
    bookCurrentPage: 0,
    bookPage: 0,
    bookReadList: [],
    memoList: [],
  );

  bool get hasGardenColor => gardenColor.isNotEmpty;

  BookDetailEntity copyWith({
    int? bookNo,
    int? userNo,
    int? gardenNo,
    String? gardenTitle,
    String? gardenColor,
    int? bookStatus,
    String? bookTitle,
    String? bookAuthor,
    String? bookPublisher,
    String? bookInfo,
    String? bookImageUrl,
    bool clearBookImageUrl = false,
    String? bookTree,
    int? bookCurrentPage,
    int? bookPage,
    List<Map<String, dynamic>>? bookReadList,
    List<Map<String, dynamic>>? memoList,
  }) {
    return BookDetailEntity(
      bookNo: bookNo ?? this.bookNo,
      userNo: userNo ?? this.userNo,
      gardenNo: gardenNo ?? this.gardenNo,
      gardenTitle: gardenTitle ?? this.gardenTitle,
      gardenColor: gardenColor ?? this.gardenColor,
      bookStatus: bookStatus ?? this.bookStatus,
      bookTitle: bookTitle ?? this.bookTitle,
      bookAuthor: bookAuthor ?? this.bookAuthor,
      bookPublisher: bookPublisher ?? this.bookPublisher,
      bookInfo: bookInfo ?? this.bookInfo,
      bookImageUrl:
          clearBookImageUrl ? null : (bookImageUrl ?? this.bookImageUrl),
      bookTree: bookTree ?? this.bookTree,
      bookCurrentPage: bookCurrentPage ?? this.bookCurrentPage,
      bookPage: bookPage ?? this.bookPage,
      bookReadList: bookReadList ?? this.bookReadList,
      memoList: memoList ?? this.memoList,
    );
  }

  Map<String, dynamic> toBookAddPayload() {
    return {
      'book_no': bookNo,
      'user_no': userNo,
      'garden_no': gardenNo,
      'garden_title': gardenTitle,
      'garden_color': gardenColor,
      'book_status': bookStatus,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_publisher': bookPublisher,
      'book_info': bookInfo,
      'book_image_url': bookImageUrl,
      'book_tree': bookTree,
      'book_current_page': bookCurrentPage,
      'book_page': bookPage,
      'book_read_list': bookReadList,
      'memo_list': memoList,
    };
  }
}

