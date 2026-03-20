import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../core/provider/fcm_token_provider.dart';
import '../../core/storage/token_storage.dart';
import '../../core/ui/app_colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    //FCM 토큰을 비동기로 가져옵니다.
    debugPrint('스플래시에서 FCM 토큰 조회를 시작합니다: ${ref.read(fcmTokenProvider)}');

    // 1초 후에 로그인 페이지로 이동
    Future.delayed(const Duration(seconds: 2), () async {
      //저장된 Access 불러오기
      final accessToken = await loadAccess();
      if (!mounted) return;
      //Access 저장 되어있으면 자동 로그인
      if (accessToken == null) {
        context.go('/start');
      } else {
        context.go('/bottom-navi');
      }

      debugPrint('저장된 액세스 토큰 조회 결과: $accessToken');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_F2,
      body: Padding(
        padding: EdgeInsets.only(bottom: 91.h),
        child: Center(
            child: Image.asset(
          'assets/images/splash.png',
          width: 120.w,
          height: 156.h,
        )),
      ),
    );
  }
}
