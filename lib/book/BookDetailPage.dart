import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/BookService.dart';
import '../garden/GardenEditPage.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final bookDetailProvider = StateProvider<Map>((ref) => {});

class BookDetailPage extends ConsumerStatefulWidget {
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends ConsumerState<BookDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookDetailProvider.notifier).state = {};
    });
  }

  //책 수정 (가든 옮기기) api
  void putBook() async {
    final data = {
      "garden_no": 0,
      // "book_tree": "string",
      // "book_image_url": "string",
      // "book_status": 0
    };

    final response = await bookService.putBook(
        ref.watch(bookDetailProvider)['book_no'], data);
    if (response?.statusCode == 200) {
    } else if (response?.statusCode == 401) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context, actions: [
        GestureDetector(
          onTap: _moreBottomSheet,
          child: Container(
            margin: EdgeInsets.only(right: 14.w),
            child: SvgPicture.asset('assets/images/angle-left-detail.svg',
                width: 32.r, height: 32.r),
          ),
        )
      ]),
      body: Container(
        child: Text(''),
      ),
    );
  }

  Future _moreBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          height: 230.h,
          child: Container(
            margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                    context.pushNamed('book-edit', extra: {
                      'book_no': 7,
                      'book_title': '제목',
                      'book_author': '작가',
                      'book_publisher': '출판사',
                      'book_image_url': null,
                      'book_tree': '',
                      'book_status': 0,
                      'percent': 0.0,
                      'book_page': 50,
                      'garden_no': 19
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 24.h,
                    color: Colors.transparent,
                    child: Text(
                      '책 수정하기',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24.h),
                  height: 1.h,
                  color: AppColors.grey_F2,
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => GardenEditBottomSheet(
                              function: (int to_garden_no) {
                                // moveToGarden(to_garden_no);
                              },
                            ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 24.h,
                    color: Colors.transparent,
                    child: Text(
                      '다른 가든으로 이전',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24.h),
                  height: 1.h,
                  color: AppColors.grey_F2,
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                    _bookDeleteBottomSheet();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 24.h,
                    color: Colors.transparent,
                    child: Text(
                      '책 삭제하기',
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

  //책 삭제하기 바텀시트
  Future _bookDeleteBottomSheet() {
    return Widgets.deleteBottomSheet(
        context,
        '이 책을 삭제할까요?',
        Text.rich(TextSpan(style: TextStyle(fontSize: 14.sp), children: const [
          TextSpan(text: '책을 삭제하면 내가 기록한 '),
          TextSpan(
              text: '독서 기록', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '과 '),
          TextSpan(text: '메모', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '도 모두 삭제되어요.'),
        ])),
        '삭제하기',
        () => ());
  }
}
