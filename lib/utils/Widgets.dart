import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';

class Widgets {
  static appBar(BuildContext context,
      {String? title, List<Widget>? actions, Function? backFunction}) {
    return AppBar(
      // 스크롤 -> 반투명 없애기
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 60.h,
      title: Text(
        title ?? '',
        style: TextStyle(fontSize: 16.sp),
      ),
      leading: GestureDetector(
        onTap: () {
          if (backFunction != null) {
            backFunction();
          } else {
            context.pop();
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 32.r,
          height: 32.r,
          color: Colors.transparent,
          child: SvgPicture.asset('assets/images/angle-left.svg'),
        ),
      ),

      actions: actions,
    );
  }

  static button(
    String title,
    bool isValid,
    Function function,
  ) {
    return GestureDetector(
      onTap: () => isValid ? function() : null,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: isValid ? AppColors.primaryColor : AppColors.grey_CA),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Colors.white),
        )),
      ),
    );
  }

  static redButton(
    String title,
    Function function,
  ) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.buttonRedColor),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.errorRedColor),
        )),
      ),
    );
  }

  static textfield(
      WidgetRef ref,
      TextEditingController controller,
      String label,
      String hintText,
      String? errorText,
      StateProvider<String?> errorProvider,
      {Function? validateFunction,
      bool? isPwd}) {
    return Container(
      padding: (errorText == null)
          ? EdgeInsets.only(top: 6.h, bottom: 12.h)
          : EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4.h),
            height: 20.h,
            child: Text(
              label,
            ),
          ),
          TextField(
            controller: controller,
            maxLength: (label == '가든 소개') ? 30 : null,
            maxLines: (label == '가든 소개') ? 2 : 1,
            onChanged: (value) {
              // errorText 초기화
              ref.read(errorProvider.notifier).state = null;
            },
            onSubmitted: (value) {
              if (validateFunction != null) {
                validateFunction();
              }
            },
            style: TextStyle(fontSize: 16.sp),
            obscureText: (isPwd == null) ? false : isPwd,
            decoration: InputDecoration(
              counter: Container(),
              fillColor: AppColors.grey_FA,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 16.sp, color: AppColors.grey_8D),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1.w)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1.w)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1.w)),
              errorText: errorText,
              errorStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColors.errorRedColor,
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: AppColors.errorRedColor, width: 1.w)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      BorderSide(color: AppColors.errorRedColor, width: 1.w)),
            ),
          ),
        ],
      ),
    );
  }

  static toast(String msg) {
    return Container(
      width: 312.w,
      height: 40.h,
      padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.black_4A,
      ),
      child: Row(
        children: [
          Container(
              width: 24.r,
              height: 24.r,
              margin: EdgeInsets.only(right: 10.w),
              child: SvgPicture.asset('assets/images/check-circle.svg')),
          Text(
            msg,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  static Widget titleList(String title, Function function, {Widget? widget}) {
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

  static Future baseBottomSheet(BuildContext context, String title,
      String content, String btnTitle, Function btnFunction,
      {String? cancelTitle,
      Widget? contentWidget,
      Function? cancelBtnFunction}) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            height: 278.h,
            margin: EdgeInsets.only(
              top: 30.h,
              left: 24.w,
              right: 24.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6.h, bottom: 24.h),
                  height: 44.h,
                  child: (content != '' && contentWidget == null)
                      ? Text(
                          content,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        )
                      : contentWidget!,
                ),
                Column(
                  children: [
                    Widgets.button(btnTitle, true, () {
                      btnFunction();
                    }),
                    GestureDetector(
                      onTap: () => (cancelBtnFunction != null)
                          ? cancelBtnFunction()
                          : context.pop(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.grey_F2),
                        child: Center(
                            child: Text(
                          cancelTitle ?? '취소',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.grey_8D),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future deleteBottomSheet(BuildContext context, String title,
      Widget content, String btnTitle, Function btnFunction) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            height: 282.h,
            margin: EdgeInsets.only(top: 30.h, left: 24.w, right: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                    margin: EdgeInsets.only(top: 6.h, bottom: 24.h),
                    height: 46.h,
                    child: content),
                Column(
                  children: [
                    Widgets.redButton(btnTitle, () {
                      btnFunction();
                    }),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.grey_F2),
                        child: Center(
                            child: Text(
                          '취소',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.grey_8D),
                        )),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
