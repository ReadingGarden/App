import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:book_flutter/core/flavor/flavor_config.dart';
import 'package:book_flutter/core/logger.dart';
import 'package:book_flutter/features/notification/data/services/messaging_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

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
import 'core/storage/token_storage.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/notification/data/fcm_token_provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.d('백그라운드 알림 수신 메시지 ID: ${message.messageId}');
}

void _updateFcmTokenOnServer(ProviderContainer container) async {
  try {
    final accessToken = await loadAccess();
    if (accessToken == null) return; // 로그인 안 된 상태면 스킵

    final fcmToken = await container.read(fcmTokenProvider.future);
    if (fcmToken == null) return;

    await container.read(authRepositoryProvider).updateUser({'user_fcm': fcmToken});
    logger.d('FCM 토큰 서버 업데이트 완료: $fcmToken');
  } catch (e) {
    logger.e('FCM 토큰 업데이트 실패: $e');
  }
}

Future<void> _requestTrackingPermission() async {
  // 이미 권한 결정된 상태면 재요청 불필요
  final status = await AppTrackingTransparency.trackingAuthorizationStatus;
  if (status != TrackingStatus.notDetermined) return;

  // 권한 팝업이 시스템 준비되기 전에 뜨면 자동 거부되므로 약간 대기
  await Future.delayed(const Duration(milliseconds: 300));
  final result = await AppTrackingTransparency.requestTrackingAuthorization();
  logger.d('ATT 권한 결과: $result');
}

/// 공용 앱 실행 로직.
///
/// `main_dev.dart`, `main_prod.dart`, 그리고 기본 `main()` 모두 Flavor만
/// 세팅한 뒤 이 함수를 호출한다.
Future<void> runMainApp() async {
  await bootstrapApplication();

  logger.i('앱 실행 flavor: ${FlavorConfig.flavor.name}');

  // Flutter/Dart 에러를 Crashlytics로 자동 전송
  // (디버그 모드에서는 비활성화 — JIT PAC 크래시 방지)
  if (const bool.fromEnvironment('dart.vm.product')) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ));
  }

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

  // 완전 종료 상태에서 알림 탭으로 앱 실행 시 처리
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message == null) return;
    logger.d('종료 상태에서 연 알림 데이터: ${message.data}');

    final gardenNo = int.tryParse(message.data["garden_no"] ?? '');
    if (gardenNo != null) {
      container.read(currentIndexProvider.notifier).state = 0;
      openGardenFromNotification(container, gardenNo);
    }
  });

  // Branch 딥링크 리스너 (초대 링크)
  // 모든 진입 상태(cold start / background / 로그인 전)에서 수신하도록 최상위에 등록
  FlutterBranchSdk.listSession().listen((data) {
    logger.d('브랜치 딥링크 데이터 수신: $data');
    if (data['+clicked_branch_link'] != true) return;
    final gardenNo = int.tryParse('${data['garden_no']}');
    if (gardenNo == null) return;
    router.pushNamed('invite', extra: gardenNo);
  }, onError: (error) {
    logger.e('브랜치 딥링크 처리 실패: $error');
  });

  // 알림 초기화
  await messaging.initializeNotification();
  messaging.foregroundMessage();

  // iOS 앱 추적 투명성 권한 요청 (Branch 초대 링크 추적용)
  if (Platform.isIOS) {
    await _requestTrackingPermission();
  }

  // 앱 시작 시 FCM 토큰 서버 업데이트 (자동 로그인 시에도 토큰 갱신)
  _updateFcmTokenOnServer(container);

  // 전역 컨테이너를 앱 루트에 연결합니다.
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

/// 기본 진입점 — `flutter run`으로 실행 시 prod flavor로 동작.
void main() async {
  FlavorConfig.setFlavor(Flavor.prod);
  await runMainApp();
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
