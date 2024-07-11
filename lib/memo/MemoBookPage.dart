import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

final bookStatusListAllProvider = StateProvider<List>((ref) => []);

class MemoBookPage extends ConsumerStatefulWidget {
  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoBookPage> {
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookStatusListAllProvider.notifier).state = [];
      getBookStatusList(3);
    });
  }

  void getBookStatusList(int status) async {
    final response = await bookService.getBookStatusList(status);
    if (response?.statusCode == 200) {
      ref.read(bookStatusListAllProvider.notifier).state =
          response?.data['data'];
    }
  }

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
        ref.watch(bookStatusListAllProvider).length,
        (index) {
          return GestureDetector(
            onTap: () => context.pushNamed('memo-write', extra: {
              'book_no': ref.watch(bookStatusListAllProvider)[index]['book_no'],
              'book_title': ref.watch(bookStatusListAllProvider)[index]
                  ['book_title'],
              'book_author': ref.watch(bookStatusListAllProvider)[index]
                  ['book_author'],
            }),
            child: Container(
              height: 88.h,
              color: Colors.transparent,
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
                          ref.watch(bookStatusListAllProvider)[index]
                              ['book_title'],
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text(
                          ref.watch(bookStatusListAllProvider)[index]
                              ['book_author'],
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
