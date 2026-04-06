import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:book_flutter/shared/utils/functions.dart';
import 'package:book_flutter/shared/constants/app_constant.dart';
import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/auth/presentation/providers/auth_user_provider.dart'
    as auth_feature;
import 'package:book_flutter/features/book/presentation/providers/book_detail_provider.dart';
import 'package:book_flutter/features/garden/presentation/pages/garden_edit_page.dart';

final bookDetailAppBarColorProvider =
    StateProvider<Color>((ref) => Colors.white);

class BookDetailPage extends ConsumerStatefulWidget {
  const BookDetailPage({super.key, required this.bookNo});

  @override
  ConsumerState<BookDetailPage> createState() => _BookDetailPageState();

  final int bookNo;
}

class _BookDetailPageState extends ConsumerState<BookDetailPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;
  late ColorTween _colorTween;

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    // 애니메이션 컨트롤러 초기화
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    Future.microtask(() {
      ref.read(bookDetailProvider.notifier).reset(ref);
      ref.read(bookDetailAppBarColorProvider.notifier).state = Colors.white;

      // 색상 초기화
      _colorTween = ColorTween(begin: Colors.white, end: Colors.white);
    });

    // 스크롤 상단바 색 변경
    _scrollController.addListener(() {
      double offset = _scrollController.offset;

      // 0 ~ 600 범위를 0.0 ~ 1.0으로 변환
      double animationValue = (offset / 600).clamp(0.0, 1.0);
      _animationController.value = animationValue; // 애니메이션 컨트롤러에 값 설정

      // 애니메이션 색상 값 업데이트
      Color updatedColor = _colorTween.evaluate(_animationController)!;
      ref.read(bookDetailAppBarColorProvider.notifier).state =
          updatedColor; // 색상 업데이트
    });
    _loadBookDetail();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadBookDetail() async {
    await ref.read(bookDetailProvider.notifier).fetchDetail(ref, widget.bookNo);

    final gardenColor = ref.read(bookDetailProvider).gardenColor;
    if (gardenColor.isNotEmpty) {
      final backgroundColor = Functions.gardenBackColor(gardenColor);
      ref.read(bookDetailAppBarColorProvider.notifier).state = backgroundColor;
      _colorTween = ColorTween(begin: backgroundColor, end: Colors.white);
    }
  }

  Future<void> _moveBook(int toGardenNo) async {
    final statusCode = await ref
        .read(bookDetailProvider.notifier)
        .moveBook(ref, widget.bookNo, toGardenNo);

    if (!mounted) {
      return;
    }

    if (statusCode == 200) {
      context.pop();
      Widgets.showToast(fToast, '선택한 가든으로 옮겨 심었어요');
      final gardenColor = ref.read(bookDetailProvider).gardenColor;
      if (gardenColor.isNotEmpty) {
        final backgroundColor = Functions.gardenBackColor(gardenColor);
        ref.read(bookDetailAppBarColorProvider.notifier).state =
            backgroundColor;
        _colorTween = ColorTween(begin: backgroundColor, end: Colors.white);
      }
    } else if (statusCode == 403) {
      Widgets.showToast(fToast, '꽉 찼어요! 다른 가든을 선택해주세요');
    }
  }

  Future<void> _deleteBook() async {
    final statusCode =
        await ref.read(bookDetailProvider.notifier).deleteBook(widget.bookNo);
    if (!mounted) {
      return;
    }
    if (statusCode == 200) {
      context.pop();
      context.replaceNamed('bottom-navi');
    }
  }

  Future<void> _toggleMemoLike(int index, int id) async {
    await ref.read(bookDetailProvider.notifier).toggleMemoLike(ref, index, id);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(auth_feature.authUserProvider);
    final bookDetail = ref.watch(bookDetailProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.pop('fetchData');
      },
      child: Scaffold(
        backgroundColor: ref.watch(bookDetailAppBarColorProvider),
        appBar: Widgets.appBar(
          context,
          actions: [
            (bookDetail.userNo == user.userNo)
                ? GestureDetector(
                    onTap: _moreBottomSheet,
                    child: Container(
                      alignment: Alignment.center,
                      width: 60.r,
                      height: 60.r,
                      child: AppAssets.iconEllipsis.svg(
                        width: 24.r,
                        height: 24.r,
                      ),
                    ),
                  )
                : Container()
          ],
          backFunction: () => context.pop('fetchData'),
          // color: animatedColor
          color: ref.watch(bookDetailAppBarColorProvider),
        ),
        body: Visibility(
          visible: bookDetail.hasGardenColor,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              color: ref.watch(bookDetailAppBarColorProvider),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24.w,
                          right: 24.w,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: _borderContainer(bookDetail.gardenTitle),
                            ),
                            _borderContainer(Functions.bookStatusString(
                                bookDetail.bookStatus)),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.h, left: 24.w, right: 24.w),
                        child: Text(
                          bookDetail.bookTitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.33.h),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 420.h,
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: AppAssets.bookFlower(
                          bookDetail.bookTree,
                        ).image(
                          width: 360.w,
                          height: 420.h,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, -4),
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16.r)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r))),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 24.h, left: 40.w),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '읽은 페이지',
                                style: TextStyle(
                                    fontSize: 12.sp, color: AppColors.grey_8D),
                              ),
                              Text.rich(TextSpan(
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${bookDetail.bookCurrentPage}p '),
                                    TextSpan(
                                        text: '/ ${bookDetail.bookPage}p',
                                        style: const TextStyle(
                                            color: AppColors.grey_CA))
                                  ]))
                            ],
                          ),
                        ),
                        Visibility(
                          visible: bookDetail.userNo == user.userNo,
                          child: GestureDetector(
                            onTap: () async {
                              final result = await context.pushNamed('book-add',
                                  extra: bookDetail.toBookAddPayload());
                              if (result != null) {
                                _loadBookDetail();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 20.h, right: 30.w),
                              width: 64.r,
                              height: 64.r,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.black_59),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: AppAssets.iconWater.svg(
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                      width: 24.r,
                                      height: 24.r,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '물주기',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.grey_FA),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 24.w,
                              right: 24.w,
                              top: 136.h,
                              bottom: 53.h),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
                                width: 145.w,
                                height: 200.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.grey_F2,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 4),
                                          blurRadius: 16.r,
                                          color: AppColors.black_59
                                              .withOpacity(0.1))
                                    ]),
                                child: (bookDetail.bookImageUrl == null)
                                    ? Container()
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        child: Image.network(
                                            width: 145.w,
                                            height: 200.h,
                                            fit: BoxFit.cover,
                                            bookDetail.bookImageUrl ?? ''),
                                      ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 30.h, bottom: 8.h),
                                child: Text(
                                  bookDetail.bookTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                                child: Text(
                                  bookDetail.bookAuthor,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.grey_8D),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2.h, bottom: 40.h),
                                height: 20.h,
                                child: Text(
                                  bookDetail.bookPublisher,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.grey_8D),
                                ),
                              ),
                              bookDetail.userNo == user.userNo
                                  ? Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 24.w,
                                              right: 38.w,
                                              top: 20.h,
                                              bottom: 2.h),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 8.r,
                                                    color:
                                                        const Color(0xff97CD8D)
                                                            .withOpacity(0.05))
                                              ],
                                              border: Border.all(
                                                  color: AppColors.grey_F2),
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: Colors.white),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 18.h),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '히스토리',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: AppColors
                                                              .grey_8D),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              (bookDetail.bookReadList
                                                            .isNotEmpty)
                                                        ? ListView(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            children:
                                                                List.generate(
                                                              bookDetail
                                                                  .bookReadList
                                                                  .length,
                                                              (index) {
                                                                return Container(
                                                                    margin: EdgeInsets.only(
                                                                        bottom: 18
                                                                            .h),
                                                                    child: _bookReadListWidget(
                                                                        index));
                                                              },
                                                            ),
                                                          )
                                                        : Container()
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 40.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '메모',
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final data = bookDetail
                                                      .toBookAddPayload();
                                                  data['book_no'] =
                                                      widget.bookNo;
                                                  final result = await context
                                                      .pushNamed('memo-write',
                                                          extra: data);

                                                  if (result != null) {
                                                    _loadBookDetail();
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    AppAssets.iconAdd.svg(
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                        AppColors.primaryColor,
                                                        BlendMode.srcIn,
                                                      ),
                                                      width: 16.r,
                                                      height: 16.r,
                                                    ),
                                                    Container(
                                                      color: Colors.transparent,
                                                      child: const Text(
                                                        '작성하기',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        _memoList()
                                      ],
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          left: 24.w,
                                          right: 24.w,
                                          top: 20.h,
                                          bottom: 20.h),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 4),
                                                blurRadius: 8.r,
                                                color: const Color(0xff97CD8D)
                                                    .withOpacity(0.05))
                                          ],
                                          border: Border.all(
                                              color: AppColors.grey_F2),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 8.h),
                                            height: 22.h,
                                            child: Text(
                                              '책 소개',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.grey_8D),
                                            ),
                                          ),
                                          (bookDetail.bookInfo != '')
                                              ? Text(
                                                  bookDetail.bookInfo,
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      height: 1.75.h),
                                                )
                                              : Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      top: 8.h, bottom: 8.h),
                                                  child: Text(
                                                      '소개글이 등록되지 않은 책이에요',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: AppColors
                                                              .grey_8D)),
                                                ),
                                        ],
                                      )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _moreBottomSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.only(top: 20.h, bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final data =
                        ref.watch(bookDetailProvider).toBookAddPayload();

                    context.pop();
                    final response =
                        await context.pushNamed('book-edit', extra: data);
                    if (response != null) {
                      _loadBookDetail();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 26.h,
                    color: Colors.transparent,
                    child: Text(
                      '책 수정하기',
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
                    final gardenNo = ref.watch(bookDetailProvider).gardenNo;
                    if (gardenNo == null) {
                      return;
                    }
                    context.pop();
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => GardenEditBottomSheet(
                              function: (int toGardenNo) {
                                _moveBook(toGardenNo);
                              },
                              gardenNo: gardenNo,
                            ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 26.h,
                    color: Colors.transparent,
                    child: Text(
                      '다른 가든으로 이전',
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
                    _bookDeleteBottomSheet();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 312.w,
                    height: 26.h,
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
        _deleteBook);
  }

  Widget _borderContainer(String title) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.black_59),
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.transparent),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black_59),
      ),
    );
  }

  //독서 기록 리스트 index별 형식
  Widget _bookReadListWidget(int index) {
    final bookDetail = ref.watch(bookDetailProvider);
    final bookReadList = bookDetail.bookReadList;
    final history = bookReadList[index];

    //맨 위(독서 끝)
    return (index == 0 && history.bookEndDate != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: bookDetail.bookTree,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                    text:
                        '${Functions.getPostpositionString(bookDetail.bookTree, '이', '가')} 다컸어요')
              ])),
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  Functions.formatDate(
                      history.bookEndDate ?? DateTime.now().toString()),
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
                ),
              )
            ],
          )
        //맨 아래(독서 시작)
        : (index == bookReadList.length - 1)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    const TextSpan(text: '새로운 꽃 '),
                    TextSpan(
                        text: bookDetail.bookTree,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            '${Functions.getPostpositionString(bookDetail.bookTree, '을', '를')} 심었어요')
                  ])),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      Functions.formatDate(
                          history.bookStartDate ?? DateTime.now().toString()),
                      style:
                          TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
                    ),
                  )
                ],
              )
            //중간 기록
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '${history.bookCurrentPage}p',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' 만큼 물을 주었어요')
                ])),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    Functions.formatDate(
                        history.bookCreatedAt ?? DateTime.now().toString()),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey_8D),
                  ),
                )
              ]);
  }

  //메모 리스트
  Widget _memoList() {
    final bookDetail = ref.watch(bookDetailProvider);
    final memoList = ref.watch(bookDetailMemoListProvider);

    return (memoList.isNotEmpty)
        ? ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.h),
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              memoList.length,
              (index) {
                final memo = memoList[index];
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final data = memo.toRoutePayload(
                          bookNo: widget.bookNo,
                          bookTitle: bookDetail.bookTitle,
                          bookAuthor: bookDetail.bookAuthor,
                          bookImageUrl: bookDetail.bookImageUrl,
                        );

                        final result =
                            await context.pushNamed('memo-detail', extra: data);
                        if (result != null) {
                          _loadBookDetail();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.only(
                            left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                        width: 312.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey_F2),
                            borderRadius: BorderRadius.circular(20.r),
                            color: Colors.transparent),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                (bookDetail.bookImageUrl == null)
                                    ? Container(
                                        width: 44.r,
                                        height: 44.r,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: AppColors.grey_F2),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        child: Image.network(
                                          width: 44.r,
                                          height: 44.r,
                                          fit: BoxFit.cover,
                                          bookDetail.bookImageUrl!,
                                        ),
                                      ),
                                Container(
                                  width: 212.w,
                                  margin: EdgeInsets.only(left: 12.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bookDetail.bookTitle,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        bookDetail.bookAuthor,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.grey_8D),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                                visible: memo.imageUrl != null &&
                                    memo.imageUrl!.isNotEmpty,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                        width: 272.w,
                                        height: 272.w,
                                        fit: BoxFit.cover,
                                        '${Constant.IMAGE_URL}${memo.imageUrl}'),
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 10.h),
                                child: Text(
                                  memo.memoContent,
                                  maxLines: 5,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      overflow: TextOverflow.ellipsis),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 10.h),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Functions.formatDate(
                                            memo.memoCreatedAt),
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.grey_8D),
                                      ),
                                    ])),
                          ],
                        ),
                      ),
                    ),
                    (ref
                            .watch(bookDetailMemoSelectIndexListProvider)
                            .isNotEmpty)
                        ? AnimatedStar(
                            isSelected: ref.watch(
                                bookDetailMemoSelectIndexListProvider)[index],
                            onTap: () => _toggleMemoLike(index, memo.id),
                          )
                        : Container()
                  ],
                );
              },
            ),
          )
        : Container(
            margin: EdgeInsets.only(top: 40.h, bottom: 40.h),
            child: const Text(
              '책을 읽고 마음에 드는 문구나 생각들을\n모두 모아 적어주세요',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.grey_8D),
            ),
          );
  }
}

