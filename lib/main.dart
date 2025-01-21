import 'dart:async';
import 'dart:io';

import 'package:book_flutter/utils/Messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'BottomNaviPage.dart';
import 'core/api/GardenAPI.dart';
import 'core/provider/FcmTokenProvider.dart';
import 'core/service/GardenService.dart';
import 'firebase_options.dart';
import 'utils/Functions.dart';
import 'utils/Router.dart';
import 'utils/SharedPreferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('백그라운드 수신: ${message.messageId}');
}

void main() async {
  // 플러그인 초기화
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: 'a4fcc9bb270d51847a1ae05d63619bda',
  );
  //권한 요청
  await Functions.requestPermissions();
  // FlutterBranchSdk 초기화
  await FlutterBranchSdk.init();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ProviderContainer 생성
  final container = ProviderContainer();

  //백그라운드 메세지 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('백그라운드에서 클릭된 알림: ${message.data}');

    container.read(currentIndexProvider.notifier).state = 0;
    putGardenMain(container, int.parse(message.data["garden_no"]));
  });

  // 알림 권한 요청 (iOS 전용)
  // await FirebaseMessaging.instance.requestPermission();

  // 위젯이 providers를 읽을 수 있게 하려면 전체 애플리케이션을 "ProviderScope" 위젯으로 감싸야
  runApp(ProviderScope(
      parent: container, // 전역 컨테이너 연결,
      child: MyApp()));
}

//iOS 푸시 알림 권한 요청
// void requestPermissions() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   print('User granted permission: ${settings.authorizationStatus}');
// }

//가든 메인 변경 api
void putGardenMain(ProviderContainer container, int garden_no) async {
  final response = await gardenService.putGardenMain(garden_no);
  if (response?.statusCode == 200) {
    getGardenDetail(container, garden_no);
  }
}

//가든 상세 조회 api
void getGardenDetail(ProviderContainer container, int garden_no) async {
  final response = await gardenService.getGardenDetail(garden_no);
  if (response?.statusCode == 200) {
    container.read(gardenMainProvider.notifier).state = response?.data['data'];
    container.read(gardenMainBookListProvider.notifier).state =
        response?.data['data']['book_list'];
    container.read(gardenMainMemberListProvider.notifier).state =
        response?.data['data']['garden_members'];

    navigatorKey.currentState?.pushNamed('garden');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    messaging.initializeNotification(context);
    messaging.foregroundMessage();

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

class SplashPage extends ConsumerStatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    //FCM 토큰을 비동기로 가져옵니다.
    print(ref.read(fcmTokenProvider));

    // 1초 후에 로그인 페이지로 이동
    Future.delayed(const Duration(seconds: 2), () async {
      //저장된 Access 불러오기
      final accessToken = await loadAccess();
      //Access 저장 되어있으면 자동 로그인
      if (accessToken == null) {
        context.go('/start');
      } else {
        context.go('/bottom-navi');
      }

      print('ACCESS Token: $accessToken');
      // context.go('/start');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(child: Text('Splash')),
    );
  }
}
