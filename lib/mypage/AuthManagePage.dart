import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/api/AuthAPI.dart';
import '../core/service/AuthService.dart';
import '../utils/AppColors.dart';
import '../utils/SharedPreferences.dart';
import '../utils/Widgets.dart';

class AuthManagePage extends ConsumerStatefulWidget {
  @override
  _AuthManagePageState createState() => _AuthManagePageState();
}

class _AuthManagePageState extends ConsumerState<AuthManagePage> {
  void postLogout() async {
    final response = await authService.postLogout();
    if (response?.statusCode == 200) {
      context.pop();
      removeLoginInfo();
      context.goNamed('start');
    }
  }

  void deleteUser() async {
    final response = await authService.deleteUser();
    if (response?.statusCode == 200) {
      context.pop();
      removeLocalStorage();
      context.goNamed('start');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAPI = AuthAPI(ref);

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
                  'user_email': authAPI.user()['user_email'],
                  'isLoginPage': false
                });
              },
              widget: Container(
                alignment: Alignment.center,
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(
                  'assets/images/angle-right-b.svg',
                ),
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
                  '게정 삭제하기',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.errorRedColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
