import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_memo_summary_entity.freezed.dart';
part 'book_memo_summary_entity.g.dart';

@freezed
abstract class BookMemoSummaryEntity with _$BookMemoSummaryEntity {
  const BookMemoSummaryEntity._();

  const factory BookMemoSummaryEntity({
    @Default(0) int id,
    @Default('') String memoContent,
    @Default('') String memoCreatedAt,
    @Default(false) bool memoLike,
    String? imageUrl,
  }) = _BookMemoSummaryEntity;

  factory BookMemoSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$BookMemoSummaryEntityFromJson(json);

  Map<String, dynamic> toRoutePayload({
    required int bookNo,
    required String bookTitle,
    required String bookAuthor,
    required String? bookImageUrl,
    bool isMine = true,
  }) {
    return {
      'id': id,
      'memo_content': memoContent,
      'memo_created_at': memoCreatedAt,
      'memo_like': memoLike,
      'image_url': imageUrl,
      'book_no': bookNo,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_image_url': bookImageUrl,
      'is_mine': isMine,
    };
  }
}
