class BookIsbnDetailEntity {
  const BookIsbnDetailEntity({
    required this.title,
    required this.author,
    required this.description,
    required this.isbn13,
    required this.cover,
    required this.publisher,
    required this.itemPage,
    this.bookNo,
  });

  final String title;
  final String author;
  final String description;
  final String isbn13;
  final String? cover;
  final String publisher;
  final int itemPage;
  final int? bookNo;

  static const empty = BookIsbnDetailEntity(
    title: '',
    author: '',
    description: '',
    isbn13: '',
    cover: null,
    publisher: '',
    itemPage: 0,
  );

  bool get isEmpty => title.isEmpty && author.isEmpty && isbn13.isEmpty;

  Map<String, dynamic> toRegisterPayload() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'isbn13': isbn13,
      'cover': cover,
      'publisher': publisher,
      'itemPage': itemPage,
      'book_no': bookNo,
    };
  }
}

