class MemoWriteInputEntity {
  const MemoWriteInputEntity({
    required this.bookNo,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImageUrl,
    required this.memoContent,
    required this.imageUrl,
    required this.gardenNo,
    this.id,
  });

  final int? id;
  final int bookNo;
  final String bookTitle;
  final String bookAuthor;
  final String? bookImageUrl;
  final String memoContent;
  final String? imageUrl;
  final int? gardenNo;

  bool get isEdit => id != null;

  factory MemoWriteInputEntity.fromMap(Map<String, dynamic> map) {
    return MemoWriteInputEntity(
      id: map['id'] as int?,
      bookNo: map['book_no'] as int? ?? 0,
      bookTitle: map['book_title'] as String? ?? '',
      bookAuthor: map['book_author'] as String? ?? '',
      bookImageUrl: map['book_image_url'] as String?,
      memoContent: map['memo_content'] as String? ?? '',
      imageUrl: map['image_url'] as String?,
      gardenNo: map['garden_no'] as int?,
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
      'image_url': imageUrl,
      'garden_no': gardenNo,
    };
  }

  Map<String, dynamic> toRequestMap(String content) {
    return {
      'book_no': bookNo,
      'memo_content': content,
    };
  }
}
