import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/SharedPreferences.dart';
import '../service/AuthService.dart';

class AuthServiceProvider {
  // AuthService 인스턴스를 제공하는 프로바이더
  static final authServiceProvider = Provider<AuthService>((ref) {
    return AuthService();
  });

  // POST(Login) 요청을 처리하는 FutureProvider
  static final postLoginProvider =
      FutureProvider.family<Response?, Map>((ref, data) async {
    final authService = ref.watch(authServiceProvider);
    return authService.postLogin(data);
  });

  // POST(Signup) 요청을 처리하는 FutureProvider
  static final postSignupProvider =
      FutureProvider.family<Response?, Map>((ref, data) async {
    final authService = ref.watch(AuthServiceProvider.authServiceProvider);
    return authService.postSignup(data);
  });

  // POST(Pwd-Find) 요청을 처리하는 FutureProvider
  static final postPwdFindProvider =
      FutureProvider.family<Response?, Map>((ref, data) async {
    final authService = ref.watch(AuthServiceProvider.authServiceProvider);
    return authService.postPwdFind(data);
  });

  // POST(Pwd-Find Check) 요청을 처리하는 ...
  static final postPwdFindCheckProvider =
      FutureProvider.family<Response?, Map>((ref, data) async {
    final authService = ref.watch(AuthServiceProvider.authServiceProvider);
    return authService.postPwdFindCheck(data);
  });

  // PUT(Pwd-Update) 요청을 처리하는 ...
  static final putPwdUpdateProvider =
      FutureProvider.family<Response?, Map>((ref, data) async {
    final authService = ref.watch(AuthServiceProvider.authServiceProvider);
    return authService.putPwdUpdate(data);
  });

  // GET(Profile) 요청을 처리하는 ...
  static final getProfileProvider = FutureProvider<Response?>((ref) async {
    final authService = ref.watch(AuthServiceProvider.authServiceProvider);
    final accessToken = await loadAccess();
    return authService.getProfile(accessToken);
  });
}
