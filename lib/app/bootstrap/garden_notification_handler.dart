import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/router/app_router.dart';
import '../../core/service/GardenService.dart';
import '../../features/garden/domain/entities/garden_main_entity.dart';
import '../../features/garden/presentation/providers/garden_provider.dart';

Future<void> openGardenFromNotification(
  ProviderContainer container,
  int gardenNo,
) async {
  final updated = await gardenService.putGardenMain(gardenNo);
  if (updated?.statusCode != 200) {
    return;
  }

  final detail = await gardenService.getGardenDetail(gardenNo);
  if (detail?.statusCode != 200) {
    return;
  }

  final garden = GardenMainEntity.fromMap(
    Map<String, dynamic>.from(detail?.data['data'] ?? {}),
  );
  container.read(gardenMainProvider.notifier).state = garden;
  container.read(gardenMainBookListProvider.notifier).state = garden.bookList;
  container.read(gardenMainMemberListProvider.notifier).state =
      garden.gardenMembers;

  navigatorKey.currentState?.pushNamed('garden');
}
