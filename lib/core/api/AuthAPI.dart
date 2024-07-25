import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  //프로필 조회 api
  void getUser() async {
    final response = await authService.getUser();
    if (response?.statusCode == 200) {
      updateUser(response?.data['data']);
    } else if (response?.statusCode == 401) {}
  }

  //프로필 변경 api
  void putUser(BuildContext context, Map data) async {
    final response = await authService.putUser(data);
    if (response?.statusCode == 200) {
      getUser();
      context.pop();
    }
  }
}
