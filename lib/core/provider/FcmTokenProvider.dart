import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// FCM 토큰을 가져오는 FutureProvider
final fcmTokenProvider = FutureProvider<String?>((ref) async {
  try {
    //FirebaseMessaging 인스턴스 생성
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // APNS 권한 요청 (iOS)
    // await messaging.requestPermission(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    //APNS 토큰 가져오기 (iOS 전용)
    // String? apnsToken = await messaging.getAPNSToken();
    // if (apnsToken != null) {
    //   print('APNS Token: $apnsToken');
    // } else {
    //   print('Failed to retrieve APNS token');
    // }

    // FCM 토큰 가져오기
    String? fcmToken = await messaging.getToken();

    if (fcmToken == null) {
      throw Exception('FCM Token is null');
    }

    print('FCM Token: $fcmToken');
    return fcmToken;
  } catch (error) {
    print('Error retrieving FCM token: $error');
    throw error;
  }
});
