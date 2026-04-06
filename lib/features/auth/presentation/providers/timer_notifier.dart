import 'dart:async';

import 'package:book_flutter/features/auth/presentation/pages/pwd_find_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier(this.ref) : super(300);

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
        ref.read(authSendTextProvider.notifier).state = '인증번호 재전송';
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    state = 300;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier(ref);
});
