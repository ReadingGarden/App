import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/SharedPreferences.dart';
import '../service/MemoService.dart';

// final memoServiceProvider = Provider((ref) => MemoService());

// // GET(Memo) 요청을 처리하는 ...
// final getMemoProvider = FutureProvider<Response?>((ref) async {
//   final memoService = ref.watch(memoServiceProvider);
//   final accessToken = await loadAccess();
//   return memoService.getMemoList(accessToken);
//});
