import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/memo_repository.dart';

Future<bool> deleteMemo(WidgetRef ref, int id) async {
  final repository = ref.read(memoRepositoryProvider);
  return repository.deleteMemo(id);
}
