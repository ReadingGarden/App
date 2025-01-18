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
              alignment: Alignment.center,
              width: 60.r,
              height: 60.r,
              child: SvgPicture.asset(
                  '${Constant.ASSETS_ICONS}icon_ellipsis.svg',
                  width: 24.r,
                  height: 24.r),
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
                  (widget.memo['book_image_url'] == null)
                      ? Container(
                          width: 48.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.grey_F2),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.network(
                            width: 48.w,
                            height: 64.h,
                            fit: BoxFit.cover,
                            widget.memo['book_image_url'],
                          ),
                        ),
                  Container(
                    width: 252.w,
                    margin: EdgeInsets.only(left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.memo['book_title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
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
              margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 100.h),
              child: Column(
                children: [
                  Visibility(
                    visible: widget.memo['image_url'] != null,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: Image.network(
                          width: 320.w,
                          '${Constant.IMAGE_URL}${widget.memo['image_url']}'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 20.h),
                    child: Text(
                      widget.memo['memo_content'],
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14.sp, height: 1.7.h),
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
          height: 157.h,
          child: Container(
            margin: EdgeInsets.only(top: 32.h, bottom: 32.h),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                    context.pushNamed('memo-write', extra: widget.memo);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 26.h,
                    color: Colors.transparent,
                    child: Text(
                      '메모 수정하기',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  height: 1.h,
                  color: AppColors.grey_F2,
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    Widgets.deleteBottomSheet(context, '이 메모를 삭제할까요?',
                        const Text('한번 삭제된 메모는 다시 되돌릴 수없어요.'), '삭제하기', () {
                      deleteMemo();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 26.h,
                    color: Colors.transparent,
                    child: Text(
                      '메모 삭제하기',
                      style: TextStyle(
                          fontSize: 16.sp, color: AppColors.errorRedColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
