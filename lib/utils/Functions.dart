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
  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  //String(HH:mm) -> DateTime 변환
  static DateTime formatString(String timeString) {
    DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.parse(timeString);
  }

  //DateTime -> String 변환(yyyy년 MM월 dd일)
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy년 MM월 dd일').format(dateTime);
  }

  //AccessToken 불러오기
  static void getAccess(WidgetRef ref) async {
    ref.read(tokenProvider.accessProvider.notifier).state = await loadAccess();
  }
}
