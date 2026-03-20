import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/service/GardenService.dart';
import '../../domain/entities/garden_add_input_entity.dart';

final gardenAddRepositoryProvider = Provider<GardenAddRepository>((ref) {
  return GardenAddRepository(gardenService);
});

class GardenAddRepository {
  GardenAddRepository(this._service);

  final GardenService _service;

  Future<int?> createGarden(GardenAddInputEntity input) async {
    final response = await _service.postGarden(input.toMap());
    if (response?.statusCode == 201) {
      return response?.data['data']['garden_no'] as int?;
    }
    return null;
  }

  Future<bool> updateMainGarden(int gardenNo) async {
    final response = await _service.putGardenMain(gardenNo);
    return response?.statusCode == 200;
  }
}
