// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_write_input_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemoWriteInputEntity _$MemoWriteInputEntityFromJson(
  Map<String, dynamic> json,
) => _MemoWriteInputEntity(
  bookNo: (json['book_no'] as num?)?.toInt() ?? 0,
  bookTitle: json['book_title'] as String? ?? '',
  bookAuthor: json['book_author'] as String? ?? '',
  bookImageUrl: json['book_image_url'] as String?,
  memoContent: json['memo_content'] as String? ?? '',
  imageUrl: json['image_url'] as String?,
  gardenNo: (json['garden_no'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MemoWriteInputEntityToJson(
  _MemoWriteInputEntity instance,
) => <String, dynamic>{
  'book_no': instance.bookNo,
  'book_title': instance.bookTitle,
  'book_author': instance.bookAuthor,
  'book_image_url': instance.bookImageUrl,
  'memo_content': instance.memoContent,
  'image_url': instance.imageUrl,
  'garden_no': instance.gardenNo,
  'id': instance.id,
};
