import 'package:freezed_annotation/freezed_annotation.dart';

part 'garden_member_entity.freezed.dart';
part 'garden_member_entity.g.dart';

@freezed
abstract class GardenMemberEntity with _$GardenMemberEntity {
  const factory GardenMemberEntity({
    @Default(0) int userNo,
    @Default('') String userNick,
    @Default('') String userImage,
    @Default(false) bool gardenLeader,
  }) = _GardenMemberEntity;

  factory GardenMemberEntity.fromJson(Map<String, dynamic> json) =>
      _$GardenMemberEntityFromJson(json);
}
