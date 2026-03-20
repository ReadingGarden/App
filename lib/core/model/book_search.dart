class BookSearch {
  final String title;
  final String author;
  final String description;
  final String isbn13;
  final String cover;
  final String publisher;

  BookSearch(
      {required this.title,
      required this.author,
      required this.description,
      required this.isbn13,
      required this.cover,
      required this.publisher});

  factory BookSearch.fromJson(Map<String, dynamic> json) {
    return BookSearch(
        title: json['title'],
        author: json['author'],
        description: json['description'],
        isbn13: json['isbn13'],
        cover: json['cover'],
        publisher: json['publisher']);
  }
}
