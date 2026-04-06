import 'package:freezed_annotation/freezed_annotation.dart';

part 'garden_summary_entity.freezed.dart';
part 'garden_summary_entity.g.dart';

@freezed
abstract class GardenSummaryEntity with _$GardenSummaryEntity {
  const factory GardenSummaryEntity({
    @Default(0) int gardenNo,
    @Default('') String gardenTitle,
    @Default('') String gardenInfo,
    @Default('') String gardenColor,
    @Default(0) int bookCount,
  }) = _GardenSummaryEntity;

  factory GardenSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$GardenSummaryEntityFromJson(json);
}
