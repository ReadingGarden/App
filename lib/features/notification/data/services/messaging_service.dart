import 'package:book_flutter/core/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void _onBackgroundNotificationResponse(NotificationResponse details) {
  logger.d('백그라운드 알림을 눌렀습니다.');
}

class Messaging {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    try {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(const AndroidNotificationChannel(
              'high_importance_channel', 'high_importance_notification',
              importance: Importance.max));

      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: DarwinInitializationSettings(
            // 권한은 fcm_token_provider에서 이미 요청하므로 여기서는 중복 요청 방지
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
        onDidReceiveNotificationResponse: (details) {
          logger.d('포그라운드 알림을 눌렀습니다.');
        },
        onDidReceiveBackgroundNotificationResponse:
            _onBackgroundNotificationResponse,
      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      logger.e('알림 초기화 실패: $e');
    }
  }

  void foregroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
                'high_importance_channel', 'high_importance_notification',
                importance: Importance.max,
                priority: Priority.high,
                icon: '@drawable/ic_notification'),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
        );
        logger.d('포그라운드 알림 수신: ${message.notification}');
      }
    });
  }
}

final messaging = Messaging();
