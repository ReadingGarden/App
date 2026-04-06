// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_member_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GardenMemberEntity _$GardenMemberEntityFromJson(Map<String, dynamic> json) =>
    _GardenMemberEntity(
      userNo: (json['user_no'] as num?)?.toInt() ?? 0,
      userNick: json['user_nick'] as String? ?? '',
      userImage: json['user_image'] as String? ?? '',
      gardenLeader: json['garden_leader'] as bool? ?? false,
    );

Map<String, dynamic> _$GardenMemberEntityToJson(_GardenMemberEntity instance) =>
    <String, dynamic>{
      'user_no': instance.userNo,
      'user_nick': instance.userNick,
      'user_image': instance.userImage,
      'garden_leader': instance.gardenLeader,
    };
