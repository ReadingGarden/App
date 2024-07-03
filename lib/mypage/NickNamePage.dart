import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/User.dart';
import '../core/provider/AuthServiceProvider.dart';
import '../core/provider/ResponseProvider.dart';
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
    final response =
        await ref.read(AuthServiceProvider.getProfileProvider.future);
    if (response?.statusCode == 200) {
      final userData =
          User.fromJson(response?.data['data'] as Map<String, dynamic>);
      ref.read(userProvider.notifier).updateUser(userData);
      print('성공');
    }
  }

  //프로필 변경 api
  void putProfile() async {
    final data = {
      "user_nick": _nicknameController.text,
    };
    final response =
        await ref.read(AuthServiceProvider.putProfileProvider(data).future);
    if (response?.statusCode == 200) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //닉네임 텍스트 필드 에러 메세지 상태 구독
    final nicknameErrorText = ref.watch(nicknameErrorProvider);

    final userResponse = ref.watch(userResponseProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '닉네임'),
      body: Container(
          margin: EdgeInsets.only(top: 10.h, left: 24.w, right: 24.w),
          child: Widgets.textfield(
              ref,
              _nicknameController,
              '닉네임',
              userResponse['user_nick'] ?? '',
              nicknameErrorText,
              nicknameErrorProvider)),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
        child: Widgets.button('저장하기', true, () => putProfile()),
      ),
    );
  }
}
