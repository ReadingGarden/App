import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_edit_history_entity.freezed.dart';
part 'book_edit_history_entity.g.dart';

@freezed
abstract class BookEditHistoryEntity with _$BookEditHistoryEntity {
  const factory BookEditHistoryEntity({
    required int id,
    required String? bookStartDate,
    required String? bookEndDate,
  }) = _BookEditHistoryEntity;

  factory BookEditHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$BookEditHistoryEntityFromJson(json);
}
