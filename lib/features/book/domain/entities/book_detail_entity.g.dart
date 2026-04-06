// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookDetailEntity _$BookDetailEntityFromJson(Map<String, dynamic> json) =>
    _BookDetailEntity(
      bookNo: (json['book_no'] as num?)?.toInt(),
      userNo: (json['user_no'] as num?)?.toInt(),
      gardenNo: (json['garden_no'] as num?)?.toInt(),
      gardenTitle: json['garden_title'] as String? ?? '',
      gardenColor: json['garden_color'] as String? ?? '',
      bookStatus: (json['book_status'] as num?)?.toInt() ?? 0,
      bookTitle: json['book_title'] as String? ?? '',
      bookAuthor: json['book_author'] as String? ?? '',
      bookPublisher: json['book_publisher'] as String? ?? '',
      bookInfo: json['book_info'] as String? ?? '',
      bookImageUrl: json['book_image_url'] as String?,
      bookTree: json['book_tree'] as String? ?? '',
      bookCurrentPage: (json['book_current_page'] as num?)?.toInt() ?? 0,
      bookPage: (json['book_page'] as num?)?.toInt() ?? 0,
      bookReadList:
          (json['book_read_list'] as List<dynamic>?)
              ?.map(
                (e) =>
                    BookReadHistoryEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      memoList:
          (json['memo_list'] as List<dynamic>?)
              ?.map(
                (e) =>
                    BookMemoSummaryEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BookDetailEntityToJson(_BookDetailEntity instance) =>
    <String, dynamic>{
      'book_no': instance.bookNo,
      'user_no': instance.userNo,
      'garden_no': instance.gardenNo,
      'garden_title': instance.gardenTitle,
      'garden_color': instance.gardenColor,
      'book_status': instance.bookStatus,
      'book_title': instance.bookTitle,
      'book_author': instance.bookAuthor,
      'book_publisher': instance.bookPublisher,
      'book_info': instance.bookInfo,
      'book_image_url': instance.bookImageUrl,
      'book_tree': instance.bookTree,
      'book_current_page': instance.bookCurrentPage,
      'book_page': instance.bookPage,
      'book_read_list': instance.bookReadList,
      'memo_list': instance.memoList,
    };
