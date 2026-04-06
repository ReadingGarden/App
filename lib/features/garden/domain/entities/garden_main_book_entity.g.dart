// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_main_book_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GardenMainBookEntity _$GardenMainBookEntityFromJson(
  Map<String, dynamic> json,
) => _GardenMainBookEntity(
  bookNo: (json['book_no'] as num?)?.toInt() ?? 0,
  bookTitle: json['book_title'] as String? ?? '',
  bookAuthor: json['book_author'] as String? ?? '',
  bookImageUrl: json['book_image_url'] as String? ?? '',
  bookTree: json['book_tree'] as String? ?? '',
  percent: (json['percent'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$GardenMainBookEntityToJson(
  _GardenMainBookEntity instance,
) => <String, dynamic>{
  'book_no': instance.bookNo,
  'book_title': instance.bookTitle,
  'book_author': instance.bookAuthor,
  'book_image_url': instance.bookImageUrl,
  'book_tree': instance.bookTree,
  'percent': instance.percent,
};
