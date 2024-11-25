import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            physics: const PageScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return (index == 0)
                  ? startContainer()
                  : (index == 1)
                      ? start2Container()
                      : start3Container();
            }),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
          child: Widgets.button('시작하기', true, () => context.goNamed('login')),
        ));
  }

  Widget startContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              width: 360.w,
              height: 400.h,
              color: Colors.green,
            ),
            Container(
                margin: EdgeInsets.only(top: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        '내가 읽고 있는 책,\n독서가든에서 키워볼까?',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '하루하루 꾸준히 책을 보다보면\n내가 읽은 책이 꽃이 되어 가든을 가득 채울거에요',
                      style:
                          TextStyle(fontSize: 14.sp, color: AppColors.grey_8D),
                    ),
                  ],
                )),
          ],
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 30.h),
          width: 320.w,
          child: SizedBox(
            width: 34.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.primaryColor,
                ),
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.grey_CA,
                ),
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.grey_CA,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget start2Container() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              width: 360.w,
              height: 400.h,
              color: Colors.red,
            ),
            Container(
                margin: EdgeInsets.only(top: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        '친구와 함께 키워나가는\n우리의 공유 가든',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '함께 공유 가든에 나무를 심으면 더 풍성해져요. \n그리고 어쩌면 친구의 책을 따라 읽게 될지도?',
                      style:
                          TextStyle(fontSize: 14.sp, color: AppColors.grey_8D),
                    ),
                  ],
                )),
          ],
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 30.h),
          width: 320.w,
          child: SizedBox(
            width: 34.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.grey_CA,
                ),
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.primaryColor,
                ),
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.grey_CA,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget start3Container() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              width: 360.w,
              height: 400.h,
              color: Colors.amber,
            ),
            Container(
                margin: EdgeInsets.only(top: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        '내가 읽는 책이 모여서\n꽃을 피워낼때까지',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '독서는 꾸준함이 생명이죠.\n까먹지 않도록 원하는 때에 알림을 보내드릴게요!',
                      style:
                          TextStyle(fontSize: 14.sp, color: AppColors.grey_8D),
                    ),
                  ],
                )),
          ],
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 30.h),
          width: 320.w,
          child: SizedBox(
            width: 34.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.grey_CA,
                ),
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.grey_CA,
                ),
                CircleAvatar(
                  radius: 3.r,
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
