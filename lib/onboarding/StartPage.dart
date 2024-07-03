import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '독서가든',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: Container(
            margin: EdgeInsets.only(left: 29.w, bottom: 61.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Text(
                    '내가 읽고 싶었던 책,\n묻어두지 말고 키워볼까?',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '하루하루 꾸준히 책을 보다보면\n내가 읽은 책이 꽃이 되어 가든을 가득 채울거에요',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.grey_8D),
                )
              ],
            )),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
          child: Widgets.button('시작하기', true, () => context.goNamed('login')),
        ));
  }
}
