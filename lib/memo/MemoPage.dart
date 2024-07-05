import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../utils/AppColors.dart';
import '../utils/Functions.dart';

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
          toolbarHeight: 60.h,
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
                margin: EdgeInsets.only(right: 14.w),
                color: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/images/angle-left-write.svg',
                  width: 32.r,
                  height: 32.r,
                ),
              ),
            )
          ],
        ),
        body: (true) ? _memoList() : _emptyMemo());
  }

  Widget _memoList() {
    DateTime now = DateTime.now();
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: List.generate(
        2,
        (index) {
          return GestureDetector(
            onTap: () {
              context.pushNamed('memo-detail');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
              width: 312.w,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey_F2),
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44.r,
                        height: 44.r,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.green),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12.w),
                        child: Column(
                          children: [
                            Text('title'),
                            Text(
                              'sub',
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Visibility(
                      visible: (index == 0),
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        height: 140.h,
                        color: Colors.green,
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        '바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기 바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기를 보게된다면',
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 12.sp, overflow: TextOverflow.ellipsis),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Functions.formatDate(now),
                            style: TextStyle(
                                fontSize: 12.sp, color: AppColors.grey_8D),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('즐찾');
                            },
                            child: SvgPicture.asset(
                              (true)
                                  ? 'assets/images/star.svg'
                                  : 'assets/images/star-dis.svg',
                              width: 20.r,
                              height: 20.r,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
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
