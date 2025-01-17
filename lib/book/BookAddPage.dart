import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../core/service/BookService.dart';
import '../utils/AppColors.dart';
import '../utils/Functions.dart';
import '../utils/Widgets.dart';

class BookAddPage extends ConsumerStatefulWidget {
  const BookAddPage({required this.bookRead});

  final Map bookRead;

  _BookAddPageState createState() => _BookAddPageState();
}

class _BookAddPageState extends ConsumerState<BookAddPage> {
  final TextEditingController _textEditingController = TextEditingController();
  ui.Image? image;
  ui.Image? overlayImage;
  double dragPosition = 0.0; // From 0.0 to 1.0
  String imagePath = 'assets/images/testImage.png';
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    dragPosition = 0.0;
    currentPage = widget.bookRead['book_current_page'];
    dragPosition = (currentPage / widget.bookRead['book_page']);
    _textEditingController.addListener(_validateInput);
    _loadImage();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController.removeListener(_validateInput);
    super.dispose();
  }

  //독서 기록 추가 api
  void postBookRead() async {
    final data = {
      "book_no": widget.bookRead['book_no'],
      "book_current_page": currentPage
    };

    //책 기록이 없을 때
    if (widget.bookRead['book_current_page'] == 0) {
      data['book_start_date'] = DateTime.now().toString();
    }
    //책 다 읽었을 때
    if (currentPage == widget.bookRead['book_page']) {
      data['book_end_date'] = DateTime.now().toString();
    }
    final response = await bookService.postBookRead(data);
    if (response?.statusCode == 201) {
      if (currentPage == widget.bookRead['book_page']) {
        final bookReadData = {
          'book_title': widget.bookRead['book_title'],
          'book_tree': widget.bookRead['book_tree'],
          'book_start_date': widget.bookRead['book_read_list']
              [widget.bookRead['book_read_list'].length - 1]['book_start_date'],
          'book_end_date': DateTime.now().toString()
        };

        context.pushReplacementNamed('book-add-done', extra: bookReadData);
      } else {
        context.pop('fetchData');
      }
    }
  }

  Future<void> _loadImage() async {
    // Load main image
    final ByteData data = await rootBundle.load(imagePath);
    final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: 280,
        targetHeight: 304);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image mainImage = frameInfo.image;

    // Load overlay image
    final ByteData overlayData = await rootBundle.load(imagePath);
    final ui.Codec overlayCodec = await ui.instantiateImageCodec(
        overlayData.buffer.asUint8List(),
        targetWidth: 280,
        targetHeight: 304);
    final ui.FrameInfo overlayFrameInfo = await overlayCodec.getNextFrame();
    final ui.Image overlayImage = overlayFrameInfo.image;

    setState(() {
      image = mainImage;
      this.overlayImage = overlayImage;
    });
  }

  //텍스트필드 최대 페이지 제한
  void _validateInput() {
    final int currentValue = int.tryParse(_textEditingController.text) ?? 0;
    if (currentValue > widget.bookRead['book_page']) {
      _textEditingController.text =
          widget.bookRead['book_page'].toString(); // 값이 범위를 초과하면 최대값으로 설정
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBar(context, title: widget.bookRead['book_title']),
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
                            widget.bookRead['book_current_page']);

                        if (result != null) {
                          currentPage = result;
                          setState(() {
                            dragPosition =
                                (currentPage / widget.bookRead['book_page']);
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
                                text: ' / ${widget.bookRead['book_page']}p',
                                style:
                                    const TextStyle(color: AppColors.grey_CA))
                          ])),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Center(
                          child: Image.asset(
                        imagePath,
                        width: 280,
                        height: 304,
                      )),
                      Center(
                        child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              setState(() {
                                dragPosition -= details.primaryDelta! /
                                    context.size!.height;
                                dragPosition = dragPosition.clamp(0.0, 1.0);
                                currentPage = (widget.bookRead['book_page'] *
                                        dragPosition)
                                    .toInt();
                              });
                            },
                            child: image == null || overlayImage == null
                                ? Container()
                                : CustomPaint(
                                    size: Size(image!.width.toDouble(),
                                        image!.height.toDouble()),
                                    painter: RevealPainter(
                                        dragPosition, image!, overlayImage!),
                                  )),
                      ),
                    ],
                  ),
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
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button('저장하기', true, () {
            postBookRead();
          }),
        ));
  }
}

Future pageBottomSheet(
    BuildContext context, TextEditingController controller, int page) {
  controller.text = page.toString();
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.white,
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 236.h,
          margin: EdgeInsets.only(
            top: 30.h,
            left: 24.w,
            right: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '읽은 페이지',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.h, bottom: 30.h),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      counter: Container(),
                      fillColor: AppColors.grey_FA,
                      filled: true,
                      // hintText: page.toString(),
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
                int page = int.parse(controller.text);
                context.pop(page);
              }),
            ],
          ),
        ),
      );
    },
  );
}

class RevealPainter extends CustomPainter {
  final double dragPosition;
  final ui.Image image;
  final ui.Image overlayImage;

  RevealPainter(this.dragPosition, this.image, this.overlayImage);

  @override
  void paint(Canvas canvas, Size size) {
    // Paint object with no colorFilter for the main image
    final paint = Paint();

    final revealHeight = size.height * dragPosition;

    // The source rectangle to be drawn from the image
    final srcRect = Rect.fromLTRB(0, image.height * (1 - dragPosition),
        image.width.toDouble(), image.height.toDouble());
    // The destination rectangle where the image portion will be drawn
    final dstRect =
        Rect.fromLTWH(0, size.height - revealHeight, size.width, revealHeight);

    // Draw the revealed part of the main image
    canvas.drawImageRect(image, srcRect, dstRect, paint);

    // Overlay image with black color filter
    final overlayPaint = Paint()
      ..colorFilter = const ColorFilter.mode(Colors.black, BlendMode.srcIn);

    // Draw the overlay image as black
    canvas.drawImageRect(overlayImage, srcRect, dstRect, overlayPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BookAddDonePage extends StatelessWidget {
  BookAddDonePage({super.key, required this.bookRead});

  Map bookRead;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          text: bookRead['book_tree'],
                          style:
                              const TextStyle(color: AppColors.primaryColor)),
                      TextSpan(
                          text:
                              '${Functions.getPostpositionString(bookRead['book_tree'], '이', '가')} 다컸어요')
                    ])),
                Container(
                  margin: EdgeInsets.only(top: 40.h, bottom: 30.h),
                  width: 250.r,
                  height: 250.r,
                  color: Colors.amber,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 6.h, left: 48.w, right: 48.w),
                  child: Text(
                    bookRead['book_title'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${Functions.formatBookReadDate(bookRead['book_start_date'])} - ${Functions.formatBookReadDate(bookRead['book_end_date'])}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.grey_8D),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
          child: Widgets.button('가든으로 가기', true, () {
            context.replaceNamed('bottom-navi');
            //TODO: - 자동으로 해당 가든 변경?
          }),
        ));
  }
}
