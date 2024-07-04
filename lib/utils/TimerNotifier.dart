import 'dart:async';

import 'package:book_flutter/onboarding/PwdFindPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TimerNotifier 클래스를 생성하여 타이머 상태 관리
class TimerNotifier extends StateNotifier<int> {
  TimerNotifier(this.ref) : super(300); //초기값을 300초(5분)으로 설정
  final Ref ref;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
        ref.read(authErrorProvider.notifier).state = null;
        ref.read(authButtonProvider.notifier).state = false;
      } else {
        timer.cancel();
        ref.read(authErrorProvider.notifier).state =
            '인증 시간이 만료되었어요. 다시 인증해주세요.';
        ref.read(authButtonProvider.notifier).state = true;
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    state = 300; //타이머를 다시 300초로 초기화
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

//TimerNotifier를 제공하는 Provider 생성
final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier(ref);
});
