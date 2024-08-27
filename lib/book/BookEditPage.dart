import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class BookEditPage extends ConsumerStatefulWidget {
  BookEditPage({super.key, required this.book});

  _BookEditPageState createState() => _BookEditPageState();

  final Map book;
}

class _BookEditPageState extends ConsumerState<BookEditPage> {
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startController.text = '2024.03.01';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, title: '책 수정하기'),
      body: Column(
        children: [
          Container(
              height: 88.h,
              margin: EdgeInsets.only(left: 24.w, right: 24.w),
              child: Row(children: [
                (widget.book['book_image_url'] != null &&
                        widget.book['book_image_url'] != '')
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          width: 48.w,
                          height: 64.h,
                          fit: BoxFit.cover,
                          widget.book['book_image_url'],
                        ),
                      )
                    : Container(
                        width: 48.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                            color: AppColors.grey_F2,
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                Container(
                  margin: EdgeInsets.only(left: 12.w),
                  width: 252.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.book['book_title'],
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        widget.book['book_author'],
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.grey_8D),
                      ),
                    ],
                  ),
                ),
              ])),
          Container(
            height: 1.h,
            color: AppColors.grey_F2,
          ),
          Container(
            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
            child: Column(
              children: [
                Widgets.textfield(ref, _startController, '읽기 시작한 날',
                    _startController.text, null, StateProvider((ref) => null)),
                Widgets.textfield(ref, _endController, '다 읽은 날',
                    '완독한 날짜를 입력해주세요', null, StateProvider((ref) => null))
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button('수정하기', true, () => () {})),
    );
  }
}
