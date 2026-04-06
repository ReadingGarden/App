// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_book_selector_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemoBookSelectorEntity _$MemoBookSelectorEntityFromJson(
  Map<String, dynamic> json,
) => _MemoBookSelectorEntity(
  bookNo: (json['book_no'] as num).toInt(),
  bookTitle: json['book_title'] as String,
  bookAuthor: json['book_author'] as String,
  bookImageUrl: json['book_image_url'] as String?,
  gardenNo: (json['garden_no'] as num?)?.toInt(),
);

Map<String, dynamic> _$MemoBookSelectorEntityToJson(
  _MemoBookSelectorEntity instance,
) => <String, dynamic>{
  'book_no': instance.bookNo,
  'book_title': instance.bookTitle,
  'book_author': instance.bookAuthor,
  'book_image_url': instance.bookImageUrl,
  'garden_no': instance.gardenNo,
};
