import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_read_history_entity.freezed.dart';
part 'book_read_history_entity.g.dart';

@freezed
abstract class BookReadHistoryEntity with _$BookReadHistoryEntity {
  const factory BookReadHistoryEntity({
    required int bookCurrentPage,
    required String? bookCreatedAt,
    required String? bookStartDate,
    required String? bookEndDate,
  }) = _BookReadHistoryEntity;

  factory BookReadHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$BookReadHistoryEntityFromJson(json);
}
