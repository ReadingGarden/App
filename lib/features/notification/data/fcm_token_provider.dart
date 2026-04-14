import 'dart:io';

import 'package:book_flutter/core/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// FCM 토큰을 가져오는 FutureProvider
final fcmTokenProvider = FutureProvider<String?>((ref) async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // iOS에서는 APNS 토큰이 설정될 때까지 대기 필요
    if (Platform.isIOS) {
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // APNS 토큰이 설정될 때까지 재시도
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
