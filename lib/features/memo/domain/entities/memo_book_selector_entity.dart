import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_book_selector_entity.freezed.dart';
part 'memo_book_selector_entity.g.dart';

@freezed
abstract class MemoBookSelectorEntity with _$MemoBookSelectorEntity {
  const MemoBookSelectorEntity._();

  const factory MemoBookSelectorEntity({
    required int bookNo,
    required String bookTitle,
    required String bookAuthor,
    required String? bookImageUrl,
    required int? gardenNo,
  }) = _MemoBookSelectorEntity;

  factory MemoBookSelectorEntity.fromJson(Map<String, dynamic> json) =>
      _$MemoBookSelectorEntityFromJson(json);

  Map<String, dynamic> toMemoWriteMap() {
    return {
      'book_no': bookNo,
      'book_title': bookTitle,
      'book_author': bookAuthor,
      'book_image_url': bookImageUrl,
      'garden_no': gardenNo,
    };
  }
}
