import 'dart:ui' as ui;

import 'package:book_flutter/shared/utils/functions.dart';
import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/book/domain/entities/book_add_done_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_read_input_entity.dart';
import 'package:book_flutter/core/review/in_app_review_helper.dart';
import 'package:book_flutter/features/book/presentation/providers/book_add_provider.dart';
import 'package:book_flutter/app/navigation/bottom_navi_page.dart';
import 'package:book_flutter/features/garden/presentation/providers/garden_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BookAddPage extends ConsumerStatefulWidget {
  const BookAddPage({super.key, required this.bookRead});

  final BookReadInputEntity bookRead;

  @override
  ConsumerState<BookAddPage> createState() => _BookAddPageState();
}

class _BookAddPageState extends ConsumerState<BookAddPage> {
  final TextEditingController _textEditingController = TextEditingController();
  double dragPosition = 0.0;
  late String imagePath;
  int currentPage = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    imagePath = AppAssets.pageFlower(widget.bookRead.bookTree).path;
    dragPosition = 0.0;
    currentPage = widget.bookRead.bookCurrentPage;
    dragPosition = widget.bookRead.bookPage > 0
        ? (currentPage / widget.bookRead.bookPage)
        : 0.0;
    _textEditingController.addListener(_validateInput);
    _textEditingController.text = widget.bookRead.bookCurrentPage.toString();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController.removeListener(_validateInput);
    super.dispose();
  }

  //독서 기록 추가 api
  void postBookRead() async {
    final result = await saveBookRead(
      ref,
      bookRead: widget.bookRead,
      currentPage: currentPage,
    );
    if (!mounted) return;
    if (result.statusCode == 201) {
      if (result.done != null) {
        FirebaseAnalytics.instance.logEvent(
          name: 'book_completed',
          parameters: {
            'book_title': widget.bookRead.bookTitle,
            'book_pages': widget.bookRead.bookPage,
          },
        );
        // 완독한 긍정적 순간에 인앱 리뷰 프롬프트 시도
        InAppReviewHelper.maybeRequestAfterBookCompleted();
        context.pushReplacementNamed('book-add-done',
            extra: result.done!.toJson());
      } else {
        context.pop('fetchData');
      }
    }
  }

  //텍스트필드 최대 페이지 제한
  void _validateInput() {
    final int currentValue = int.tryParse(_textEditingController.text) ?? 0;
    if (currentValue > widget.bookRead.bookPage) {
      _textEditingController.text = widget.bookRead.bookPage.toString();
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context, title: widget.bookRead.bookTitle),
        body: Container(
          margin: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    '어디까지 읽었나요?',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 90.h),
                    child: GestureDetector(
                      onTap: () async {
                        final result = await pageBottomSheet(
                            context,
                            _textEditingController,
                            widget.bookRead.bookCurrentPage);

                        if (result != null) {
                          currentPage = result;
                          setState(() {
                            dragPosition = widget.bookRead.bookPage > 0
                                ? (currentPage / widget.bookRead.bookPage)
                                : 0.0;
                          });
                        }
                      },
                      child: Text.rich(TextSpan(
                          style: TextStyle(
                              fontSize: 32.sp, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: '${currentPage}p',
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    decorationColor: AppColors.primaryColor,
                                    decoration: ui.TextDecoration.underline)),
                            TextSpan(
                                text: ' / ${widget.bookRead.bookPage}p',
                                style:
                                    const TextStyle(color: AppColors.grey_CA))
                          ])),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  AnimatedScale(
                    scale: _isDragging ? 0.92 : 1.0,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    child: Stack(
                    children: [
                      Center(
                          child: Image.asset(
                        imagePath,
                        width: 280,
                        height: 304,
                      )),
                      Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onVerticalDragStart: (_) {
                            setState(() => _isDragging = true);
                          },
                          onVerticalDragEnd: (_) {
                            setState(() => _isDragging = false);
                          },
                          onVerticalDragCancel: () {
                            setState(() => _isDragging = false);
                          },
                          onVerticalDragUpdate: (details) {
                            setState(() {
                              dragPosition -=
                                  details.primaryDelta! / 304;
                              dragPosition = dragPosition.clamp(0.0, 1.0);
                              currentPage =
                                  (widget.bookRead.bookPage * dragPosition)
                                      .toInt();
                              _textEditingController.text =
                                  currentPage.toString();
                            });
                          },
                          child: SizedBox(
                            width: 280,
                            height: 304,
                            child: ClipRect(
                              clipper: _BottomRevealClipper(dragPosition),
                              child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                    AppColors.black_59, BlendMode.srcIn),
                                child: Image.asset(
                                  imagePath,
                                  width: 280,
                                  height: 304,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 26.h),
                    child: const Text(
                      '물을 주려면 위로 슬라이드 해주세요',
                      style: TextStyle(color: AppColors.grey_8D),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Widgets.bottomBar(context, child: Widgets.button('저장하기', true, () {
            postBookRead();
          }),
        ));
  }
}

Future pageBottomSheet(
    BuildContext context, TextEditingController controller, int page) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          margin: EdgeInsets.only(
            top: 30.h,
            left: 24.w,
            right: 24.w,
            bottom: 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '읽은 페이지',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      counter: Container(),
                      fillColor: AppColors.grey_FA,
                      filled: true,
                      hintStyle:
                          TextStyle(fontSize: 16.sp, color: AppColors.grey_8D),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              color: Colors.transparent, width: 1.w)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              color: Colors.transparent, width: 1.w)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              color: Colors.transparent, width: 1.w))),
                ),
              ),
              Widgets.button('확인', true, () {
                final page = int.tryParse(controller.text);
                if (page != null) context.pop(page);
              }),
            ],
          ),
        ),
      );
    },
  );
}


