import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../gen/assets.gen.dart';
import '../../core/provider/fcm_token_provider.dart';
import '../../core/storage/token_storage.dart';
import '../../core/ui/app_colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scale = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();

    debugPrint('스플래시에서 FCM 토큰 조회를 시작합니다: ${ref.read(fcmTokenProvider)}');

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_F2,
      body: Padding(
        padding: EdgeInsets.only(bottom: 91.h),
        child: Center(
          child: FadeTransition(
            opacity: _opacity,
            child: ScaleTransition(
              scale: _scale,
              child: Assets.images.splash.image(
                width: 120.w,
                height: 156.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
