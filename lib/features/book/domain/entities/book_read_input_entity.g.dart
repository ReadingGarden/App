// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_read_input_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookReadInputEntity _$BookReadInputEntityFromJson(Map<String, dynamic> json) =>
    _BookReadInputEntity(
      bookNo: (json['book_no'] as num).toInt(),
      bookTitle: json['book_title'] as String,
      bookTree: json['book_tree'] as String,
      bookPage: (json['book_page'] as num).toInt(),
      bookCurrentPage: (json['book_current_page'] as num).toInt(),
      bookReadList: (json['book_read_list'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$BookReadInputEntityToJson(
  _BookReadInputEntity instance,
) => <String, dynamic>{
  'book_no': instance.bookNo,
  'book_title': instance.bookTitle,
  'book_tree': instance.bookTree,
  'book_page': instance.bookPage,
  'book_current_page': instance.bookCurrentPage,
  'book_read_list': instance.bookReadList,
};
