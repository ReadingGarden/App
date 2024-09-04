import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

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

  //String(yyyy.MM.dd) -> DateTime 변환
  static DateTime formatBookReadString(String timeString) {
    DateFormat dateFormat = DateFormat('yyyy.MM.dd');
    return dateFormat.parse(timeString);
  }

  //String(DateTime) -> String 변환(yyyy.MM.dd)
  static String formatBookReadDate(String dateTimeString) {
    // String -> DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);
    // DateTime -> String
    String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);
    return formattedDate;
  }

  //가든 컬러
  static Color gardenColor(String color) {
    int colorIndex = Constant.GARDEN_COLOR_LIST.indexOf(color);
    return Constant.GARDEN_COLOR_SET_LIST[colorIndex];
  }

  //가든 배경 컬러
  static Color gardenBackColor(String color) {
    int colorIndex = Constant.GARDEN_COLOR_LIST.indexOf(color);
    return Constant.GARDEN_CHIP_COLOR_SET_LIST[colorIndex];
  }

  //권한 요청
  static Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      // Permission.microphone
    ].request();

    // 상태 확인
    print('Camera permission status: ${statuses[Permission.camera]}');
    print('Storage permission status: ${statuses[Permission.storage]}');
    // print('Microphone permission status: ${statuses[Permission.microphone]}');
  }

  //권한 확인 및 요청
  static Future<void> checkAndRequestPermissions(Function function) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      // Permission.microphone
    ].request();

    print(statuses);

    if (statuses[Permission.camera]!.isGranted &&
            statuses[Permission.storage]!.isGranted
        // && statuses[Permission.microphone]!.isGranted
        ) {
      // 권한이 이미 부여됨
      function();
    } else {
      // 권한이 부여되지 않음, 요청
      statuses = await [
        Permission.camera,
        Permission.storage,
        // Permission.microphone
      ].request();

      if (statuses[Permission.camera]!.isGranted &&
              statuses[Permission.storage]!.isGranted
          // && statuses[Permission.microphone]!.isGranted
          ) {
        // 권한이 부여됨
        function();
      } else if (statuses[Permission.camera]!.isPermanentlyDenied ||
              statuses[Permission.storage]!.isPermanentlyDenied
          // || statuses[Permission.microphone]!.isPermanentlyDenied
          ) {
        // 권한이 영구적으로 거부됨, 설정으로 이동
        await openAppSettings();
        // 상태를 다시 확인
        Map<Permission, PermissionStatus> newStatuses = await [
          Permission.camera,
          Permission.storage,
          // Permission.microphone
        ].request();

        if (newStatuses[Permission.camera]!.isGranted &&
                newStatuses[Permission.storage]!.isGranted
            // &&newStatuses[Permission.microphone]!.isGranted
            ) {
          function();
        } else {
          print('권한이 여전히 부여되지 않았습니다.');
        }
      } else {
        // 권한이 거부되었으나 영구적이지 않음
        statuses = await [
          Permission.camera,
          Permission.storage,
          Permission.microphone
        ].request();

        if (statuses[Permission.camera]!.isGranted &&
                statuses[Permission.storage]!.isGranted
            // && statuses[Permission.microphone]!.isGranted
            ) {
          // 권한이 부여됨
          function();
        } else {
          print('권한 요청이 거부되었습니다.');
        }
      }
    }
  }
}
