import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/book/domain/entities/book_isbn_detail_entity.dart';
import 'package:book_flutter/features/book/presentation/providers/book_add_garden_provider.dart';

class BookAddGardenPage extends ConsumerStatefulWidget {
  const BookAddGardenPage(this.book, {super.key, required this.isbn13});

  final String isbn13;
  final Map? book;

  @override
  ConsumerState<BookAddGardenPage> createState() => _BookAddGardenPageState();
}

class _BookAddGardenPageState extends ConsumerState<BookAddGardenPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(detailIsbnProvider.notifier).reset();
      ref.read(bookNoProvider.notifier).state = null;
      //책 검색에서 온...
      if (widget.isbn13 != 'null') {
        ref.read(buttonCheckProvider.notifier).state = false;
        ref.read(detailIsbnProvider.notifier).fetchBookDetail(widget.isbn13);
      } else {
        //책장(읽고싶어요)에서 온...
        ref.read(buttonCheckProvider.notifier).state = true;
        ref.read(detailIsbnProvider.notifier).setInitialBook(widget.book!);
        ref.read(bookNoProvider.notifier).state = widget.book!['book_no'];
      }
    });
  }

  //책 읽고싶어요 등록 (책등록)
  void postBookStatus() async {
    final bookNo = await ref.read(detailIsbnProvider.notifier).createWishBook();
    if (bookNo != null) {
      ref.read(bookNoProvider.notifier).state = bookNo;
    }
  }

  //책 읽고싶어요 취소 (책 삭제)
  void deleteBookStatus() async {
    final bookNo = ref.watch(bookNoProvider);
    if (bookNo == null) {
      return;
    }
    await ref.read(detailIsbnProvider.notifier).deleteWishBook(bookNo);
  }

  //책 중복 확인
  void getBookDuplication() async {
    final statusCode = await ref
        .read(detailIsbnProvider.notifier)
        .checkDuplication(widget.isbn13);
    if (!mounted) return;
    if (statusCode == 200) {
      context.pushNamed('book-register',
          extra: bookResult().toRegisterPayload());
    } else if (statusCode == 403) {
      Widgets.baseBottomSheet(
          context, '이미 저장된 책이에요', '가든에 등록되어 있는 책이에요. 또 저장할까요?', '등록하기', () {
        context.pop();
        context.pushNamed('book-register',
            extra: bookResult().toRegisterPayload());
      }, cancelTitle: '그냥 나가기');
    }
  }

  BookIsbnDetailEntity bookResult() {
    return ref.watch(detailIsbnProvider);
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
                                    color: AppColors.black_59.withOpacity(0.1))
                              ]),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: (bookResult().cover != null)
                                      ? Image.network(
                                          width: 145.w,
                                          height: 200.h,
                                          fit: BoxFit.cover,
                                          bookResult().cover!,
                                        )
                                      : SizedBox(
                                          width: 145.w,
                                          height: 200.h,
                                        )),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 29.h, bottom: 6.h),
                              child: Text(
                                bookResult().title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Text(
                              bookResult().author,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            ),
                            Text(
                              bookResult().publisher,
                              style: TextStyle(
                                  fontSize: 12.sp, color: AppColors.grey_8D),
                            ),
                            Text(
                              '${bookResult().itemPage}p',
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
                                      child: AppAssets.iconAdd.svg(
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.primaryColor,
                                          BlendMode.srcIn,
                                        ),
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
                                      child: AppAssets.iconCheck.svg(
                                        colorFilter: const ColorFilter.mode(
                                          Colors.white,
                                          BlendMode.srcIn,
                                        ),
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
                            (bookResult().description != '')
                                ? Text(
                                    bookResult().description,
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
        bottomNavigationBar: Widgets.bottomBar(context, child: Widgets.button('내 가든에 심기', true, () {
              getBookDuplication();
            })));
  }
}
