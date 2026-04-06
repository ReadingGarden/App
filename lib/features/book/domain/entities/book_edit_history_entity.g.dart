// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_edit_history_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookEditHistoryEntity _$BookEditHistoryEntityFromJson(
  Map<String, dynamic> json,
) => _BookEditHistoryEntity(
  id: (json['id'] as num).toInt(),
  bookStartDate: json['book_start_date'] as String?,
  bookEndDate: json['book_end_date'] as String?,
);

Map<String, dynamic> _$BookEditHistoryEntityToJson(
  _BookEditHistoryEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'book_start_date': instance.bookStartDate,
  'book_end_date': instance.bookEndDate,
};
