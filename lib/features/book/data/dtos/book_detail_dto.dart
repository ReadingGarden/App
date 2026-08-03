import '../../domain/entities/book_detail_entity.dart';
import '../../domain/entities/book_memo_summary_entity.dart';
import '../../domain/entities/book_read_history_entity.dart';

class BookDetailDto {
  BookDetailDto(this.json);

  final Map<String, dynamic> json;

  BookDetailEntity toEntity() {
    return BookDetailEntity(
      bookNo: json['book_no'] as int?,
      userNo: json['user_no'] as int?,
      gardenNo: json['garden_no'] as int?,
      gardenTitle: json['garden_title'] as String? ?? '',
      gardenColor: json['garden_color'] as String? ?? '',
      bookStatus: json['book_status'] as int? ?? 0,
      bookRating: json['book_rating'] as int? ?? 0,
      bookTitle: json['book_title'] as String? ?? '',
      bookAuthor: json['book_author'] as String? ?? '',
      bookPublisher: json['book_publisher'] as String? ?? '',
      bookInfo: json['book_info'] as String? ?? '',
      bookImageUrl: json['book_image_url'] as String?,
      bookTree: json['book_tree'] as String? ?? '',
      bookCurrentPage: json['book_current_page'] as int? ?? 0,
      bookPage: json['book_page'] as int? ?? 0,
      bookReadList: (json['book_read_list'] as List? ?? [])
          .map((item) => BookReadHistoryEntity(
                bookCurrentPage:
                    (item as Map)['book_current_page'] as int? ?? 0,
                bookCreatedAt: item['book_created_at'] as String?,
                bookStartDate: item['book_start_date'] as String?,
                bookEndDate: item['book_end_date'] as String?,
              ))
          .toList(),
      memoList: (json['memo_list'] as List? ?? [])
          .map((item) => BookMemoSummaryEntity(
                id: (item as Map)['id'] as int? ?? 0,
                memoContent: item['memo_content'] as String? ?? '',
                memoCreatedAt: item['memo_created_at'] as String? ?? '',
                memoLike: item['memo_like'] as bool? ?? false,
                imageUrl: item['image_url'] as String?,
              ))
          .toList(),
    );
  }
}
