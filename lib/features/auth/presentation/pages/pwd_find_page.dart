import 'package:book_flutter/shared/utils/functions.dart';
import 'package:book_flutter/features/auth/presentation/providers/timer_notifier.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/auth/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

// 이메일 에러 메시지 상태를 관리하는 프로바이더
final emailErrorProvider = StateProvider<String?>((ref) => null);
// 인증번호 에러 메시지 상태를 관리하는 프로바이더
final authErrorProvider = StateProvider<String?>((ref) => null);
// 인증번호 전송 버튼 활성화 상태를 관리하는 프로바이더
final authButtonProvider = StateProvider<bool>((ref) => false);
// 인증번호 전송 상태를 관리하는 프로바이더
final authSendProvider = StateProvider<bool>((ref) => false);
// 인증번호 입력 상태를 관리하는 프로바이더
final authCheckProvider = StateProvider<bool>((ref) => false);
// 인증번호 전송 (재전송) 텍스트 상태를 관리하는 ...
final authSendTextProvider = StateProvider<String>((ref) => '인증번호 전송');

class PwdFindPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<PwdFindPage> createState() => _PwdFindPageState();

  const PwdFindPage({super.key});
}

class _PwdFindPageState extends ConsumerState<PwdFindPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _authController = TextEditingController();

  late FToast fToast;

  // 인증번호 전송 후
  bool isAuthSend = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    //상태 초기화
    Future.microtask(() {
      ref.read(emailErrorProvider.notifier).state = null;
      ref.read(authErrorProvider.notifier).state = null;
      ref.read(authButtonProvider.notifier).state = false;
      ref.read(authSendProvider.notifier).state = false;
      ref.read(authCheckProvider.notifier).state = false;
      ref.read(authSendTextProvider.notifier).state = '인증번호 전송';
      ref.read(timerProvider.notifier).resetTimer();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    //타이머
    final timeRemaining = ref.watch(timerProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    //인증번호 전송 api
    void postPwdFind() async {
      ref.read(authButtonProvider.notifier).state = false;

      final data = {"user_email": _emailController.text};

      final response = await authService.postPwdFind(data);
      if (!mounted) return;
      if (response?.statusCode == 200) {
        Widgets.showSuccessToast(context, '인증번호가 발송되었습니다');
        ref.read(authSendProvider.notifier).state = true;
        ref.read(timerProvider.notifier).resetTimer();
        timerNotifier.startTimer();
      } else if (response?.statusCode == 400) {
        ref.read(emailErrorProvider.notifier).state = '등록되지 않은 이메일 주소입니다';
      }
    }

    //비밀번호 인증 확인 api
    void postPwdFindCheck(BuildContext context, ref) async {
      final data = {
        "user_email": _emailController.text,
        "auth_number": _authController.text
      };

      final response = await authService.postPwdFindCheck(data);
      if (!context.mounted) return;
      if (response?.statusCode == 200) {
        context.goNamed('pwd-setting',
            extra: {'user_email': _emailController.text, 'isLoginPage': true});
      } else if (response?.statusCode == 400) {
        ref.read(authErrorProvider.notifier).state = '인증번호가 일치하지 않아요';
      }
    }

    void emailValidate() {
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

    void authValidate() {
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
                        child: Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.sp),
                        )),
                    SizedBox(
                        child: Widgets.textfield(ref, _emailController, '이메일',
                            '이메일을 입력해주세요', emailErrorText, emailErrorProvider,
                            validateFunction: emailValidate)),
                    (authSendBool)
                        ? Stack(
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
                                    validateFunction: authValidate),
                              ),
                              Container(
                                  height: 20.h,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          (authErrorText == null) ? 30.h : 52.h,
                                      right: 16.w),
                                  child: Text(
                                    '${(timeRemaining ~/ 60).toString().padLeft(2, '0')}:${(timeRemaining % 60).toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColor),
                                  )),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          )),
        ),
        bottomNavigationBar: (authSendBool && (timeRemaining != 0))
            ? Widgets.bottomBar(context,
                child: Widgets.button(
                  '다음',
                  authCheckBool,
                  () => postPwdFindCheck(context, ref),
                ))
            : Widgets.bottomBar(context,
                child: Widgets.button(
                  ref.watch(authSendTextProvider),
                  authButtonBool,
                  () => postPwdFind(),
                )));
  }
}
