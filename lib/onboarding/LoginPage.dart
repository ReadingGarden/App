import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../BottomNaviPage.dart';
import '../core/provider/FcmTokenProvider.dart';
import '../core/service/AuthService.dart';
import '../utils/AppColors.dart';
import '../utils/SharedPreferences.dart';
import '../utils/SocialLogin.dart';
import '../utils/Widgets.dart';

// 이메일, 비밀번호 에러 메시지 상태를 관리하는 프로바이더
final loginErrorProvider = StateProvider<String?>((ref) => null);

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  late FToast fToast;
  String? test;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    Future.microtask(() {
      ref.read(currentIndexProvider.notifier).state = 0;
    });
  }

  //로그인 api
  void postEmailLogin(Map data) async {
    final response = await authService.postLogin(data);
    if (response?.statusCode == 200) {
      // access,refresh 저장하고 가든 페이지로
      saveAccess(response?.data['data']['access_token']);
      saveRefresh(response?.data['data']['refresh_token']);
      context.goNamed('bottom-navi');
    } else if (response?.statusCode == 400) {
      _loginError();
    }
  }

  //로그인 에러
  void _loginError() {
    // TODO - 에러 노티파이어 하나로 합치기
    final emailErrorNotifier = ref.read(loginErrorProvider.notifier);
    final pwdErrorNotifier = ref.read(loginErrorProvider.notifier);

    emailErrorNotifier.state = '등록되지 않은 로그인 정보입니다';
    pwdErrorNotifier.state = '등록되지 않은 로그인 정보입니다';
  }

  @override
  Widget build(BuildContext context) {
    final errorText = ref.watch(loginErrorProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Widgets.appBar(context),
      body: GestureDetector(
        onTap: () {
          // 키보드 내리기
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(
                top: 20.h,
                bottom: (errorText == null) ? 80.h : 40.h,
                left: 24.w,
                right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 44.h),
                  child: Text(
                    '책을 읽어서\n나만의 가든을 꾸며봐요',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                        height: 1.33.h),
                  ),
                ),
                SizedBox(
                    child: Widgets.textfield(ref, _emailController, '이메일',
                        '이메일을 입력해주세요', errorText, loginErrorProvider)),
                Container(
                    margin: EdgeInsets.only(bottom: 24.h),
                    child: Widgets.textfield(ref, _pwdController, '비밀번호',
                        '비밀번호를 입력해주세요', errorText, loginErrorProvider,
                        isPwd: true)),
                Widgets.button('이메일로 로그인', true, () async {
                  // FCM 토큰을 비동기적으로 가져오기
                  final fcmToken = await ref.read(fcmTokenProvider.future);

                  final data = {
                    "user_email": _emailController.text,
                    "user_password": _pwdController.text,
                    "user_fcm": fcmToken ?? '',
                    "user_social_id": "",
                    "user_social_type": ""
                  };
                  postEmailLogin(data);
                }),
                Container(
                  margin: EdgeInsets.only(top: 24.h, bottom: 50.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => context.goNamed('pwd-find'),
                        child: const Text(
                          '비밀번호 찾기',
                          style: TextStyle(color: AppColors.grey_8D),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8.w, right: 10.w),
                        child: const Text(
                          '|',
                          style: TextStyle(color: AppColors.grey_8D),
                        ),
                      ),
                      GestureDetector(
                          onTap: () => context.goNamed('signup'),
                          child: const Text(
                            '회원가입',
                            style: TextStyle(color: AppColors.primaryColor),
                          ))
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.grey_F2,
                ),
                GestureDetector(
                  onTap: () => SocialLogin.googleLogin(ref, context),
                  child: Container(
                    margin: EdgeInsets.only(top: 40.h, left: 58.w, right: 58.w),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween, iOS
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //iOS
                        // CircleAvatar(
                        //   backgroundColor: AppColors.black_59,
                        //   radius: 27.5.r,
                        //   child:
                        //       SvgPicture.asset('assets/images/apple_logo.svg'),
                        // ),
                        CircleAvatar(
                          backgroundColor: AppColors.grey_F2,
                          radius: 27.5.r,
                          child: SvgPicture.asset(
                            'assets/images/google_logo.svg',
                            width: 20.r,
                            height: 20.r,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => SocialLogin.kakaoLogin(ref, context),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xffFFEF5E),
                            radius: 27.5.r,
                            child: SvgPicture.asset(
                              'assets/images/kakao_logo.svg',
                              width: 20.r,
                              height: 20.r,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
