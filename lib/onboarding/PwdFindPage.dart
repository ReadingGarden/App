import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';
import 'OnboardingProvider.dart';

// 이메일 에러 메시지 상태를 관리하는 프로바이더
final emailErrorProvider = StateProvider<String?>((ref) => null);
// 인증번호 에러 메시지 상태를 관리하는 프로바이더
final authErrorProvider = StateProvider<String?>((ref) => null);
// 인증 번호 전송 버튼 활성화 상태를 관리하는 프로바이더
final authButtonProvider = StateProvider<bool>((ref) => false);
// 인증 번호 전송 상태를 관리하는 프로바이더
final authSendProvider = StateProvider<bool>((ref) => false);
// 인증 번호 입력 상태를 관리하는 프로바이더
final authCheckProvider = StateProvider<bool>((ref) => false);

class PwdFindPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _authController = TextEditingController();

  // 인증번호 전송 후
  bool isAuthSend = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 이메일 텍스트 필드 에러 메세지 상태 구독
    final emailErrorText = ref.watch(emailErrorProvider);
    // 인증번호 텍스트 필드 에러 메세지 상태 구독
    final authErrorText = ref.watch(authErrorProvider);
    // 인증번호 전송 버튼 상태 구독
    final authButtonBool = ref.watch(authButtonProvider);
    // 인증번호 전송 상태 구독
    final authSendBool = ref.watch(authSendProvider);
    // 인즡번호 입력 상태 구독
    final authCheckBool = ref.watch(authCheckProvider);

    void postPwdFind(context, ref) async {
      ref.read(authButtonProvider.notifier).state = false;

      final data = {"user_email": _emailController.text};

      final response =
          await ref.read(OnboardingProvider.postPwdFindProvider(data).future);
      if (response?.statusCode == 200) {
        ref.read(authSendProvider.notifier).state = true;
      } else if (response?.statusCode == 400) {
        ref.read(emailErrorProvider.notifier).state = '등록되지 않은 이메일 주소입니다';
      }
    }

    void postPwdFindCheck(BuildContext context, ref) async {
      final data = {
        "user_email": _emailController.text,
        "auth_number": _authController.text
      };

      final response = await ref
          .read(OnboardingProvider.postPwdFindCheckProvider(data).future);
      if (response?.statusCode == 200) {
        context.goNamed('pwd-setting', extra: _emailController.text);
      } else if (response?.statusCode == 400) {
        ref.read(authErrorProvider.notifier).state = '인증번호 불일치';
      }
    }

    void _emailValidate() {
      if (!Functions.emailValidation(_emailController.text)) {
        ref.read(emailErrorProvider.notifier).state = '올바르지 않은 이메일 형식이에요';
      } else {
        ref.read(emailErrorProvider.notifier).state = null;
      }

      // 최종 확인
      if (ref.read(emailErrorProvider.notifier).state == null) {
        ref.read(authButtonProvider.notifier).state = true;
      }
    }

    void _authValidate() {
      if (_authController.text.length == 5) {
        ref.read(authCheckProvider.notifier).state = true;
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Widgets.appBar(context),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(bottom: 60.h),
                        height: 36.h,
                        child: Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.sp),
                        )),
                    SizedBox(
                        child: Widgets.textfield(ref, _emailController, '이메일',
                            '이메일을 입력해주세요', emailErrorText, emailErrorProvider,
                            validateFunction: _emailValidate)),
                    (!authSendBool)
                        ? Container(
                            padding: EdgeInsets.only(top: 8.h, bottom: 24.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 4.h),
                                    height: 20.h,
                                    child: const Text('인증번호')),
                                Container(
                                  height: 54.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: const Color(0xFFF1F3F5)),
                                )
                              ],
                            ),
                          )
                        : Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              SizedBox(
                                child: Widgets.textfield(
                                    ref,
                                    _authController,
                                    '인증번호',
                                    '대소문자에 유의하여 입력해주세요',
                                    authErrorText,
                                    authErrorProvider,
                                    validateFunction: _authValidate),
                              ),
                              Container(
                                  height: 20.h,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          (authErrorText == null) ? 42.h : 52.h,
                                      right: 16.w),
                                  child: Text(
                                    '03:00',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor),
                                  )),
                            ],
                          ),
                  ],
                ),
              ],
            ),
          )),
        ),
        bottomNavigationBar: (authSendBool)
            ? Container(
                margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
                child: Widgets.button(
                  '다음',
                  authCheckBool,
                  () => postPwdFindCheck(context, ref),
                ))
            : Container(
                margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
                child: Widgets.button(
                  '인증번호\n전송',
                  authButtonBool,
                  () => postPwdFind(context, ref),
                )));
  }
}
