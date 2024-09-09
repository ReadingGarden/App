import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookDetailProvider =
    StateNotifierProvider<BookDetailNotifier, Map<String, dynamic>>(
        (ref) => BookDetailNotifier());

class BookDetailNotifier extends StateNotifier<Map<String, dynamic>> {
  BookDetailNotifier() : super({});

  void updateBookDetail(Map<String, dynamic> data) {
    state = data;
  }

  void updateGardenDetail(Map gardenDetail) {
    state = {
      ...state, //기존 상태 유지
      ...gardenDetail, // 새롭게 전달된 정보로 상태 업데이트
    };
  }

  void reset() {
    state = {};
  }
}
