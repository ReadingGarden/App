import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';

class MemoPage extends ConsumerStatefulWidget {
  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends ConsumerState<MemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.red,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Text(
            '메모',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          actions: [
            GestureDetector(
              onTap: () => context.pushNamed('memo-book'),
              child: Container(
                margin: EdgeInsets.only(right: 22.w),
                width: 16.r,
                height: 16.r,
                color: Colors.green,
              ),
            )
          ],
        ),
        body: _emptyMemo());
  }

  Widget _emptyMemo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.h),
            width: 120.w,
            height: 130.h,
            color: Colors.red,
          ),
          SizedBox(
            height: 44.h,
            child: const Text(
              '지금 읽고 있는 책이 있나요?\n책을 추가하고 가든을 가꿔보세요',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey_8D),
            ),
          ),
        ],
      ),
    );
  }
}
