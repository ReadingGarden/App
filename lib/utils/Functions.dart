import 'package:book_flutter/core/provider/TokenProvider.dart';
import 'package:book_flutter/utils/SharedPreferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Functions {
  //이메일 유효성 검사
  static bool emailValidation(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  //DateTime -> String 변환(HH:mm)
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  //String(HH:mm) -> DateTime 변환
  static DateTime formatString(String timeString) {
    DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.parse(timeString);
  }

  //AccessToken 불러오기
  static void getAccess(WidgetRef ref) async {
    ref.read(TokenProvider.accessProvider.notifier).state = await loadAccess();
  }
}
