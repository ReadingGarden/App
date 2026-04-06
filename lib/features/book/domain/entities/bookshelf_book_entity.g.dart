// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookshelf_book_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookshelfBookEntity _$BookshelfBookEntityFromJson(Map<String, dynamic> json) =>
    _BookshelfBookEntity(
      bookNo: (json['book_no'] as num).toInt(),
      bookTitle: json['book_title'] as String,
      bookAuthor: json['book_author'] as String,
      bookPublisher: json['book_publisher'] as String,
      bookInfo: json['book_info'] as String,
      bookImageUrl: json['book_image_url'] as String?,
      bookTree: json['book_tree'] as String?,
      bookStatus: (json['book_status'] as num).toInt(),
      percent: (json['percent'] as num).toDouble(),
      bookPage: (json['book_page'] as num).toInt(),
      gardenNo: (json['garden_no'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookshelfBookEntityToJson(
  _BookshelfBookEntity instance,
) => <String, dynamic>{
  'book_no': instance.bookNo,
  'book_title': instance.bookTitle,
  'book_author': instance.bookAuthor,
  'book_publisher': instance.bookPublisher,
  'book_info': instance.bookInfo,
  'book_image_url': instance.bookImageUrl,
  'book_tree': instance.bookTree,
  'book_status': instance.bookStatus,
  'percent': instance.percent,
  'book_page': instance.bookPage,
  'garden_no': instance.gardenNo,
};
