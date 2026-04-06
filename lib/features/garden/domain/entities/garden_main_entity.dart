import 'package:freezed_annotation/freezed_annotation.dart';

import 'garden_main_book_entity.dart';
import 'garden_member_entity.dart';

part 'garden_main_entity.freezed.dart';
part 'garden_main_entity.g.dart';

@freezed
abstract class GardenMainEntity with _$GardenMainEntity {
  const GardenMainEntity._();

  const factory GardenMainEntity({
    @Default(0) int gardenNo,
    @Default('') String gardenTitle,
    @Default('') String gardenInfo,
    @Default('') String gardenColor,
    @Default([]) List<GardenMainBookEntity> bookList,
    @Default([]) List<GardenMemberEntity> gardenMembers,
  }) = _GardenMainEntity;

  factory GardenMainEntity.fromJson(Map<String, dynamic> json) =>
      _$GardenMainEntityFromJson(json);

  static final empty = GardenMainEntity();

  bool get isEmpty => gardenNo == 0;
}
