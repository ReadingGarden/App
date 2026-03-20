class GardenSummaryEntity {
  const GardenSummaryEntity({
    required this.gardenNo,
    required this.gardenTitle,
    required this.gardenInfo,
    required this.gardenColor,
    required this.bookCount,
  });

  final int gardenNo;
  final String gardenTitle;
  final String gardenInfo;
  final String gardenColor;
  final int bookCount;

  factory GardenSummaryEntity.fromMap(Map<String, dynamic> map) {
    return GardenSummaryEntity(
      gardenNo: map['garden_no'] as int? ?? 0,
      gardenTitle: map['garden_title'] as String? ?? '',
      gardenInfo: map['garden_info'] as String? ?? '',
      gardenColor: map['garden_color'] as String? ?? '',
      bookCount: map['book_count'] as int? ?? 0,
    );
  }
}

