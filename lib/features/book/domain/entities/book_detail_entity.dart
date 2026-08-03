import 'package:freezed_annotation/freezed_annotation.dart';

import 'book_memo_summary_entity.dart';
import 'book_read_history_entity.dart';

part 'book_detail_entity.freezed.dart';
part 'book_detail_entity.g.dart';

@freezed
abstract class BookDetailEntity with _$BookDetailEntity {
  const BookDetailEntity._();

  const factory BookDetailEntity({
    int? bookNo,
    int? userNo,
    int? gardenNo,
    @Default('') String gardenTitle,
    @Default('') String gardenColor,
    @Default(0) int bookStatus,
    @Default(0) int bookRating,
    @Default('') String bookTitle,
    @Default('') String bookAuthor,
    @Default('') String bookPublisher,
    @Default('') String bookInfo,
    String? bookImageUrl,
    @Default('') String bookTree,
    @Default(0) int bookCurrentPage,
    @Default(0) int bookPage,
    @Default([]) List<BookReadHistoryEntity> bookReadList,
    @Default([]) List<BookMemoSummaryEntity> memoList,
  }) = _BookDetailEntity;

  factory BookDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$BookDetailEntityFromJson(json);

  // NOTE: The previous manual copyWith had a `clearBookImageUrl` parameter.
  // With freezed, use copyWith(bookImageUrl: null) directly since the field is nullable.

  static final empty = BookDetailEntity(
    bookNo: null,
    userNo: null,
    gardenNo: null,
    gardenTitle: '',
    gardenColor: '',
    bookStatus: 0,
    bookRating: 0,
    bookTitle: '',
    bookAuthor: '',
    bookPublisher: '',
    bookInfo: '',
    bookImageUrl: null,
    bookTree: '',
    bookCurrentPage: 0,
    bookPage: 0,
    bookReadList: [],
    memoList: [],
  );

  bool get hasGardenColor => gardenColor.isNotEmpty;

  Map<String, dynamic> toBookAddPayload() {
    return {
      'book_no': bookNo,
      'user_no': userNo,
      'garden_no': gardenNo,
      'garden_title': gardenTitle,
      'garden_color': gardenColor,
      'book_status': bookStatus,
      'book_rating': bookRating,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_publisher': bookPublisher,
      'book_info': bookInfo,
      'book_image_url': bookImageUrl,
      'book_tree': bookTree,
      'book_current_page': bookCurrentPage,
      'book_page': bookPage,
      'book_read_list': bookReadList
          .map((item) => {
                'book_current_page': item.bookCurrentPage,
                'book_created_at': item.bookCreatedAt,
                'book_start_date': item.bookStartDate,
                'book_end_date': item.bookEndDate,
              })
          .toList(),
      'memo_list': memoList
          .map((item) => {
                'id': item.id,
                'memo_content': item.memoContent,
                'memo_created_at': item.memoCreatedAt,
                'memo_like': item.memoLike,
                'image_url': item.imageUrl,
              })
          .toList(),
    };
  }
}
