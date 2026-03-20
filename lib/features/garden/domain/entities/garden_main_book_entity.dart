class GardenMainBookEntity {
  const GardenMainBookEntity({
    required this.bookNo,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImageUrl,
    required this.bookTree,
    required this.percent,
  });

  final int bookNo;
  final String bookTitle;
  final String bookAuthor;
  final String bookImageUrl;
  final String bookTree;
  final double percent;

  factory GardenMainBookEntity.fromMap(Map<String, dynamic> map) {
    return GardenMainBookEntity(
      bookNo: map['book_no'] as int? ?? 0,
      bookTitle: map['book_title'] as String? ?? '',
      bookAuthor: map['book_author'] as String? ?? '',
      bookImageUrl: map['book_image_url'] as String? ?? '',
      bookTree: map['book_tree'] as String? ?? '',
      percent: (map['percent'] as num?)?.toDouble() ?? 0,
    );
  }
}
