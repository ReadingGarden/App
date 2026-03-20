import 'garden_main_book_entity.dart';

class GardenMainEntity {
  const GardenMainEntity({
    required this.gardenNo,
    required this.gardenTitle,
    required this.gardenInfo,
    required this.gardenColor,
    required this.bookList,
    required this.gardenMembers,
    required this.raw,
  });

  final int gardenNo;
  final String gardenTitle;
  final String gardenInfo;
  final String gardenColor;
  final List<GardenMainBookEntity> bookList;
  final List<Map<String, dynamic>> gardenMembers;
  final Map<String, dynamic> raw;

  static const empty = GardenMainEntity(
    gardenNo: 0,
    gardenTitle: '',
    gardenInfo: '',
    gardenColor: '',
    bookList: [],
    gardenMembers: [],
    raw: {},
  );

  bool get isEmpty => gardenNo == 0;

  factory GardenMainEntity.fromMap(Map<String, dynamic> map) {
    return GardenMainEntity(
      gardenNo: map['garden_no'] as int? ?? 0,
      gardenTitle: map['garden_title'] as String? ?? '',
      gardenInfo: map['garden_info'] as String? ?? '',
      gardenColor: map['garden_color'] as String? ?? '',
      bookList: (map['book_list'] as List? ?? [])
          .map((item) => GardenMainBookEntity.fromMap(
              Map<String, dynamic>.from(item as Map)))
          .toList(),
      gardenMembers: (map['garden_members'] as List? ?? [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
      raw: map,
    );
  }
}

