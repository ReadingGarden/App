import 'dart:async';

import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/features/notification/data/services/messaging_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:book_flutter/core/network/connectivity_provider.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/bootstrap/app_bootstrap.dart';
import 'app/bootstrap/garden_notification_handler.dart';
import 'app/navigation/bottom_navi_page.dart';
import 'app/router/app_router.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.d('백그라운드 알림 수신 메시지 ID: ${message.messageId}');
}

void main() async {
  await bootstrapApplication();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));

  // ProviderContainer 생성
  final container = ProviderContainer();

  //백그라운드 메세지 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.d('백그라운드에서 연 알림 데이터: ${message.data}');

    final gardenNo = int.tryParse(message.data["garden_no"] ?? '');
    if (gardenNo != null) {
      container.read(currentIndexProvider.notifier).state = 0;
      openGardenFromNotification(container, gardenNo);
    }
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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          builder: (context, child) {
            final isOnline =
                ref.watch(connectivityProvider).valueOrNull ?? true;
            return SafeArea(
              top: false,
              child: Column(
                children: [
                  if (!isOnline)
                    Material(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).viewPadding.top + 4.h,
                          bottom: 8.h,
                        ),
                        color: AppColors.grey_8D,
                        child: Text(
                          '인터넷 연결이 끊겼습니다',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  Expanded(child: child!),
                ],
              ),
            );
          },
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
