import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'utils/AppColors.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '인터넷 연결이 불안정해요',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_2B),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.h, bottom: 20.h),
              child: const Text(
                '네트워크 연결 상태를 확인한 후\n다시 실행해보세요',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grey_8D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
