import 'dart:async';

import 'package:book_flutter/core/services/messaging_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/bootstrap/app_bootstrap.dart';
import 'app/bootstrap/garden_notification_handler.dart';
import 'app/navigation/bottom_navi_page.dart';
import 'app/router/app_router.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('백그라운드 알림 수신 메시지 ID: ${message.messageId}');
}

void main() async {
  await bootstrapApplication();

  // ProviderContainer 생성
  final container = ProviderContainer();

  //백그라운드 메세지 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('백그라운드에서 연 알림 데이터: ${message.data}');

    container.read(currentIndexProvider.notifier).state = 0;
    openGardenFromNotification(
      container,
      int.parse(message.data["garden_no"]),
    );
  });

  // 알림 권한 요청 (iOS 전용)
  // await FirebaseMessaging.instance.requestPermission();

  // 알림 초기화
  await messaging.initializeNotification();
  messaging.foregroundMessage();

  // 전역 컨테이너를 앱 루트에 연결합니다.
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          theme: ThemeData(
              fontFamily: 'SUITE',
              scaffoldBackgroundColor: Colors.white,
              textTheme: TextTheme(
                //앱바
                titleLarge: const TextStyle(color: Colors.black),
                //내부 텍스트 필드
                titleMedium: TextStyle(fontSize: 16.sp, color: Colors.black),
                //기본 body 텍스트
                bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.black),
                //텍스트 필드 에러 메세지
                bodySmall: TextStyle(fontSize: 14.sp, color: Colors.black),
              )),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', 'KO'),
            Locale('en', 'US'),
          ],
        );
      },
    );
  }
}
