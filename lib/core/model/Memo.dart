class Memo {
  final int id;
  final int book_no;
  final String book_title;
  final String book_author;
  final String? book_image_url;
  final String memo_content;
  final bool memo_like;
  final String? image_url;
  final String memo_created_at;

  Memo(
      {required this.id,
      required this.book_no,
      required this.book_title,
      required this.book_author,
      required this.book_image_url,
      required this.memo_content,
      required this.memo_like,
      required this.image_url,
      required this.memo_created_at});

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
        id: json['id'],
        book_no: json['book_no'],
        book_title: json['book_title'],
        book_author: json['book_author'],
        book_image_url: json['book_image_url'],
        memo_content: json['memo_content'],
        memo_like: json['memo_like'],
        image_url: json['image_url'],
        memo_created_at: json['memo_created_at']);
  }
}
