import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/User.dart';
import '../core/provider/AuthServiceProvider.dart';
import '../core/provider/ResponseProvider.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class ProfilePage extends ConsumerStatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  //로그아웃 api
  void postLogout() async {
    final response =
        await ref.read(AuthServiceProvider.postLogoutProvider.future);
    if (response?.statusCode == 200) {
      context.goNamed('start');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userResponse = ref.watch(userResponseProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '프로필'),
      body: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 40.h),
              child: CircleAvatar(
                radius: 60.r,
              ),
            ),
            _titleList(
              '대표 프로필 변경',
              () {},
              widget: Container(
                alignment: Alignment.center,
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(
                  'assets/images/right_btn.svg',
                ),
              ),
            ),
            _titleList(
              '닉네임',
              () {
                context.goNamed('nickname');
              },
              widget: Row(
                children: [
                  Text(
                    userResponse['user_nick'] ?? '',
                    style: const TextStyle(color: AppColors.textLightGreyColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 8.w),
                    width: 20.r,
                    height: 20.r,
                    child: SvgPicture.asset(
                      'assets/images/right_btn.svg',
                    ),
                  ),
                ],
              ),
            ),

            _titleList(
              '이메일',
              () {},
              widget: Text(
                userResponse['user_email'] ?? '',
                style: const TextStyle(color: AppColors.textLightGreyColor),
              ),
            ),

            // _titleList(
            //   '비밀번호 변경',
            //   () {},
            //   widget: Container(
            //     alignment: Alignment.center,
            //     width: 20.r,
            //     height: 20.r,
            //     child: SvgPicture.asset(
            //       'assets/images/right_btn.svg',
            //     ),
            //   ),
            // ),
            // // Widgets.subTitleList('계정 관리'),
            // _titleList('로그아웃', () {
            //   Widgets.baseBottomSheet(context, '로그아웃 하시겠어요?',
            //       '이때까지 작성한 책 기록을 보려면 다시 로그인 해주셔야 해요.', '로그아웃', () {
            //     //TODO: - 로그아웃 api 연결
            //     postLogout();
            //   });
            // }),
            // GestureDetector(
            //   onTap: () => () {},
            //   child: Container(
            //     color: Colors.transparent,
            //     height: 20.h,
            //     child: Text(
            //       '게정 삭제하기',
            //       style: TextStyle(
            //           fontSize: 16.sp,
            //           fontWeight: FontWeight.w500,
            //           color: AppColors.textFieldErrorColor),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _titleList(String title, Function function, {Widget? widget}) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.only(left: 24.w),
        alignment: Alignment.centerLeft,
        width: 360.w,
        height: 46.h,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14.sp),
            ),
            widget ?? Container()
          ],
        ),
      ),
    );
  }
}
