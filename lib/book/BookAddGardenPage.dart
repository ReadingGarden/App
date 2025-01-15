import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Constant.dart';
import '../utils/Widgets.dart';

final buttonCheckProvider = StateProvider<bool>((ref) => false);
final detailIsbnProvider = StateProvider<Map>((ref) => {});
final bookNoProvider = StateProvider<int?>((ref) => null);

class BookAddGardenPage extends ConsumerStatefulWidget {
  const BookAddGardenPage(this.book, {required this.isbn13});

  final String isbn13;
  final Map? book;

  _BookAddGardenPageState createState() => _BookAddGardenPageState();
}

class _BookAddGardenPageState extends ConsumerState<BookAddGardenPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(detailIsbnProvider.notifier).state = {};
      ref.read(bookNoProvider.notifier).state = null;
      //책 검색에서 온...
      if (widget.isbn13 != 'null') {
        ref.read(buttonCheckProvider.notifier).state = false;
        getDetailBook_ISBN(widget.isbn13);
      } else {
        //책장(읽고싶어요)에서 온...
        ref.read(buttonCheckProvider.notifier).state = true;
        ref.read(bookNoProvider.notifier).state = widget.book!['book_no'];
      }
    });
  }

  //책 읽고싶어요 등록 (책등록)
  void postBookStatus() async {
    final detailIsbn = bookResult();

    final data = {
      "book_title": detailIsbn['title'],
      "book_author": detailIsbn['author'],
      "book_publisher": detailIsbn['publisher'],
      "book_info": detailIsbn['description'],
      "book_status": 2,
      "book_page": detailIsbn['itemPage'],
      "book_image_url": detailIsbn['cover']
    };

    final response = await bookService.postBook(data);
    if (response?.statusCode == 201) {
      ref.read(bookNoProvider.notifier).state =
          response?.data['data']['book_no'];
    }
  }

  //책 읽고싶어요 취소 (책 삭제)
  void deleteBookStatus() async {
    final response = await bookService.deleteBook(ref.watch(bookNoProvider)!);
    if (response?.statusCode == 200) {}
  }

  //책 상세조회 isbn api
  void getDetailBook_ISBN(String isbn) async {
    final response = await bookService.getDetailBook_ISBN(isbn);
    if (response?.statusCode == 200) {
      ref.read(detailIsbnProvider.notifier).state = response?.data['data'];
    }
  }

  Map bookResult() {
    Map bookResult = ref.watch(detailIsbnProvider);
    if (widget.isbn13 == 'null') {
      bookResult = widget.book!;
    }
    return bookResult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context),
        body: (bookResult().isEmpty)
            ? Container()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 24.w, right: 24.w, bottom: 60.h),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 264.w,
                        // height: 307.h,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 16.r,
                                    color: AppColors.black_4A.withOpacity(0.1))
                              ]),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: (bookResult()['cover'] != null)
                                      ? Image.network(
                                          width: 145.w,
                                          height: 200.h,
                                          fit: BoxFit.cover,
                                          bookResult()['cover'],
                                        )
                                      : Container(
                                          width: 145.w,
                                          height: 200.h,
                                        )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 29.h, bottom: 6.h),
                              child: Text(
                                bookResult()['title'] ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Text(
                              bookResult()['author'] ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            ),
                            Text(
                              bookResult()['publisher'] ?? '',
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            ),
                            Text(
                              '${bookResult()['itemPage'] ?? ''}p',
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            ),
                          ],
                        ),
                      ),
                      (!ref.watch(buttonCheckProvider))
                          ? GestureDetector(
                              onTap: () {
                                ref.read(buttonCheckProvider.notifier).state =
                                    true;
                                postBookStatus();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin:
                                    EdgeInsets.only(top: 20.h, bottom: 30.h),
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                width: 104.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        '${Constant.ASSETS_ICONS}icon_add.svg',
                                        color: AppColors.primaryColor,
                                        width: 16.r,
                                        height: 16.r,
                                      ),
                                    ),
                                    Text(
                                      '읽고싶어요',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                ref.read(buttonCheckProvider.notifier).state =
                                    false;
                                if (ref.watch(bookNoProvider) != null) {
                                  deleteBookStatus();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin:
                                    EdgeInsets.only(top: 20.h, bottom: 30.h),
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                width: 104.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: AppColors.primaryColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: SvgPicture.asset(
                                        '${Constant.ASSETS_ICONS}icon_check.svg',
                                        color: Colors.white,
                                        width: 16.r,
                                        height: 16.r,
                                      ),
                                    ),
                                    Text(
                                      '읽고싶어요',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 20.h, bottom: 20.h, left: 24.w, right: 24.w),
                        width: 312.w,
                        // height: 210.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: AppColors.grey_F2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              height: 22.h,
                              child: Text(
                                '책 소개',
                                style: TextStyle(
                                    fontSize: 12.sp, color: AppColors.grey_8D),
                              ),
                            ),
                            (bookResult()['description'] != '')
                                ? Text(
                                    bookResult()['description'] ?? '',
                                    style: TextStyle(
                                        fontSize: 12.sp, height: 1.75.h),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(top: 8.h, bottom: 8.h),
                                    child: Text('소개글이 등록되지 않은 책이에요',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.grey_8D)),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(
                left: 24.w, right: 24.w, bottom: 30.h, top: 10.h),
            child: Widgets.button('내 가든에 심기', true, () {
              context.pushNamed('book-register', extra: bookResult());
            })));
  }
}
