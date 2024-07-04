import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/model/User.dart';
import '../core/provider/AuthServiceProvider.dart';
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

  //프로필 변경 api
  void putProfile() async {
    final data = {
      "user_nick": _nicknameController.text,
    };
    final response =
        await ref.read(AuthServiceProvider.putProfileProvider(data).future);
    if (response?.statusCode == 200) {
      final user = User.fromJson(response?.data['data']);
      ref.read(userProvider.notifier).updateUser(user);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    //닉네임 텍스트 필드 에러 메세지 상태 구독
    final nicknameErrorText = ref.watch(nicknameErrorProvider);

    //User 모델 상태 구독
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '닉네임'),
      body: Container(
          margin: EdgeInsets.only(top: 10.h, left: 24.w, right: 24.w),
          child: Widgets.textfield(ref, _nicknameController, '닉네임',
              user?.user_nick ?? '', nicknameErrorText, nicknameErrorProvider)),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
        child: Widgets.button('저장하기', true, () => putProfile()),
      ),
    );
  }
}
