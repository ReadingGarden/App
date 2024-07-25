import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/api/AuthAPI.dart';
import '../utils/Widgets.dart';

//닉네임 에러 메세지...
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

  @override
  Widget build(BuildContext context) {
    final authAPI = AuthAPI(ref);
    //닉네임 텍스트 필드 에러 메세지
    final nicknameErrorText = ref.watch(nicknameErrorProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '닉네임'),
      body: Container(
          margin: EdgeInsets.only(top: 10.h, left: 24.w, right: 24.w),
          child: Widgets.textfield(
              ref,
              _nicknameController,
              '닉네임',
              authAPI.user()['user_nick'],
              nicknameErrorText,
              nicknameErrorProvider)),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
        child: Widgets.button('저장하기', true, () {
          final data = {
            "user_nick": _nicknameController.text,
          };
          authAPI.putUser(context, data);
        }),
      ),
    );
  }
}
