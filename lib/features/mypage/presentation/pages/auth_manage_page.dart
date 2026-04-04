import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/core/storage/token_storage.dart';
import 'package:book_flutter/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:book_flutter/core/ui/app_assets.dart';
import 'package:book_flutter/core/ui/app_widgets.dart';
import 'package:book_flutter/core/ui/app_colors.dart';
import 'package:book_flutter/features/auth/data/services/auth_service.dart';

class AuthManagePage extends ConsumerStatefulWidget {
  const AuthManagePage({super.key});

  @override
  ConsumerState<AuthManagePage> createState() => _AuthManagePageState();
}

class _AuthManagePageState extends ConsumerState<AuthManagePage> {
  void postLogout() async {
    final response = await authService.postLogout();
    if (response?.statusCode == 200 && mounted) {
      Navigator.of(context).pop();
      removeLoginInfo();
      context.goNamed('start');
    }
  }

  void deleteUser() async {
    final response = await authService.deleteUser();
    if (response?.statusCode == 200 && mounted) {
      Navigator.of(context).pop();
      removeLocalStorage();
      context.goNamed('start');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '계정 관리'),
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.titleList(
              '비밀번호 변경',
              () {
                context.pushNamed('pwd-setting', extra: {
                  'user_email': user.userEmail,
                  'isLoginPage': false
                });
              },
              widget: AppAssets.iconAngleRight.svg(
                colorFilter: const ColorFilter.mode(
                  AppColors.grey_8D,
                  BlendMode.srcIn,
                ),
                width: 20.r,
                height: 20.r,
              ),
            ),
            Widgets.titleList(
              '로그아웃',
              () => Widgets.baseBottomSheet(context, '로그아웃 하시겠어요?',
                  '이때까지 작성한 책 기록을 보려면 다시 로그인 해주셔야 해요.', '로그아웃', () {
                postLogout();
              }),
            ),
            GestureDetector(
              onTap: () => Widgets.deleteBottomSheet(
                  context,
                  '정말 탈퇴하시겠어요?',
                  Text.rich(TextSpan(
                      style: TextStyle(fontSize: 14.sp),
                      children: const [
                        TextSpan(text: '게정 삭제 시 '),
                        TextSpan(
                            text: '모든 가든',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '과 '),
                        TextSpan(
                            text: '책 기록',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '이 삭제되며 다시 복구할 수 없습니다.'),
                      ])),
                  '탈퇴하기', () {
                deleteUser();
              }),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                width: 360.w,
                height: 46.h,
                color: Colors.transparent,
                child: Text(
                  '계정 삭제하기',
                  style: TextStyle(
                      fontSize: 14.sp, color: AppColors.errorRedColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
