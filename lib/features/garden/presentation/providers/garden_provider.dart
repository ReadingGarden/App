import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/garden_repository.dart';
import '../../domain/entities/garden_main_book_entity.dart';
import '../../domain/entities/garden_main_entity.dart';
import '../../domain/entities/garden_member_entity.dart';
import '../../domain/entities/garden_summary_entity.dart';

final gardenVisitCountProvider = StateProvider<int>((ref) => 0);
final gardenNavigateToProvider = StateProvider<int?>((ref) => null);

final gardenListProvider =
    StateProvider<List<GardenSummaryEntity>>((ref) => []);
final gardenMainProvider =
    StateProvider<GardenMainEntity>((ref) => GardenMainEntity.empty);
final gardenMainBookListProvider =
    StateProvider<List<GardenMainBookEntity>>((ref) => []);
final gardenMainMemberListProvider =
    StateProvider<List<GardenMemberEntity>>((ref) => []);
final inviteGardenProvider =
    StateProvider<GardenMainEntity>((ref) => GardenMainEntity.empty);

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

Future<int> updateGarden(
  WidgetRef ref,
  int gardenNo,
  Map<String, dynamic> data,
) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final statusCode = await repository.updateGarden(gardenNo, data);
  if (statusCode == 200) {
    await fetchGardenDetail(ref, gardenNo);
  }
  return statusCode;
}

Future<int> deleteGarden(WidgetRef ref, int gardenNo) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final statusCode = await repository.deleteGarden(gardenNo);
  if (statusCode == 200) {
    await fetchGardenList(ref);
  }
  return statusCode;
}

Future<int> moveBooksToGarden(
  WidgetRef ref,
  int gardenNo,
  int toGardenNo,
) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final statusCode = await repository.moveBooksToGarden(gardenNo, toGardenNo);
  if (statusCode == 200) {
    await fetchGardenList(ref);
  }
  return statusCode;
}

Future<int> leaveGarden(WidgetRef ref, int gardenNo) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final statusCode = await repository.leaveGarden(gardenNo);
  if (statusCode == 200) {
    await fetchGardenList(ref);
  }
  return statusCode;
}

Future<int> updateGardenLeader(
  WidgetRef ref,
  int gardenNo,
  int userNo,
) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final statusCode = await repository.updateGardenLeader(gardenNo, userNo);
  if (statusCode == 200) {
    await fetchGardenDetail(ref, gardenNo);
  }
  return statusCode;
}

Future<void> fetchInviteGarden(WidgetRef ref, int gardenNo) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final garden = await repository.fetchInviteGarden(gardenNo);
  if (garden != null) {
    ref.read(inviteGardenProvider.notifier).state = garden;
  }
}

Future<int> acceptGardenInvite(WidgetRef ref, int gardenNo) async {
  final repository = ref.read(gardenRepositoryStateProvider);
  final statusCode = await repository.acceptGardenInvite(gardenNo);
  if (statusCode == 201) {
    await updateMainGarden(ref, gardenNo);
  }
  return statusCode;
}
