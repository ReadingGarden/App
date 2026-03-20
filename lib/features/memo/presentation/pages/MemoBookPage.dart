import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/core/ui/app_widgets.dart';
import 'package:book_flutter/features/memo/presentation/providers/memo_book_provider.dart'
    as memo_book_feature;
import 'package:book_flutter/core/constants/app_constant.dart';
import 'package:book_flutter/core/ui/app_colors.dart';

class MemoBookPage extends ConsumerStatefulWidget {
  @override
  _MemoBookPageState createState() => _MemoBookPageState();
}

class _MemoBookPageState extends ConsumerState<MemoBookPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      memo_book_feature.resetMemoBookList(ref);
      memo_book_feature.fetchMemoBookList(ref);
    });
    _scrollController.addListener(() {
      // 스크롤이 마지막에 도달했을 때 추가 데이터를 로드
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        memo_book_feature.fetchMemoBookList(ref);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookList = ref.watch(memo_book_feature.memoBookListProvider);

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
                            color: AppColors.black_59),
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
          final book = bookList[index];
          return GestureDetector(
            onTap: () =>
                context.pushNamed('memo-write', extra: book.toMemoWriteMap()),
            child: Container(
              height: 88.h,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      (book.bookImageUrl == null)
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
                                book.bookImageUrl!,
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
                              book.bookTitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Text(
                              book.bookAuthor,
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
