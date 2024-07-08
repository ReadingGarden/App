import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class MemoDetailPage extends ConsumerStatefulWidget {
  const MemoDetailPage({required this.memo});

  final Map memo;

  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context, actions: [
          GestureDetector(
            onTap: () {
              _moreBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.only(right: 14.w),
              child: SvgPicture.asset('assets/images/angle-left-detail.svg',
                  width: 32.r, height: 32.r),
            ),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 88.h,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.green),
                  ),
                  Container(
                    height: 50.h,
                    margin: EdgeInsets.only(left: 12.w),
                    child: Column(
                      //TODO: - 간격 수정
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // widget.memo['']
                          'title',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          'sub',
                          style: TextStyle(
                              fontSize: 14.sp, color: AppColors.grey_8D),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 1.h,
              color: AppColors.grey_F2,
            ),
            Container(
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Column(
                children: [
                  Visibility(
                    visible: true,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      height: 165.h,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: const Text(
                      '''바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 아름다운 무지개 물고기의 비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받아들였다.\n다른 물고기들은 아름다운 무지개 물고기의 비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 아름다비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받아들였다. 바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들물고기의 비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받아들였다. 다른 물고기들은 아름다운 무지개 물고기의 비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 아름다비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받아들였다. 바다 속 다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들물고기의 비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받아들였다. 다른 물고기들은 아름다운 무지개 물고기의 비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받다른 물고기들과 달리 반짝반짝 빛나는 은빛 비늘을 가지고 있는 무지개 물고기. 다른 물고기들은 아름다비늘을 질투했지만 그래도 무지개 물고기는 편견 없이 그들을 받아들였다. 
                  ''',
                    ),
                  )
                ],
              ),
            )
          ]),
        ));
  }

  Future _moreBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          height: 198.h,
          child: Column(
            children: [
              // Stack(
              //   alignment: Alignment.centerRight,
              //   children: [
              Container(
                alignment: Alignment.center,
                height: 60.h,
                child: Text(
                  '더보기',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(right: 18.w),
              //   child: SvgPicture.asset('assets/images/multiply.svg',
              //       width: 24.r, height: 24.r),
              // )
              //   ],
              // ),
              Container(
                margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
                alignment: Alignment.centerLeft,
                height: 78.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 312.w,
                        color: Colors.transparent,
                        child: Text(
                          '메모 편집',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 312.w,
                        color: Colors.transparent,
                        child: Text(
                          '메모 삭제',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
