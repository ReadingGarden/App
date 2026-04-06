// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_read_history_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookReadHistoryEntity _$BookReadHistoryEntityFromJson(
  Map<String, dynamic> json,
) => _BookReadHistoryEntity(
  bookCurrentPage: (json['book_current_page'] as num).toInt(),
  bookCreatedAt: json['book_created_at'] as String?,
  bookStartDate: json['book_start_date'] as String?,
  bookEndDate: json['book_end_date'] as String?,
);

Map<String, dynamic> _$BookReadHistoryEntityToJson(
  _BookReadHistoryEntity instance,
) => <String, dynamic>{
  'book_current_page': instance.bookCurrentPage,
  'book_created_at': instance.bookCreatedAt,
  'book_start_date': instance.bookStartDate,
  'book_end_date': instance.bookEndDate,
};
