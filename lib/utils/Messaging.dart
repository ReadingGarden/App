import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Messaging {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification(BuildContext context) async {
    //알림 채널 생성
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
            'high_importance_channel', 'high_importance_notification',
            importance: Importance.max));

    //로컬 알림 초기화
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      ),
      onDidReceiveNotificationResponse: (details) {
        // 알림 클릭 이벤트 처리
        print("포그라운드 클릭");
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print("백그라운드 클릭");
      },
    );

    //포그라운드 알림 설정
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void foregroundMessage() {
    //포그라운드 메세지 처리
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher', // 알림 아이콘
            ),
          ),
        );
        print("Foreground 메시지 수신: ${message.notification!}");
      }
    });
  }
}

final messaging = Messaging();
