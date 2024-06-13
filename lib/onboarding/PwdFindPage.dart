import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/AppColors.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

// 이메일 에러 메시지 상태를 관리하는 프로바이더
final emailErrorProvider = StateProvider<String?>((ref) => null);
// 인증번호 에러 메시지 상태를 관리하는 프로바이더
final authErrorProvider = StateProvider<String?>((ref) => null);
// 인증 번호 전송 버튼 활성화 상태를 관리하는 프로바이더
final authButtonProvider = StateProvider<bool>((ref) => false);
// 인증 번호 전송 상태를 관리하는 프로바이더
final authSendProvider = StateProvider<bool>((ref) => false);

class PwdFindPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _authController = TextEditingController();

  // 인증번호 전송 후
  bool isAuthSend = false;
  // 다음 버튼 활성화 여부
  bool isNext = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailErrorText = ref.watch(emailErrorProvider);
    final authErrorText = ref.watch(authErrorProvider);

    // 인증번호 전송 버튼 상태 구독
    final authButtonBool = ref.watch(authButtonProvider);

    // 인증번호 전송 상태 구독
    final authSendBool = ref.watch(authSendProvider);
    final authSendNotifier = ref.read(authSendProvider.notifier);

    void _emailValidate() {
      final emailErrorNotifier = ref.read(emailErrorProvider.notifier);

      if (!Functions.emailValidation(_emailController.text)) {
        emailErrorNotifier.state = '올바르지 않은 이메일 형식이에요';
      } else {
        emailErrorNotifier.state = null;
      }

      // 최종 확인
      if (emailErrorNotifier.state == null) {
        ref.read(authButtonProvider.notifier).state = true;
      }
    }

    void _authValidate() {
      final authErrorNotifier = ref.read(authErrorProvider.notifier);

      // TODO: - 인증 번호 에러 메세지 적용

      // if (_authController.text.length < 6 || _authController.text.length > 12) {
      //   authErrorNotifier.state = '에러메세지를 입력해주세요';
      // } else {
      //   authErrorNotifier.state = null;
      // }
      if (_authController.text.length == 6) {
        isNext = true;
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
                                  // alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(
                                      bottom: 42.h, right: 16.w),
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
                  isNext,
                  () {
                    //TODO: - 비밀번호 설정 페이지로
                    // authSendNotifier.state = true;
                  },
                ))
            : Container(
                margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
                child: Widgets.button(
                  '인증번호\n전송',
                  authButtonBool,
                  () {
                    // TODO: - 전송 api 안에서 변경
                    authSendNotifier.state = true;
                  },
                )));
  }
}
