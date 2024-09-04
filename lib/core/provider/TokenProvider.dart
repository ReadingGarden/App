import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmTokenProvider = FutureProvider<String?>((ref) async {
  //FirebaseMessaging 인스턴스 생성
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // // APNS 권한 요청 (iOS)
  // await messaging.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // //APNS 토큰 가져오기 (iOS에서만 작동)
  String? apnsToken = await messaging.getAPNSToken();
  if (apnsToken != null) {
    print('APNS Token: $apnsToken');
  } else {
    print('Failed to retrieve APNS token');
  }

  // //FCM 토큰 가져오기
  // String? fcmToken;
  // await messaging.onTokenRefresh.listen((newToken) {
  //   fcmToken = newToken;
  //   print('New FCM Token: $fcmToken');
  // }).asFuture();

  // if (fcmToken != null) {
  //   return fcmToken;
  // } else {
  //   print('Failed to retrieve FCM token');
  // }

  final fcmToken = await messaging.getToken();

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // TODO: If necessary send token to application server.

    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
    print('----------------$fcmToken');
  }).onError((err) {
    // Error getting token.
    print('----------------Error getting token $err');
  });

  return fcmToken;
});

class TokenProvider {
  final accessProvider = StateProvider<String?>((ref) => null);
  final refreshProvider = StateProvider<String?>((ref) => null);
}

final tokenProvider = TokenProvider();
