import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class BookSerachPage extends ConsumerStatefulWidget {
  _BookSerachPageState createState() => _BookSerachPageState();
}

class _BookSerachPageState extends ConsumerState<BookSerachPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Text(
                '책 추가하기',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
                  alignment: Alignment.center,
                  height: 72.h,
                  child: TextField(
                    style: TextStyle(fontSize: 16.sp),
                    decoration: InputDecoration(
                        prefixIcon: Container(
                          alignment: Alignment.center,
                          width: 20.r,
                          height: 20.r,
                          child: SvgPicture.asset(
                            'assets/images/search.svg',
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.r)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.r)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.r)),
                        fillColor: AppColors.grey_FA,
                        filled: true,
                        hintText: '제목, 작가 명으로 검색',
                        hintStyle: TextStyle(
                            fontSize: 16.sp, color: AppColors.grey_8D)),
                  )),
            ),
            (true)
                ? _serachList()
                : Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            alignment: Alignment.center,
                            height: 72.h,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 12.w, right: 14.w),
                              width: 312.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: const Color(0xffF3FCF8)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '책 직접 입력하기',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor),
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/angle-right-b.svg',
                                    width: 20.r,
                                    height: 20.r,
                                    color: AppColors.primaryColor,
                                  )
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          print('바코드 카메라 열어라');
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 72.h,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 12.w, right: 14.w),
                              width: 312.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: const Color(0xffF3FCF8)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '바코드로 검색하기',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor),
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/angle-right-b.svg',
                                    width: 20.r,
                                    height: 20.r,
                                    color: AppColors.primaryColor,
                                  )
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _serachList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 22.h,
              margin: EdgeInsets.only(left: 24.w, top: 10.h, bottom: 10.h),
              child: const Text.rich(TextSpan(children: [
                TextSpan(
                    text: '\'@@\' ',
                    style: TextStyle(color: AppColors.grey_8D)),
                TextSpan(
                    text: '@', style: TextStyle(color: AppColors.primaryColor))
              ]))),
          Expanded(
            child: ListView(
              children: List.generate(
                4,
                (index) {
                  return GestureDetector(
                    onTap: () => context.pushNamed('book-add-garden'),
                    child: Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
                      height: 88.h,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 48.w,
                            height: 64.h,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8.r)),
                          ),
                          SizedBox(
                            width: 252.w,
                            height: 50.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '@@@@',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                                Text(
                                  '@@@@ (지은이)',
                                  style: TextStyle(color: AppColors.grey_8D),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
