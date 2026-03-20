class BookMemoSummaryEntity {
  const BookMemoSummaryEntity({
    required this.id,
    required this.memoContent,
    required this.memoCreatedAt,
    required this.memoLike,
    required this.imageUrl,
  });

  final int id;
  final String memoContent;
  final String memoCreatedAt;
  final bool memoLike;
  final String? imageUrl;

  Map<String, dynamic> toRoutePayload({
    required int bookNo,
    required String bookTitle,
    required String bookAuthor,
    required String? bookImageUrl,
  }) {
    return {
      'id': id,
      'memo_content': memoContent,
      'memo_created_at': memoCreatedAt,
      'memo_like': memoLike,
      'image_url': imageUrl,
      'book_no': bookNo,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_image_url': bookImageUrl,
    };
  }
}

