import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

final authUserProvider = StateProvider<UserEntity>((ref) => UserEntity.empty);

Future<bool> fetchUser(WidgetRef ref) async {
  final repository = ref.read(authRepositoryProvider);
  final user = await repository.fetchUser();
  if (user != null) {
    ref.read(authUserProvider.notifier).state = user;
    return true;
  }
  return false;
}

Future<int> updateUser(
  WidgetRef ref,
  BuildContext context,
  Map<String, dynamic> data,
) async {
  final repository = ref.read(authRepositoryProvider);
  final statusCode = await repository.updateUser(data);
  if (statusCode == 200) {
    final fetched = await fetchUser(ref);
    if (!context.mounted) {
      return statusCode;
    }
    if (fetched) {
      context.pop();
    } else {
      context.go('/start');
    }
  }
  return statusCode;
}
