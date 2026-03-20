class BookEditHistoryEntity {
  const BookEditHistoryEntity({
    required this.id,
    required this.bookStartDate,
    required this.bookEndDate,
  });

  final int id;
  final String? bookStartDate;
  final String? bookEndDate;
}

