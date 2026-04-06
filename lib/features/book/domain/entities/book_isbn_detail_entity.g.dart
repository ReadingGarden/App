// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_isbn_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookIsbnDetailEntity _$BookIsbnDetailEntityFromJson(
  Map<String, dynamic> json,
) => _BookIsbnDetailEntity(
  title: json['title'] as String,
  author: json['author'] as String,
  description: json['description'] as String,
  isbn13: json['isbn13'] as String,
  cover: json['cover'] as String?,
  publisher: json['publisher'] as String,
  itemPage: (json['itemPage'] as num).toInt(),
  bookNo: (json['book_no'] as num?)?.toInt(),
);

Map<String, dynamic> _$BookIsbnDetailEntityToJson(
  _BookIsbnDetailEntity instance,
) => <String, dynamic>{
  'title': instance.title,
  'author': instance.author,
  'description': instance.description,
  'isbn13': instance.isbn13,
  'cover': instance.cover,
  'publisher': instance.publisher,
  'itemPage': instance.itemPage,
  'book_no': instance.bookNo,
};
