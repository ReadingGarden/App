// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_main_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GardenMainEntity _$GardenMainEntityFromJson(
  Map<String, dynamic> json,
) => _GardenMainEntity(
  gardenNo: (json['garden_no'] as num?)?.toInt() ?? 0,
  gardenTitle: json['garden_title'] as String? ?? '',
  gardenInfo: json['garden_info'] as String? ?? '',
  gardenColor: json['garden_color'] as String? ?? '',
  bookList:
      (json['book_list'] as List<dynamic>?)
          ?.map((e) => GardenMainBookEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  gardenMembers:
      (json['garden_members'] as List<dynamic>?)
          ?.map((e) => GardenMemberEntity.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GardenMainEntityToJson(_GardenMainEntity instance) =>
    <String, dynamic>{
      'garden_no': instance.gardenNo,
      'garden_title': instance.gardenTitle,
      'garden_info': instance.gardenInfo,
      'garden_color': instance.gardenColor,
      'book_list': instance.bookList,
      'garden_members': instance.gardenMembers,
    };
