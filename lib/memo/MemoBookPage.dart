import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class MemoBookPage extends ConsumerStatefulWidget {
  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, title: '메모할 책 선택'),
      body: Container(
        margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 22.h,
              child: const Text(
                '내 책장에 있는 책',
                style: TextStyle(color: AppColors.grey_8D),
              ),
            ),
            Expanded(child: _bookList()),
          ],
        ),
      ),
    );
  }

  Widget _bookList() {
    return ListView(
      padding: EdgeInsets.only(top: 10.h),
      children: List.generate(
        3,
        (index) {
          return GestureDetector(
            onTap: () => context.pushNamed('memo-write'),
            child: SizedBox(
              height: 88.h,
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12.w),
                    width: 222.w,
                    height: 50.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'title',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          'subtitle',
                          style: TextStyle(
                              fontSize: 14.sp, color: AppColors.grey_8D),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset('assets/images/angle-right-b.svg',
                      width: 20.r, height: 20.r)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
