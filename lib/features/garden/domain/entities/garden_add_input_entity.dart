class GardenAddInputEntity {
  const GardenAddInputEntity({
    required this.gardenTitle,
    required this.gardenInfo,
    required this.gardenColor,
  });

  final String gardenTitle;
  final String gardenInfo;
  final String gardenColor;

  Map<String, dynamic> toMap() {
    return {
      'garden_title': gardenTitle,
      'garden_info': gardenInfo,
      'garden_color': gardenColor,
    };
  }
}
