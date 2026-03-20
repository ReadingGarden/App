import '../../domain/entities/book_detail_entity.dart';

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
      bookTitle: json['book_title'] as String? ?? '',
      bookAuthor: json['book_author'] as String? ?? '',
      bookPublisher: json['book_publisher'] as String? ?? '',
      bookInfo: json['book_info'] as String? ?? '',
      bookImageUrl: json['book_image_url'] as String?,
      bookTree: json['book_tree'] as String? ?? '',
      bookCurrentPage: json['book_current_page'] as int? ?? 0,
      bookPage: json['book_page'] as int? ?? 0,
      bookReadList: (json['book_read_list'] as List? ?? [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
      memoList: (json['memo_list'] as List? ?? [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }
}
