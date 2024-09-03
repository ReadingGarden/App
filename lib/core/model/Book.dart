class Book {
  final int book_no;
  final String book_title;
  final String book_author;
  final String book_publisher;
  final String? book_image_url;
  final String? book_tree;
  final int book_status;
  final double percent;
  final int book_page;
  final int? garden_no;

  Book(
      {required this.book_no,
      required this.book_title,
      required this.book_author,
      required this.book_publisher,
      required this.book_image_url,
      required this.book_tree,
      required this.book_status,
      required this.percent,
      required this.book_page,
      required this.garden_no});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        book_no: json['book_no'],
        book_title: json['book_title'],
        book_author: json['book_author'],
        book_publisher: json['book_publisher'],
        book_image_url: json['book_image_url'],
        book_tree: json['book_tree'],
        book_status: json['book_status'],
        percent: json['percent'],
        book_page: json['book_page'],
        garden_no: json['garden_no']);
  }

  Map<String, dynamic> toJson() {
    return {
      'book_no': book_no,
      'book_title': book_title,
      'book_author': book_author,
      'book_publisher': book_publisher,
      'book_image_url': book_image_url,
      'book_tree': book_tree,
      'book_status': book_status,
      'percent': percent,
      'book_page': book_page,
      'garden_no': garden_no
    };
  }
}
