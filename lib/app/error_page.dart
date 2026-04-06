import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:book_flutter/shared/theme/app_colors.dart';

enum ErrorType { network, server }

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.errorType = ErrorType.server});

  final ErrorType errorType;

  @override
  Widget build(BuildContext context) {
    final isNetwork = errorType == ErrorType.network;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isNetwork ? '인터넷 연결이 불안정해요' : '일시적인 오류가 발생했어요',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black_2B),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.h, bottom: 20.h),
              child: Text(
                isNetwork
                    ? '네트워크 연결 상태를 확인한 후\n다시 실행해보세요'
                    : '잠시 후 다시 시도해주세요',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.grey_8D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
