import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../utils/Functions.dart';
import '../utils/SharedPreferences.dart';
import '../utils/Widgets.dart';
import 'OnboardingProvider.dart';

// 이메일 에러 메시지 상태를 관리하는 프로바이더
final emailErrorProvider = StateProvider<String?>((ref) => null);
// 비밀번호 에러 메시지 상태를 관리하는 프로바이더
final pwdErrorProvider = StateProvider<String?>((ref) => null);
// 비밀번호 확인 에러 메시지 상태를 관리하는 프로바이더
final pwdCheckErrorProvider = StateProvider<String?>((ref) => null);

class SignupPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdCheckController = TextEditingController();

  bool isValid = false;

  void postSignup(BuildContext context, WidgetRef ref) async {
    final data = {
      "user_email": _emailController.text,
      "user_password": _pwdController.text,
      "use_fcm": "",
      "user_social_id": "",
      "user_social_type": ""
    };

    final response =
        await ref.read(OnboardingProvider.postSignupProvider(data).future);
    if (response?.statusCode == 201) {
      // 회원가입 완료 페이지로
      context.goNamed('signup-end');
    } else if (response?.statusCode == 400) {
      print('e400');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailErrorText = ref.watch(emailErrorProvider);
    final pwdErrorText = ref.watch(pwdErrorProvider);
    final pwdCheckErrorText = ref.watch(pwdCheckErrorProvider);

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
      if (_pwdController.text.isEmpty ||
          _pwdController.text.length < 6 ||
          _pwdController.text.length > 12) {
        pwdErrorNotifier.state = '비밀번호 규칙을 확인해주세요';
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Widgets.appBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('회원가입'),
                SizedBox(
                    child: Widgets.textfield(ref, _emailController, '이메일',
                        '이메일을 입력해주세요', emailErrorText, emailErrorProvider,
                        validateFunction: _validate)),
                SizedBox(
                    child: Widgets.textfield(ref, _pwdController, '비밀번호',
                        '6자 이상 12자 이하로 입력해주세요', pwdErrorText, pwdErrorProvider,
                        validateFunction: _validate)),
                SizedBox(
                    child: Widgets.textfield(
                        ref,
                        _pwdCheckController,
                        '비밀번호 확인',
                        '비밀번호를 다시 입력해주세요',
                        pwdCheckErrorText,
                        pwdCheckErrorProvider,
                        validateFunction: _validate)),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                color: Colors.blue,
                child: Column(
                  children: [
                    const Text(
                      '이메일로 회원가입 시 이용약관 및\n개인정보수집이용에 동의하는 것으로 간주됩니다',
                      textAlign: TextAlign.center,
                    ),
                    Widgets.button(
                      '이메일로\n회원가입',
                      isValid,
                      () => postSignup(context, ref),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class SignupEndPage extends StatelessWidget {
  // 회원가입 완료 -> 가든 페이지로
  void singupEnd(BuildContext context) {
    context.goNamed('garden');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.amberAccent,
              ),
              Text('새로운 가드너 탄생'),
              Text('나의 첫번째 가든을 확인해보세요!'),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          Expanded(
              child: Widgets.button('시작하기', true, () => singupEnd(context)))
        ],
      ),
    );
  }
}
