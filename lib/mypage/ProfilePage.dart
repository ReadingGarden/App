import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/provider/ResponseProvider.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class ProfilePage extends ConsumerStatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userResponse = ref.watch(userResponseProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '프로필'),
      body: Container(
        margin: EdgeInsets.only(top: 15.h, left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 31.h),
              child: CircleAvatar(
                radius: 60.r,
              ),
            ),
            Widgets.subTitleList('프로필 정보'),
            _titleList(
              '이메일',
              () {},
              widget: Text(
                userResponse['user_email'] ?? '',
                style: const TextStyle(color: AppColors.textLightGreyColor),
              ),
            ),
            _titleList(
              '닉네임',
              () {},
              widget: Row(
                children: [
                  Text(
                    userResponse['user_nick'] ?? '',
                    style: const TextStyle(color: AppColors.textLightGreyColor),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 4.06.w),
                    width: 20.94.w,
                    height: 20.h,
                    child: SvgPicture.asset(
                      'assets/images/right_btn.svg',
                    ),
                  ),
                ],
              ),
            ),
            _titleList(
              '프로필 변경',
              () {},
              widget: Container(
                alignment: Alignment.center,
                width: 20.94.w,
                height: 20.h,
                child: SvgPicture.asset(
                  'assets/images/right_btn.svg',
                ),
              ),
            ),
            _titleList(
              '비밀번호 변경',
              () {},
              widget: Container(
                alignment: Alignment.center,
                width: 20.94.w,
                height: 20.h,
                child: SvgPicture.asset(
                  'assets/images/right_btn.svg',
                ),
              ),
            ),
            Widgets.subTitleList('계정 관리'),
            _titleList('로그아웃', () {}),
            GestureDetector(
              onTap: () => () {},
              child: Container(
                color: Colors.transparent,
                height: 20.h,
                child: Text(
                  '게정 삭제하기',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textFieldErrorColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _titleList(String title, Function function, {Widget? widget}) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        height: 20.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            widget ?? Container()
          ],
        ),
      ),
    );
  }
}
