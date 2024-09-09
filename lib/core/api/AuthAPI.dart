import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/SharedPreferences.dart';
import '../service/AuthService.dart';

final userProvider = StateProvider<Map>((ref) => {});
// {user_no: 34, user_nick: 냐하하, user_email: ella@acryl.ai, user_social_type: , user_image: image1, user_created_at: 2024-06-14T00:19:40, garden_count: 1, read_book_count: 0, like_book_count: 0}

class AuthAPI {
  final WidgetRef ref;

  AuthAPI(this.ref);

  Map user() {
    return ref.watch(userProvider);
  }

  void updateUser(Map newState) {
    ref.read(userProvider.notifier).state = newState;
  }

  void resetUser() {
    ref.read(userProvider.notifier).state = {};
  }

  //MARK: - API
  //소셜 로그인 api
  void postSocialLogin(BuildContext context, Map data) async {
    final response = await authService.postLogin(data);
    if (response?.statusCode == 200) {
      //access,refresh 저장하고 가든 페이지로
      saveAccess(response?.data['data']['access_token']);
      saveRefresh(response?.data['data']['refresh_token']);
      context.goNamed('bottom-navi');
    } else if (response?.statusCode == 400) {
      postSocialSignup(context, data);
    }
  }

  //소셜 회원가입 api
  void postSocialSignup(BuildContext context, Map data) async {
    final response = await authService.postSignup(data);
    if (response?.statusCode == 201) {
      //access,refresh 저장하고 회원가입 완료 페이지로
      //TODO: - 회원가입 토큰 저장
      // saveAccess(response?.data['data']['access_token']);
      // saveRefresh(response?.data['data']['refresh_token']);
      context.goNamed('signup-done');
    } else if (response?.statusCode == 400) {}
  }

  //프로필 조회 api
  void getUser(BuildContext context) async {
    final response = await authService.getUser();
    if (response?.statusCode == 200) {
      updateUser(response?.data['data']);
    } else if (response?.statusCode == 401) {
      context.go('/start');
    }
  }

  //프로필 변경 api
  void putUser(BuildContext context, Map data) async {
    final response = await authService.putUser(data);
    if (response?.statusCode == 200) {
      getUser(context);
      context.pop();
    }
  }
}
