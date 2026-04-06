// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_list_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemoListItemEntity _$MemoListItemEntityFromJson(Map<String, dynamic> json) =>
    _MemoListItemEntity(
      id: (json['id'] as num?)?.toInt() ?? 0,
      bookNo: (json['book_no'] as num?)?.toInt() ?? 0,
      bookTitle: json['book_title'] as String? ?? '',
      bookAuthor: json['book_author'] as String? ?? '',
      bookImageUrl: json['book_image_url'] as String?,
      memoContent: json['memo_content'] as String? ?? '',
      memoLike: json['memo_like'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
      memoCreatedAt: json['memo_created_at'] as String? ?? '',
    );

Map<String, dynamic> _$MemoListItemEntityToJson(_MemoListItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book_no': instance.bookNo,
      'book_title': instance.bookTitle,
      'book_author': instance.bookAuthor,
      'book_image_url': instance.bookImageUrl,
      'memo_content': instance.memoContent,
      'memo_like': instance.memoLike,
      'image_url': instance.imageUrl,
      'memo_created_at': instance.memoCreatedAt,
    };
