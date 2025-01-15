import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/model/Book.dart';
import '../core/provider/BookStatusAllListNotifier.dart';
import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
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
    final bookList = ref.watch(bookStatusAllListProvider);

    return Scaffold(
      appBar: Widgets.appBar(context, title: '메모할 책 선택'),
      body: (bookList.isNotEmpty)
          ? Container(
              margin: EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '내 책장에 있는 책',
                    style: TextStyle(color: AppColors.grey_8D),
                  ),
                  Expanded(child: _bookList(bookList)),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '저장된 책이 없어요!',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black_2B),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h, bottom: 20.h),
                    child: const Text(
                      '내 책장에 있는 책에만 메모를 쓸 수 있어요\n우선, 가든에 책을 추가해주세요',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.grey_8D),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed('book-serach');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 96.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                          color: AppColors.grey_EF,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: Text(
                        '책 추가하기',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black_4A),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _bookList(bookList) {
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
                  SvgPicture.asset(
                      '${Constant.ASSETS_ICONS}icon_angle_right.svg',
                      color: AppColors.grey_8D,
                      width: 20.r,
                      height: 20.r)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
