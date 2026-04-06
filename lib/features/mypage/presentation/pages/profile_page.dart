import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider);

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
                child: AppAssets.profileFlower(
                  user.userImage,
                ).image(),
              ),
            ),
            _titleList(
              '대표 프로필 변경',
              () {
                context.pushNamed('profile-image');
              },
              widget: AppAssets.iconAngleRight.svg(
                colorFilter: const ColorFilter.mode(
                  AppColors.grey_8D,
                  BlendMode.srcIn,
                ),
                width: 20.r,
                height: 20.r,
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
                    user.userNick,
                    style: const TextStyle(color: AppColors.grey_8D),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 8.w),
                    width: 20.r,
                    height: 20.r,
                    child: AppAssets.iconAngleRight.svg(
                      colorFilter: const ColorFilter.mode(
                        AppColors.grey_8D,
                        BlendMode.srcIn,
                      ),
                      width: 20.r,
                      height: 20.r,
                    ),
                  ),
                ],
              ),
            ),
            _titleList(
              '이메일',
              () {},
              widget: Text(
                user.userEmail,
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
