import 'package:freezed_annotation/freezed_annotation.dart';

part 'garden_add_input_entity.freezed.dart';
part 'garden_add_input_entity.g.dart';

@freezed
abstract class GardenAddInputEntity with _$GardenAddInputEntity {
  const factory GardenAddInputEntity({
    @Default('') String gardenTitle,
    @Default('') String gardenInfo,
    @Default('') String gardenColor,
  }) = _GardenAddInputEntity;

  factory GardenAddInputEntity.fromJson(Map<String, dynamic> json) =>
      _$GardenAddInputEntityFromJson(json);
}
