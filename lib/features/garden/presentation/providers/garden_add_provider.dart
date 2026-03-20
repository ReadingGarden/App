import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/garden_add_repository.dart';
import '../../domain/entities/garden_add_input_entity.dart';
import 'garden_provider.dart';

final gardenAddRepositoryStateProvider = Provider<GardenAddRepository>((ref) {
  return ref.read(gardenAddRepositoryProvider);
});

Future<int?> createGarden(WidgetRef ref, GardenAddInputEntity input) async {
  final repository = ref.read(gardenAddRepositoryStateProvider);
  return repository.createGarden(input);
}

Future<bool> createGardenAndSelectMain(
  WidgetRef ref,
  GardenAddInputEntity input,
) async {
  final repository = ref.read(gardenAddRepositoryStateProvider);
  final gardenNo = await repository.createGarden(input);
  if (gardenNo == null) {
    return false;
  }

  final updated = await repository.updateMainGarden(gardenNo);
  if (updated) {
    await fetchGardenList(ref);
  }
  return updated;
}
