import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';

class Widgets {
  static AppBar appBar(BuildContext context) {
    return AppBar(
      // 스크롤 -> 반투명 없애기
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
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
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }

  // static Align bottomButton(String title, Function function) {
  //   return Align(
  //     alignment: Alignment.bottomCenter,
  //     heightFactor: 11,
  //     child: GestureDetector(
  //       onTap: () => function(),
  //       child: Container(
  //         decoration: BoxDecoration(color: Colors.amber),
  //         height: 60,
  //         child: Center(child: Text(title)),
  //       ),
  //     ),
  //   );
  // }

  static Container textfield(
      WidgetRef ref,
      TextEditingController controller,
      String label,
      String hintText,
      String? errorText,
      StateProvider<String?> errorProvider,
      {Function? validateFunction}) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20.w),
      // width: 360.w,
      height: (errorText == null) ? 92.h : 112.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
            child: Text(
              label,
            ),
          ),
          TextField(
            controller: controller,
            onChanged: (value) {
              // errorText 초기화
              // ref.read(errorProvider.notifier).state = null;
            },
            onSubmitted: (value) {
              if (validateFunction != null) {
                validateFunction();
              }
            },
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
}
