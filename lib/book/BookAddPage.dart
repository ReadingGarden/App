import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/AppColors.dart';
import '../utils/Widgets.dart';

class BookAddPage extends ConsumerStatefulWidget {
  const BookAddPage({required this.bookRead});

  final Map bookRead;

  _BookAddPageState createState() => _BookAddPageState();
}

class _BookAddPageState extends ConsumerState<BookAddPage> {
  ui.Image? image;
  ui.Image? overlayImage;
  double dragPosition = 0.0; // From 0.0 to 1.0

  @override
  void initState() {
    super.initState();
    dragPosition = 0.0;
    _loadImage();
  }

  Future<void> _loadImage() async {
    // Load main image
    final ByteData data = await rootBundle.load(
      'assets/images/290test.png',
    );
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image mainImage = frameInfo.image;

    // Load overlay image
    final ByteData overlayData =
        await rootBundle.load('assets/images/290test.png');
    final ui.Codec overlayCodec =
        await ui.instantiateImageCodec(overlayData.buffer.asUint8List());
    final ui.FrameInfo overlayFrameInfo = await overlayCodec.getNextFrame();
    final ui.Image overlayImage = overlayFrameInfo.image;

    setState(() {
      image = mainImage;
      this.overlayImage = overlayImage;
    });
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
                    padding: EdgeInsets.only(top: 20.h, bottom: 71.h),
                    child: Text.rich(TextSpan(
                        style: TextStyle(
                            fontSize: 32.sp, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: '${widget.bookRead['book_current_page']}p',
                              style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  decorationColor: AppColors.primaryColor,
                                  decoration: ui.TextDecoration.underline)),
                          TextSpan(
                              text: ' / ${widget.bookRead['book_page']}p',
                              style: const TextStyle(color: AppColors.grey_CA))
                        ])),
                  )
                ],
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/images/290test.png',
                        // width: 280.w,
                        // height: 306.h,
                        color: Colors.black,
                      )),
                      // Center(
                      //   child: CustomPaint(
                      //     size: Size(image!.width.toDouble(),
                      //         image!.height.toDouble()),
                      //     painter: RevealPainter(dragPosition, image!, image!),
                      //   ),
                      // ),
                      Center(
                        child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              setState(() {
                                dragPosition -= details.primaryDelta! /
                                    context.size!.height;
                                dragPosition = dragPosition.clamp(0.0, 1.0);
                              });
                            },
                            child: image == null || overlayImage == null
                                ? const CircularProgressIndicator()
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
          child: Widgets.button('저장하기', true, () {}),
        ));
  }
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
