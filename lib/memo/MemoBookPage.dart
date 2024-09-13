import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/model/Book.dart';
import '../core/provider/BookStatusAllListNotifier.dart';
import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class MemoBookPage extends ConsumerStatefulWidget {
  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoBookPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookStatusAllListProvider.notifier).reset();
    });
    _scrollController.addListener(() {
      // 스크롤이 마지막에 도달했을 때 추가 데이터를 로드
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getBookStatusList(3);
      }
    });
    getBookStatusList(3);
  }

  //책 목록(상태) 리스트 조회 api
  void getBookStatusList(int status) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final response = await bookService.getBookStatusList(status, _currentPage);
    if (response?.statusCode == 200) {
      final List<dynamic> bookStatusAllList = response?.data['data']['list'];
      final List<Book> newBookStatusAllList = bookStatusAllList
          .map((json) => Book(
              book_no: json['book_no'],
              book_title: json['book_title'],
              book_author: json['book_author'],
              book_publisher: json['book_publisher'],
              book_info: json['book_info'],
              book_image_url: json['book_image_url'],
              book_tree: json['book_tree'],
              book_status: json['book_status'],
              percent: json['percent'],
              book_page: json['book_page'],
              garden_no: json['garden_no']))
          .toList();

      if (newBookStatusAllList.isNotEmpty) {
        ref
            .read(bookStatusAllListProvider.notifier)
            .addBookStatusAllList(newBookStatusAllList);
        setState(() {
          _currentPage++;
        });
      }

      setState(() {
        _isLoading = false;
      });
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
            const Text(
              '내 책장에 있는 책',
              style: TextStyle(color: AppColors.grey_8D),
            ),
            Expanded(child: _bookList()),
          ],
        ),
      ),
    );
  }

  Widget _bookList() {
    final bookList = ref.watch(bookStatusAllListProvider);

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.only(top: 10.h),
      children: List.generate(
        bookList.length,
        (index) {
          return GestureDetector(
            onTap: () => context.pushNamed('memo-write', extra: {
              'book_no': bookList[index].book_no,
              'book_title': bookList[index].book_title,
              'book_author': bookList[index].book_author,
              'book_image_url': bookList[index].book_image_url
            }),
            child: Container(
              height: 88.h,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      (bookList[index].book_image_url == null)
                          ? Container(
                              width: 48.w,
                              height: 64.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.grey_F2,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                width: 48.w,
                                height: 64.h,
                                fit: BoxFit.cover,
                                bookList[index].book_image_url!,
                              ),
                            ),
                      Container(
                        margin: EdgeInsets.only(left: 12.w),
                        width: 220.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              bookList[index].book_title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Text(
                              bookList[index].book_author,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            ),
                          ],
                        ),
                      ),
                    ],
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
