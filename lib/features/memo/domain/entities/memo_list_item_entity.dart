class MemoListItemEntity {
  const MemoListItemEntity({
    required this.id,
    required this.bookNo,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImageUrl,
    required this.memoContent,
    required this.memoLike,
    required this.imageUrl,
    required this.memoCreatedAt,
  });

  final int id;
  final int bookNo;
  final String bookTitle;
  final String bookAuthor;
  final String? bookImageUrl;
  final String memoContent;
  final bool memoLike;
  final String? imageUrl;
  final String memoCreatedAt;

  factory MemoListItemEntity.fromMap(Map<String, dynamic> map) {
    return MemoListItemEntity(
      id: map['id'] as int? ?? 0,
      bookNo: map['book_no'] as int? ?? 0,
      bookTitle: map['book_title'] as String? ?? '',
      bookAuthor: map['book_author'] as String? ?? '',
      bookImageUrl: map['book_image_url'] as String?,
      memoContent: map['memo_content'] as String? ?? '',
      memoLike: map['memo_like'] as bool? ?? false,
      imageUrl: map['image_url'] as String?,
      memoCreatedAt: map['memo_created_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_no': bookNo,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_image_url': bookImageUrl,
      'memo_content': memoContent,
      'memo_like': memoLike,
      'image_url': imageUrl,
      'memo_created_at': memoCreatedAt,
    };
  }

  MemoListItemEntity copyWith({
    bool? memoLike,
  }) {
    return MemoListItemEntity(
      id: id,
      bookNo: bookNo,
      bookTitle: bookTitle,
      bookAuthor: bookAuthor,
      bookImageUrl: bookImageUrl,
      memoContent: memoContent,
      memoLike: memoLike ?? this.memoLike,
      imageUrl: imageUrl,
      memoCreatedAt: memoCreatedAt,
    );
  }
}
