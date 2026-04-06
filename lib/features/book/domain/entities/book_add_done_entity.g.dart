// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_add_done_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookAddDoneEntity _$BookAddDoneEntityFromJson(Map<String, dynamic> json) =>
    _BookAddDoneEntity(
      bookTitle: json['book_title'] as String? ?? '',
      bookTree: json['book_tree'] as String? ?? '',
      bookStartDate: json['book_start_date'] as String? ?? '',
      bookEndDate: json['book_end_date'] as String? ?? '',
    );

Map<String, dynamic> _$BookAddDoneEntityToJson(_BookAddDoneEntity instance) =>
    <String, dynamic>{
      'book_title': instance.bookTitle,
      'book_tree': instance.bookTree,
      'book_start_date': instance.bookStartDate,
      'book_end_date': instance.bookEndDate,
    };
