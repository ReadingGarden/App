import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/provider/ResponseProvider.dart';
import '../core/service/AuthService.dart';
import '../utils/Widgets.dart';

// 닉네임 에러 메시지 상태를 관리하는 프로바이더
final nicknameErrorProvider = StateProvider<String?>((ref) => null);

class NickNamePage extends ConsumerStatefulWidget {
  @override
  _NickNamePageState createState() => _NickNamePageState();
}

class _NickNamePageState extends ConsumerState<NickNamePage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  //프로필 조회 api
  void getProfile() async {
    final response = await authService.getProfile();
    if (response?.statusCode == 200) {
      ref.read(responseProvider.userMapProvider.notifier).state =
          response?.data['data'];
      // final user = User.fromJson(response?.data['data']);
      // ref.read(userProvider.notifier).updateUser(user);
    }
  }

  //프로필 변경 api
  void putProfile() async {
    final data = {
      "user_nick": _nicknameController.text,
    };
    final response = await authService.putProfile(data);
    if (response?.statusCode == 200) {
      getProfile();
      // final user = User.fromJson(response?.data['data']);
      // ref.read(userProvider.notifier).updateUser(user);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //닉네임 텍스트 필드 에러 메세지 상태 구독
    final nicknameErrorText = ref.watch(nicknameErrorProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '닉네임'),
      body: Container(
          margin: EdgeInsets.only(top: 10.h, left: 24.w, right: 24.w),
          child: Widgets.textfield(
              ref,
              _nicknameController,
              '닉네임',
              ref.watch(responseProvider.userMapProvider)?['user_nick'] ?? '',
              nicknameErrorText,
              nicknameErrorProvider)),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
        child: Widgets.button('저장하기', true, () => putProfile()),
      ),
    );
  }
}
