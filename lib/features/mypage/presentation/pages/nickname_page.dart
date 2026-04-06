import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/auth/presentation/providers/auth_user_provider.dart';

//닉네임 에러 메세지...
final nicknameErrorProvider = StateProvider<String?>((ref) => null);

class NickNamePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<NickNamePage> createState() => _NickNamePageState();

  const NickNamePage({super.key});
}

class _NickNamePageState extends ConsumerState<NickNamePage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = ref.read(authUserProvider);
      _nicknameController.text = user.userNick;
    });
  }

  @override
  Widget build(BuildContext context) {
    //닉네임 텍스트 필드 에러 메세지
    final nicknameErrorText = ref.watch(nicknameErrorProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '닉네임'),
      body: Container(
          margin: EdgeInsets.only(top: 10.h, left: 24.w, right: 24.w),
          child: Widgets.textfield(ref, _nicknameController, '닉네임', '',
              nicknameErrorText, nicknameErrorProvider)),
      bottomNavigationBar: Widgets.bottomBar(context, child: Widgets.button('저장하기', true, () {
          final data = {
            "user_nick": _nicknameController.text,
          };
          updateUser(ref, context, data);
        }),
      ),
    );
  }
}
