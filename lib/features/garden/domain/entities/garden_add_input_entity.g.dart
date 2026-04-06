// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_add_input_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GardenAddInputEntity _$GardenAddInputEntityFromJson(
  Map<String, dynamic> json,
) => _GardenAddInputEntity(
  gardenTitle: json['garden_title'] as String? ?? '',
  gardenInfo: json['garden_info'] as String? ?? '',
  gardenColor: json['garden_color'] as String? ?? '',
);

Map<String, dynamic> _$GardenAddInputEntityToJson(
  _GardenAddInputEntity instance,
) => <String, dynamic>{
  'garden_title': instance.gardenTitle,
  'garden_info': instance.gardenInfo,
  'garden_color': instance.gardenColor,
};
