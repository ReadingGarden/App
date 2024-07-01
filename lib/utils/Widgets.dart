import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';

class Widgets {
  static appBar(BuildContext context, {String? title}) {
    return AppBar(
      // 스크롤 -> 반투명 없애기
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        title ?? '',
        style: TextStyle(fontSize: 18.sp),
      ),
      leading: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Container(
          alignment: Alignment.center,
          width: 32.r,
          height: 32.r,
          color: Colors.transparent,
          child: SvgPicture.asset('assets/images/back_btn.svg'),
        ),
      ),
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
            color:
                isValid ? AppColors.primaryColor : AppColors.primaryGreyColor),
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
          ? EdgeInsets.only(top: 8.h, bottom: 24.h)
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
            onChanged: (value) {
              // errorText 초기화
              ref.read(errorProvider.notifier).state = null;
            },
            onSubmitted: (value) {
              if (validateFunction != null) {
                validateFunction();
              }
            },
            obscureText: (isPwd == null) ? false : isPwd,
            decoration: InputDecoration(
              fillColor: AppColors.textFieldColor,
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.textFieldHintColor),
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
              errorStyle: const TextStyle(
                color: AppColors.textFieldErrorColor,
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                      color: AppColors.textFieldErrorColor, width: 1.w)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                      color: AppColors.textFieldErrorColor, width: 1.w)),
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
        color: const Color(0xFF3C3C3C).withOpacity(0.9),
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

  static Widget subTitleList(String subTitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      height: 20.h,
      child: Text(
        subTitle,
        style: TextStyle(fontSize: 12.sp, color: AppColors.textLightGreyColor),
      ),
    );
  }

  static Future baseBottomSheet(BuildContext context, String title,
      String content, String btnTitle, Function btnFunction) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            height: 340.h,
            padding: EdgeInsets.only(
                top: 30.h, left: 24.w, right: 24.w, bottom: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24.h, bottom: 30.h),
                  height: 48.h,
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Widgets.button(btnTitle, true, () {
                      btnFunction();
                    }),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: AppColors.cancelGreyColor),
                        child: Center(
                            child: Text(
                          '취소',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.textFieldHintColor),
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
