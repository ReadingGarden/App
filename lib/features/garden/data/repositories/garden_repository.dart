import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/garden_service.dart';
import '../../domain/entities/garden_main_entity.dart';
import '../../domain/entities/garden_summary_entity.dart';

final gardenRepositoryProvider = Provider<GardenRepository>((ref) {
  return GardenRepository(gardenService);
});

class GardenRepository {
  GardenRepository(this._service);

  final GardenService _service;

  Future<List<GardenSummaryEntity>> fetchGardenList() async {
    final response = await _service.getGardenList();
    if (response?.statusCode == 200) {
      final List data = response?.data['data'] ?? [];
      return data
          .map(
            (item) => GardenSummaryEntity.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();
    }
    return [];
  }

  Future<GardenMainEntity?> fetchGardenDetail(int gardenNo) async {
    final response = await _service.getGardenDetail(gardenNo);
    if (response?.statusCode == 200) {
      return GardenMainEntity.fromJson(
        Map<String, dynamic>.from(response?.data['data'] ?? {}),
      );
    }
    return null;
  }

  Future<bool> updateMainGarden(int gardenNo) async {
    final response = await _service.putGardenMain(gardenNo);
    return response?.statusCode == 200;
  }

  Future<int> updateGarden(int gardenNo, Map<String, dynamic> data) async {
    final response = await _service.putGarden(gardenNo, data);
    return response?.statusCode ?? 0;
  }

  Future<int> deleteGarden(int gardenNo) async {
    final response = await _service.deleteGarden(gardenNo);
    return response?.statusCode ?? 0;
  }

  Future<int> moveBooksToGarden(int gardenNo, int toGardenNo) async {
    final response = await _service.moveToGarden(gardenNo, toGardenNo);
    return response?.statusCode ?? 0;
  }

  Future<int> leaveGarden(int gardenNo) async {
    final response = await _service.byeGarden(gardenNo);
    return response?.statusCode ?? 0;
  }

  Future<int> updateGardenLeader(int gardenNo, int userNo) async {
    final response = await _service.putGardenLeader(gardenNo, userNo);
    return response?.statusCode ?? 0;
  }

  Future<GardenMainEntity?> fetchInviteGarden(int gardenNo) async {
    return fetchGardenDetail(gardenNo);
  }

  Future<int> acceptGardenInvite(int gardenNo) async {
    final response = await _service.postGardenInvite(gardenNo);
    return response?.statusCode ?? 0;
  }
}
