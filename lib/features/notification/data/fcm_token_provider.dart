import 'dart:io';

import 'package:book_flutter/core/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// FCM 토큰을 가져오는 FutureProvider
final fcmTokenProvider = FutureProvider<String?>((ref) async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // iOS는 권한 허용 직후 APNS 등록이 비동기로 이뤄지므로 토큰 준비될 때까지 대기
    // (권한 요청은 앱 시작 시 Functions.requestPermissions()에서 이미 수행)
    if (Platform.isIOS) {
      String? apnsToken;
      for (int i = 0; i < 5; i++) {
        apnsToken = await messaging.getAPNSToken();
        if (apnsToken != null) break;
        await Future.delayed(const Duration(seconds: 1));
      }

      if (apnsToken == null) {
        logger.e('APNS 토큰을 가져올 수 없습니다.');
        return null;
      }
    }

    // FCM 토큰 가져오기
    String? fcmToken = await messaging.getToken();

    if (fcmToken == null) {
      throw Exception('FCM Token is null');
    }

    logger.d('FCM 토큰 발급 완료: $fcmToken');
    return fcmToken;
  } catch (error) {
    logger.e('FCM 토큰 조회 실패: $error');
    rethrow;
  }
});
