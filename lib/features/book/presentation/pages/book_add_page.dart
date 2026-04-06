import 'dart:ui' as ui;

import 'package:book_flutter/shared/utils/functions.dart';
import 'package:book_flutter/shared/theme/app_assets.dart';
import 'package:book_flutter/shared/theme/app_colors.dart';
import 'package:book_flutter/shared/widgets/app_widgets.dart';
import 'package:book_flutter/features/book/domain/entities/book_add_done_entity.dart';
import 'package:book_flutter/features/book/domain/entities/book_read_input_entity.dart';
import 'package:book_flutter/features/book/presentation/providers/book_add_provider.dart';
import 'package:book_flutter/features/garden/presentation/providers/garden_provider.dart';
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
    dragPosition = (currentPage / widget.bookRead.bookPage);
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
                            dragPosition =
                                (currentPage / widget.bookRead.bookPage);
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

class BookAddDonePage extends ConsumerWidget {
  const BookAddDonePage({super.key, required this.bookRead});

  final BookAddDoneEntity bookRead;

  void _goToGarden(BuildContext context, WidgetRef ref) {
    ref.read(gardenVisitCountProvider.notifier).state++;
    context.go('/bottom-navi');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _goToGarden(context, ref);
      },
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 174.h),
          child: Center(
            child: Column(
              children: [
                Text.rich(
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                    TextSpan(children: [
                      TextSpan(
                          text: bookRead.bookTree,
                          style:
                              const TextStyle(color: AppColors.primaryColor)),
                      TextSpan(
                          text:
                              '${Functions.getPostpositionString(bookRead.bookTree, '이', '가')} 다컸어요')
                    ])),
                Container(
                  margin: EdgeInsets.only(top: 24.h, bottom: 20.h),
                  width: 260.r,
                  height: 260.r,
                  child: AppAssets.okFlower(bookRead.bookTree).image(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 6.h, left: 48.w, right: 48.w),
                  child: Text(
                    bookRead.bookTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${Functions.formatBookReadDate(bookRead.bookStartDate)} - ${Functions.formatBookReadDate(bookRead.bookEndDate)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.grey_8D),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Widgets.bottomBar(context, child: Widgets.button('가든으로 가기', true, () {
            _goToGarden(context, ref);
            //TODO: - 자동으로 해당 가든 변경?
          }),
        )),
    );
  }
}
