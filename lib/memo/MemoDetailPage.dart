import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/MemoService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';

class MemoDetailPage extends ConsumerStatefulWidget {
  const MemoDetailPage({required this.memo});

  final Map memo;

  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoDetailPage> {
  //메모 삭제 api
  void deleteMemo() async {
    final response = await memoService.deleteMemo(widget.memo['id']);
    if (response?.statusCode == 200) {
      context.pop();
      context.pop('MemoPage_getMemoList');
    }
  }

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
                          widget.memo['book_title'],
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          widget.memo['book_author'],
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.grey_8D),
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
                    visible: widget.memo['image_url'] != null,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: Image.network(
                          width: 320.w,
                          height: 165.h,
                          fit: BoxFit.fitWidth,
                          '${Constant.IMAGE_URL}${widget.memo['image_url']}'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 20.h),
                    child: Text(
                      widget.memo['memo_content'],
                      textAlign: TextAlign.start,
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
                      onTap: () {
                        context.pushNamed('memo-write', extra: widget.memo);
                      },
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
                      onTap: () {
                        deleteMemo();
                      },
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