class _BottomRevealClipper extends CustomClipper<Rect> {
  _BottomRevealClipper(this.revealFraction);

  final double revealFraction;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      0,
      size.height * (1 - revealFraction),
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(_BottomRevealClipper oldClipper) {
    return oldClipper.revealFraction != revealFraction;
  }
}

class BookAddDonePage extends ConsumerStatefulWidget {
  const BookAddDonePage({super.key, required this.bookRead});

  final BookAddDoneEntity bookRead;

  @override
  ConsumerState<BookAddDonePage> createState() => _BookAddDonePageState();
}

class _BookAddDonePageState extends ConsumerState<BookAddDonePage> {
  //별점 (0 = 선택 전)
  int _rating = 0;

  static const _starCount = 5;

  double get _starSize => 32.r;
  double get _starGap => 4.w;

  //별점별 문구 (index 0 = 선택 전)
  static const _ratingTexts = [
    '이 책 어떠셨나요?',
    '끝까지 읽은 나에게 치얼스',
    '나와는 조금 안 맞았다',
    '무난하게 잘 읽었다',
    '언젠가 다시 펼쳐볼 책',
    '오늘부터 나의 인생책',
  ];

  //x좌표로 별점 계산 (첫 별 왼쪽으로 나가면 0점)
  int _ratingByPosition(double dx) {
    if (dx < 0) return 0;
    final index = (dx / (_starSize + _starGap)).floor();
    return (index + 1).clamp(0, _starCount);
  }

  //같은 별을 다시 누르면 0점으로
  void _onStarTap(double dx) {
    final tapped = _ratingByPosition(dx);
    setState(() => _rating = tapped == _rating ? 0 : tapped);
  }

  void _onStarDrag(double dx) {
    final dragged = _ratingByPosition(dx);
    if (dragged != _rating) setState(() => _rating = dragged);
  }

  void _goToGarden() async {
    ref.read(currentIndexProvider.notifier).state = 0;
    ref.read(gardenVisitCountProvider.notifier).state++;
    final targetGardenNo = ref.read(gardenNavigateToProvider);
    if (targetGardenNo != null) {
      await updateMainGarden(ref, targetGardenNo);
      ref.read(gardenNavigateToProvider.notifier).state = null;
    }
    if (!mounted) return;
    context.go('/bottom-navi');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _goToGarden();
      },
      child: Scaffold(
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.only(top: 60.h),
          child: Center(
            child: Column(
              children: [
                Text.rich(
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                    TextSpan(children: [
                      TextSpan(
                          text: widget.bookRead.bookTree,
                          style:
                              const TextStyle(color: AppColors.primaryColor)),
                      TextSpan(
                          text:
                              '${Functions.getPostpositionString(widget.bookRead.bookTree, '이', '가')} 다컸어요')
                    ])),
                Container(
                  margin: EdgeInsets.only(top: 24.h, bottom: 20.h),
                  width: 260.r,
                  height: 260.r,
                  child: AppAssets.okFlower(widget.bookRead.bookTree).image(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 6.h, left: 48.w, right: 48.w),
                  child: Text(
                    widget.bookRead.bookTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${Functions.formatBookReadDate(widget.bookRead.bookStartDate)} - ${Functions.formatBookReadDate(widget.bookRead.bookEndDate)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.grey_8D),
                ),
                //별점
                Container(
                  margin: EdgeInsets.only(top: 40.h),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  width: 312.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.grey_F2, width: 1.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapDown: (details) =>
                            _onStarTap(details.localPosition.dx),
                        onHorizontalDragStart: (details) =>
                            _onStarDrag(details.localPosition.dx),
                        onHorizontalDragUpdate: (details) =>
                            _onStarDrag(details.localPosition.dx),
                        child: SizedBox(
                          width: _starSize * _starCount +
                              _starGap * (_starCount - 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: _starGap,
                            children: List.generate(_starCount, (index) {
                              final selected = index < _rating;
                              return (selected
                                      ? AppAssets.iconStarSelect
                                      : AppAssets.iconStarDeselect)
                                  .svg(
                                width: _starSize,
                                height: _starSize,
                                colorFilter: ColorFilter.mode(
                                  selected
                                      ? AppColors.starSelectColor
                                      : AppColors.grey_CA,
                                  BlendMode.srcIn,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.h),
                        child: Text(
                          _ratingTexts[_rating],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: _rating == 0
                                ? AppColors.grey_8D
                                : AppColors.starSelectColor,
                            fontWeight: _rating == 0
                                ? FontWeight.w400
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
        bottomNavigationBar: Widgets.bottomBar(context, child: Widgets.button('가든으로 가기', true, () {
            _goToGarden();
            //TODO: - 자동으로 해당 가든 변경?
          }),
        )),
    );
  }
}
