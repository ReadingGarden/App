import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/provider/FcmTokenProvider.dart';
import '../core/service/AuthService.dart';
import '../utils/AppColors.dart';
import '../utils/Functions.dart';
import '../utils/SharedPreferences.dart';
import '../utils/Widgets.dart';

// 이메일 에러 메시지 상태를 관리하는 프로바이더
final emailErrorProvider = StateProvider<String?>((ref) => null);
// 비밀번호 에러 메시지 상태를 관리하는 프로바이더
final pwdErrorProvider = StateProvider<String?>((ref) => null);
// 비밀번호 확인 에러 메시지 상태를 관리하는 프로바이더
final pwdCheckErrorProvider = StateProvider<String?>((ref) => null);

class SignupPage extends ConsumerStatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdCheckController = TextEditingController();

  bool isValid = false;

  @override
  void initState() {
    Future.microtask(() {
      ref.read(emailErrorProvider.notifier).state = null;
      ref.read(pwdErrorProvider.notifier).state = null;
      ref.read(pwdCheckErrorProvider.notifier).state = null;
    });
    super.initState();
  }

  void postSignup(BuildContext context, WidgetRef ref) async {
    // FCM 토큰을 비동기적으로 가져오기
    final fcmToken = await ref.read(fcmTokenProvider.future);

    final data = {
      "user_email": _emailController.text,
      "user_password": _pwdController.text,
      "user_fcm": fcmToken ?? '',
      "user_social_id": "",
      "user_social_type": ""
    };

    final response = await authService.postSignup(data);
    if (response?.statusCode == 201) {
      //access,refresh 저장하고 회원가입 완료 페이지로
      saveAccess(response?.data['data']['access_token']);
      saveRefresh(response?.data['data']['refresh_token']);
      context.goNamed('signup-done',
          extra: response?.data['data']['user_nick']);
    } else if (response?.statusCode == 400) {}
  }

  void _validate() {
    final emailErrorNotifier = ref.read(emailErrorProvider.notifier);
    final pwdErrorNotifier = ref.read(pwdErrorProvider.notifier);
    final pwdCheckErrorNotifier = ref.read(pwdCheckErrorProvider.notifier);
    if (!Functions.emailValidation(_emailController.text)) {
      emailErrorNotifier.state = '올바르지 않은 이메일 형식이에요';
      isValid = false;
    } else {
      emailErrorNotifier.state = null;
    }
    if (_pwdController.text.length < 6 || _pwdController.text.length > 12) {
      pwdErrorNotifier.state = '비밀번호 규칙을 확인해주세요';
      isValid = false;
    } else {
      pwdErrorNotifier.state = null;
    }
    if (_pwdController.text != _pwdCheckController.text) {
      pwdCheckErrorNotifier.state = '동일한 비밀번호를 입력해주세요';
      isValid = false;
    } else {
      pwdCheckErrorNotifier.state = null;
    }

    // 최종 확인
    if (emailErrorNotifier.state == null &&
        pwdErrorNotifier.state == null &&
        pwdCheckErrorNotifier.state == null) {
      isValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailErrorText = ref.watch(emailErrorProvider);
    final pwdErrorText = ref.watch(pwdErrorProvider);
    final pwdCheckErrorText = ref.watch(pwdCheckErrorProvider);

    return Scaffold(
        appBar: Widgets.appBar(context),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(
                  top: 20.h, bottom: 38.h, left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(bottom: 62.h),
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24.sp),
                      )),
                  SizedBox(
                      child: Widgets.textfield(ref, _emailController, '이메일',
                          '이메일을 입력해주세요', emailErrorText, emailErrorProvider,
                          validateFunction: _validate)),
                  SizedBox(
                      child: Widgets.textfield(
                          ref,
                          _pwdController,
                          '비밀번호',
                          '6자 이상 12자 이하로 입력해주세요',
                          pwdErrorText,
                          pwdErrorProvider,
                          validateFunction: _validate,
                          isPwd: true)),
                  SizedBox(
                      child: Widgets.textfield(
                          ref,
                          _pwdCheckController,
                          '비밀번호 확인',
                          '비밀번호를 다시 입력해주세요',
                          pwdCheckErrorText,
                          pwdCheckErrorProvider,
                          validateFunction: _validate,
                          isPwd: true)),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          height: 120.h,
          // margin:
          //     EdgeInsets.only(top: (pwdCheckErrorText == null) ? 117.h : 57.h),
          child: Column(
            children: [
              Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      style:
                          TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
                      children: [
                        const TextSpan(text: '이메일로 회원가입 시 '),
                        TextSpan(
                            text: '이용약관',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.grey_8D),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Functions.launchURL(
                                    "https://www.notion.so/dokseogarden/825ddd95b1084d689c4275ae665510b5?pvs=4");
                              }),
                        const TextSpan(
                          text: ' 및\n',
                        ),
                        TextSpan(
                            text: '개인정보수집이용',
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.grey_8D),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Functions.launchURL(
                                    "https://www.notion.so/1182d8001a928098bb71c78cc5523cd4?pvs=21");
                              }),
                        const TextSpan(text: '에 동의하는 것으로 간주됩니다')
                      ])),
              Container(
                margin: EdgeInsets.only(top: 24.h),
                child: Widgets.button(
                  '이메일로 회원가입',
                  isValid,
                  () => postSignup(context, ref),
                ),
              )
            ],
          ),
        ));
  }
}

class SignupDonePage extends StatelessWidget {
  final String user_nick;

  const SignupDonePage({super.key, required this.user_nick});

  // 회원가입 완료 -> 가든 페이지로
  void singupEnd(BuildContext context) {
    context.go('/bottom-navi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.h,
          backgroundColor: Colors.white,
          leadingWidth: 0,
          leading: Container(),
        ),
        body: Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 20.h, left: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: Text.rich(TextSpan(
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.w600),
                        children: [
                          const TextSpan(text: '반가워요, '),
                          TextSpan(
                              text: user_nick,
                              style: const TextStyle(
                                  color: AppColors.primaryColor)),
                          const TextSpan(text: '님')
                        ])),
                  ),
                  Text(
                    '독서가든의 가드너가 되신걸 환영합니다!\n시작하기를 눌러 나의 첫번째 가든을 확인해보세요.',
                    style: TextStyle(
                      color: AppColors.grey_8D,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 40.h, left: 12.w),
                width: 312.r,
                height: 312.r,
                child: Image.asset(
                  'assets/images/signup.png',
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
          child: Widgets.button('시작하기', true, () => singupEnd(context)),
        ));
  }
}
