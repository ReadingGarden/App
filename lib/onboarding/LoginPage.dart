import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
// import '../utils/SharedPreferences.dart';
import '../utils/Widgets.dart';
import 'OnboardingProvider.dart';

// 이메일, 비밀번호 에러 메시지 상태를 관리하는 프로바이더
final loginErrorProvider = StateProvider<String?>((ref) => null);

class LoginPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  void postLogin(BuildContext context, WidgetRef ref) async {
    final data = {
      "user_email": _emailController.text,
      "user_password": _pwdController.text,
      "use_fcm": "",
      "user_social_id": "",
      "user_social_type": ""
    };

    final response =
        await ref.read(OnboardingProvider.postLoginProvider(data).future);
    if (response?.statusCode == 200) {
      // 가든 페이지로
      context.goNamed('garden');
    } else if (response?.statusCode == 400) {
      _loginError(context, ref);
    }
  }

  void _loginError(BuildContext context, WidgetRef ref) {
    // TODO - 에러 노디파이어 하나로 합치기
    final emailErrorNotifier = ref.read(loginErrorProvider.notifier);
    final pwdErrorNotifier = ref.read(loginErrorProvider.notifier);

    emailErrorNotifier.state = '등록되지 않은 로그인 정보입니다';
    pwdErrorNotifier.state = '등록되지 않은 로그인 정보입니다';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(loginErrorProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Widgets.appBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(top: 20.h, bottom: 60.h, left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: 60.h),
                height: 72.h,
                child: Text(
                  '책을 읽어서\n나만의 가든을 꾸며봐요',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ),
              SizedBox(
                  child: Widgets.textfield(ref, _emailController, '이메일',
                      '이메일을 입력해주세요', errorText, loginErrorProvider)),
              Container(
                  margin: EdgeInsets.only(bottom: 24.h),
                  child: Widgets.textfield(ref, _pwdController, '비밀번호',
                      '비밀번호를 입력해주세요', errorText, loginErrorProvider)),
              Widgets.button('이메일로\n로그인', true, () => postLogin(context, ref)),
              Container(
                margin: EdgeInsets.only(top: 18.h, bottom: 56.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '비밀번호 찾기',
                      style: TextStyle(color: AppColors.textGreyColor),
                    ),
                    const SizedBox(
                      height: 10,
                      child: VerticalDivider(
                        thickness: 1,
                        color: AppColors.textGreyColor,
                      ),
                    ),
                    GestureDetector(
                        onTap: () => context.goNamed('signup'),
                        child: Text(
                          '회원가입',
                          style: TextStyle(color: AppColors.primaryColor),
                        ))
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: AppColors.dividerGreyColor,
              ),
              Container(
                margin: EdgeInsets.only(top: 40.h, left: 58.w, right: 58.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF2E2E2E),
                      radius: 27.5.r,
                      child: SvgPicture.asset('assets/images/apple_logo.svg'),
                    ),
                    CircleAvatar(
                      backgroundColor: const Color(0xFFF5F5F5),
                      radius: 27.5.r,
                      child: SvgPicture.asset('assets/images/google_logo.svg'),
                    ),
                    CircleAvatar(
                      backgroundColor: const Color(0xFFFFEF5E),
                      radius: 27.5.r,
                      child: SvgPicture.asset('assets/images/kakao_logo.svg'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
