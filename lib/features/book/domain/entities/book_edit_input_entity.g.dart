// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_edit_input_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookEditInputEntity _$BookEditInputEntityFromJson(Map<String, dynamic> json) =>
    _BookEditInputEntity(
      bookNo: (json['book_no'] as num).toInt(),
      bookTitle: json['book_title'] as String,
      bookAuthor: json['book_author'] as String,
      bookImageUrl: json['book_image_url'] as String?,
    );

Map<String, dynamic> _$BookEditInputEntityToJson(
  _BookEditInputEntity instance,
) => <String, dynamic>{
  'book_no': instance.bookNo,
  'book_title': instance.bookTitle,
  'book_author': instance.bookAuthor,
  'book_image_url': instance.bookImageUrl,
};
