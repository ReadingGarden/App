import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Messaging {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification(BuildContext context) async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
            'high_importance_channel', 'high_importance_notification',
            importance: Importance.max));

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@drawable/ic_notification"),
      ),
      onDidReceiveNotificationResponse: (details) {
        debugPrint('포그라운드 알림을 눌렀습니다.');
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        debugPrint('백그라운드 알림을 눌렀습니다.');
      },
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
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
          ),
        );
        debugPrint('포그라운드 알림 수신: ${message.notification!}');
      }
    });
  }
}

final messaging = Messaging();
