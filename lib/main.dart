import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'core/provider/FcmTokenProvider.dart';
import 'firebase_options.dart';
import 'utils/Functions.dart';
import 'utils/Router.dart';
import 'utils/SharedPreferences.dart';

void main() async {
  // 플러그인 초기화
  WidgetsFlutterBinding.ensureInitialized();
  //권한 요청
  await Functions.requestPermissions();
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'a4fcc9bb270d51847a1ae05d63619bda',
  );
  // 위젯이 providers를 읽을 수 있게 하려면 전체 애플리케이션을 "ProviderScope" 위젯으로 감싸야 합니다.
  // 여기에 providers의 상태가 저장됩니다.
  runApp(const ProviderScope(child: MyApp()));
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
              fontFamily: 'SUIT',
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
    ref.read(fcmTokenProvider);

    //1초 후에 로그인 페이지로 이동
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final fcmTokenAsyncValue = ref.watch(fcmTokenProvider);

    fcmTokenAsyncValue.when(data: (fcmToken) {
      print('FCM Token: $fcmToken');
    }, loading: () {
      //로딩 중
      print('Loading FCM Token...');
    }, error: (error, stackTrace) {
      print('Error retrieving FCM token: $error');
    });

    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(child: Text('Splash')),
    );
  }
}
