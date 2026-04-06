// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_memo_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookMemoSummaryEntity _$BookMemoSummaryEntityFromJson(
  Map<String, dynamic> json,
) => _BookMemoSummaryEntity(
  id: (json['id'] as num?)?.toInt() ?? 0,
  memoContent: json['memo_content'] as String? ?? '',
  memoCreatedAt: json['memo_created_at'] as String? ?? '',
  memoLike: json['memo_like'] as bool? ?? false,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$BookMemoSummaryEntityToJson(
  _BookMemoSummaryEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'memo_content': instance.memoContent,
  'memo_created_at': instance.memoCreatedAt,
  'memo_like': instance.memoLike,
  'image_url': instance.imageUrl,
};
