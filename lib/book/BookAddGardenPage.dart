import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final buttonCheckProvider = StateProvider<bool>((ref) => false);

class BookAddGardenPage extends ConsumerStatefulWidget {
  _BookAddGardenPageState createState() => _BookAddGardenPageState();
}

class _BookAddGardenPageState extends ConsumerState<BookAddGardenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 60.h),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 312.w,
                  height: 307.h,
                  child: Column(
                    children: [
                      Container(
                        width: 122.w,
                        height: 180.h,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 8.r,
                                  color: Colors.black.withOpacity(0.1)),
                            ],
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.green),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 29.h, bottom: 6.h),
                        child: Text(
                          '@어쩌구 저쩌구',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                      Text(
                        '@어쩌구 (지은이)',
                        style: TextStyle(
                            fontSize: 14.sp, color: AppColors.grey_8D),
                      ),
                      Text(
                        '@출판사',
                        style: TextStyle(
                            fontSize: 14.sp, color: AppColors.grey_8D),
                      ),
                      Text(
                        '@144p',
                        style: TextStyle(
                            fontSize: 14.sp, color: AppColors.grey_8D),
                      ),
                    ],
                  ),
                ),
                (!ref.watch(buttonCheckProvider))
                    ? GestureDetector(
                        onTap: () {
                          ref.read(buttonCheckProvider.notifier).state = true;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: 93.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 12.r,
                                height: 12.r,
                                child: SvgPicture.asset(
                                  'assets/images/plus.svg',
                                ),
                              ),
                              Text(
                                '읽고싶어요',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),
                              )
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          ref.read(buttonCheckProvider.notifier).state = false;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20.h, bottom: 30.h),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          width: 93.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColors.primaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 12.r,
                                height: 12.r,
                                child: SvgPicture.asset(
                                  'assets/images/check.svg',
                                ),
                              ),
                              Text(
                                '읽고싶어요',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, left: 24.w, right: 24.w),
                  width: 312.w,
                  // height: 210.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.grey_F2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        height: 22.h,
                        child: const Text(
                          '책 소개',
                          style: TextStyle(color: AppColors.grey_8D),
                        ),
                      ),
                      Text(
                        '바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 아름다운 무지개 물고기의 비늘을 질투했지만 그래도 무지개바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 어케된거임바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 아름다운 무지개 물고기의 비늘을 질투했지만 그래도 무지개바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 어케된거임바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. ',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(
                left: 24.w, right: 24.w, bottom: 30.h, top: 10.h),
            child: Widgets.button('내 가든에 심기', true, () {})));
  }
}
