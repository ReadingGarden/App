// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GardenSummaryEntity _$GardenSummaryEntityFromJson(Map<String, dynamic> json) =>
    _GardenSummaryEntity(
      gardenNo: (json['garden_no'] as num?)?.toInt() ?? 0,
      gardenTitle: json['garden_title'] as String? ?? '',
      gardenInfo: json['garden_info'] as String? ?? '',
      gardenColor: json['garden_color'] as String? ?? '',
      bookCount: (json['book_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GardenSummaryEntityToJson(
  _GardenSummaryEntity instance,
) => <String, dynamic>{
  'garden_no': instance.gardenNo,
  'garden_title': instance.gardenTitle,
  'garden_info': instance.gardenInfo,
  'garden_color': instance.gardenColor,
  'book_count': instance.bookCount,
};
