class BookReadHistoryEntity {
  const BookReadHistoryEntity({
    required this.bookCurrentPage,
    required this.bookCreatedAt,
    required this.bookStartDate,
    required this.bookEndDate,
  });

  final int bookCurrentPage;
  final String? bookCreatedAt;
  final String? bookStartDate;
  final String? bookEndDate;
}

