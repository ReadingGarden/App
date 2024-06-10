import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'OnboardingService.dart';

class OnboardingProvider {
  // OnboardingService 인스턴스를 제공하는 프로바이더
  static final onboardingServiceProvider = Provider<OnboardingService>((ref) {
    return OnboardingService();
  });

  // POST(Login) 요청을 처리하는 FutureProvider
  static final postLoginProvider =
      FutureProvider.family<Response?, Map>((ref, data) async {
    final onboardingService = ref.watch(onboardingServiceProvider);
    return onboardingService.postLogin(data);
  });

  // POST(Signup) 요청을 처리하는 FutureProvider
  static final postSignupProvider =
      FutureProvider.family<Response?, Map>((ref, data) async {
    final onboardingService =
        ref.watch(OnboardingProvider.onboardingServiceProvider);
    return onboardingService.postSignup(data);
  });
}
