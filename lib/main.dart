import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'utils/Router.dart';

void main() {
  // 플러그인 초기화
  WidgetsFlutterBinding.ensureInitialized();
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
                titleMedium: TextStyle(fontSize: 14.sp, color: Colors.black),
                bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.black),
                bodySmall: TextStyle(fontSize: 14.sp, color: Colors.black),
              )),

          debugShowCheckedModeBanner: false,
          routerConfig: router,
          // routeInformationProvider: router.routeInformationProvider,
          // routerDelegate: router.routerDelegate,
          // routeInformationParser: router.routeInformationParser,
        );
      },
    );
  }
}

class SplashPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 자동로그인 판별
    var isAutoLogin = true;

    // 1초 후에 로그인 페이지로 이동
    Future.delayed(const Duration(seconds: 2), () {
      isAutoLogin ? context.go('/start') : context.go('/garden');
      // context.go('/login');
    });

    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(child: Text('Splash')),
    );
  }
}
