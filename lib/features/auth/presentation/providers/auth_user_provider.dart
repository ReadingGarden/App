import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

final authUserProvider = StateProvider<UserEntity>((ref) => UserEntity.empty);

Future<void> fetchUser(WidgetRef ref, BuildContext context) async {
  final repository = ref.read(authRepositoryProvider);
  final user = await repository.fetchUser();
  if (user != null) {
    ref.read(authUserProvider.notifier).state = user;
    return;
  }

  if (context.mounted) {
    context.go('/start');
  }
}

Future<int> updateUser(
  WidgetRef ref,
  BuildContext context,
  Map<String, dynamic> data,
) async {
  final repository = ref.read(authRepositoryProvider);
  final statusCode = await repository.updateUser(data);
  if (statusCode == 200) {
    await fetchUser(ref, context);
    if (context.mounted) {
      context.pop();
    }
  }
  return statusCode;
}
