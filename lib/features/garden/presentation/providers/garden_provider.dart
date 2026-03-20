import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/garden_repository.dart';
import '../../domain/entities/garden_main_book_entity.dart';
import '../../domain/entities/garden_main_entity.dart';
import '../../domain/entities/garden_summary_entity.dart';

final gardenListProvider =
    StateProvider<List<GardenSummaryEntity>>((ref) => []);
final gardenMainProvider =
    StateProvider<GardenMainEntity>((ref) => GardenMainEntity.empty);
final gardenMainBookListProvider =
    StateProvider<List<GardenMainBookEntity>>((ref) => []);
final gardenMainMemberListProvider =
    StateProvider<List<Map<String, dynamic>>>((ref) => []);

final gardenRepositoryStateProvider = Provider<GardenRepository>((ref) {
  return ref.read(gardenRepositoryProvider);
});

Future<void> fetchGardenList(WidgetRef ref) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final gardens = await repository.fetchGardenList();
  ref.read(gardenListProvider.notifier).state = gardens;

  if (gardens.isNotEmpty) {
    await fetchGardenDetail(ref, gardens.first.gardenNo);
  }
}

Future<void> fetchGardenDetail(WidgetRef ref, int gardenNo) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final garden = await repository.fetchGardenDetail(gardenNo);
  if (garden != null) {
    ref.read(gardenMainProvider.notifier).state = garden;
    ref.read(gardenMainBookListProvider.notifier).state = garden.bookList;
    ref.read(gardenMainMemberListProvider.notifier).state =
        garden.gardenMembers;
  }
}

Future<void> updateMainGarden(WidgetRef ref, int gardenNo) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final updated = await repository.updateMainGarden(gardenNo);
  if (updated) {
    await fetchGardenList(ref);
  }
}
