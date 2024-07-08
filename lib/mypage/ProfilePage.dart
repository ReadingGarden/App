import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
    final user = ref.watch(responseProvider.userMapProvider);

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
              () {
                context.pushNamed('profile-image');
              },
              widget: Container(
                alignment: Alignment.center,
                width: 20.r,
                height: 20.r,
                child: SvgPicture.asset(
                  'assets/images/angle-right-b.svg',
                ),
              ),
            ),
            _titleList(
              '닉네임',
              () {
                context.pushNamed('nickname');
              },
              widget: Row(
                children: [
                  Text(
                    user?['user_nick'] ?? '',
                    style: const TextStyle(color: AppColors.grey_8D),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 8.w),
                    width: 20.r,
                    height: 20.r,
                    child: SvgPicture.asset(
                      'assets/images/angle-right-b.svg',
                    ),
                  ),
                ],
              ),
            ),
            _titleList(
              '이메일',
              () {},
              widget: Text(
                user?['user_email'] ?? '',
                style: const TextStyle(color: AppColors.grey_8D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleList(String title, Function function, {Widget? widget}) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
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
