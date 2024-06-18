import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';
import 'OnboardingProvider.dart';

// 비밀번호 에러 메시지 상태를 관리하는 프로바이더
final pwdErrorProvider = StateProvider<String?>((ref) => null);
// 비밀번호 확인 에러 메시지 상태를 관리하는 프로바이더
final pwdCheckErrorProvider = StateProvider<String?>((ref) => null);
// 비밀번호 유효성 상태를 관리하는 프로바이더
final isValidProvider = StateProvider<bool>((ref) => false);

class PwdSettingPage extends ConsumerWidget {
  final String user_email;

  PwdSettingPage({required this.user_email});

  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdCheckController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pwdErrorText = ref.watch(pwdErrorProvider);
    final pwdCheckErrorText = ref.watch(pwdCheckErrorProvider);
    final isValid = ref.watch(isValidProvider);

    void putPwdUpdate() async {
      final data = {
        "user_email": user_email,
        "user_password": _pwdController.text
      };

      final response =
          await ref.read(OnboardingProvider.putPwdUpdateProvider(data).future);
      if (response?.statusCode == 200) {
        // TODO: - 새로운 비밀번호가 생성되었습니다 토스트
        context.goNamed('login');
      }
    }

    void _validate() {
      final pwdErrorNotifier = ref.read(pwdErrorProvider.notifier);
      final pwdCheckErrorNotifier = ref.read(pwdCheckErrorProvider.notifier);
      final isValidNotifier = ref.read(isValidProvider.notifier);

      bool isPwdValid = true;
      bool isPwdCheckValid = true;

      if (_pwdController.text.length < 6 || _pwdController.text.length > 12) {
        pwdErrorNotifier.state = '비밀번호 규칙을 확인해주세요';
        isPwdValid = false;
      } else {
        pwdErrorNotifier.state = null;
      }
      if (_pwdController.text != _pwdCheckController.text) {
        pwdCheckErrorNotifier.state = '동일한 비밀번호를 입력해주세요';
        isPwdCheckValid = false;
      } else {
        pwdCheckErrorNotifier.state = null;
      }

      // 최종 확인
      isValidNotifier.state = isPwdValid && isPwdCheckValid;
    }

    return Scaffold(
        appBar: Widgets.appBar(context),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: 20.h, bottom: 32.h, left: 24.w, right: 24.w),
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
                            '비밀번호 설정하기',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24.sp),
                          )),
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
          child: Widgets.button(
            '비밀번호\n저장하기',
            !isValid,
            () => putPwdUpdate(),
          ),
        ));
  }
}
