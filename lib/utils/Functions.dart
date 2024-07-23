import 'dart:ui';

import 'package:book_flutter/core/provider/TokenProvider.dart';
import 'package:book_flutter/utils/SharedPreferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'Constant.dart';

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

  //String(DateTime) -> String 변환(yyyy년 MM월 dd일)
  static String formatDate(String dateTimeString) {
    // String -> DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);
    // DateTime -> String
    String formattedDate = DateFormat('yyyy년 MM월 dd일').format(dateTime);
    return formattedDate;
  }

  //AccessToken 불러오기
  static void getAccess(WidgetRef ref) async {
    ref.read(tokenProvider.accessProvider.notifier).state = await loadAccess();
  }

  //가든 컬러
  static Color gardenColor(String color) {
    int colorIndex = Constant.GARDEN_COLOR_LIST.indexOf(color);
    return Constant.GARDEN_COLOR_SET_LIST[colorIndex];
  }
}
