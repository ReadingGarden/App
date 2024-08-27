import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookAddPage extends ConsumerStatefulWidget {
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
      'assets/images/Intersect.png',
    );
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image mainImage = frameInfo.image;

    // Load overlay image
    final ByteData overlayData =
        await rootBundle.load('assets/images/Intersect.png');
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
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            'assets/images/Intersect.png',
          )),
          CustomPaint(
            size: Size(image!.width.toDouble(), image!.height.toDouble()),
            painter: LinePainter(dragPosition, image!),
          ),
          Center(
            child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    dragPosition -=
                        details.primaryDelta! / context.size!.height;
                    dragPosition = dragPosition.clamp(0.0, 1.0);
                  });
                },
                child: image == null || overlayImage == null
                    ? CircularProgressIndicator()
                    : CustomPaint(
                        size: Size(
                            image!.width.toDouble(), image!.height.toDouble()),
                        painter:
                            RevealPainter(dragPosition, image!, overlayImage!),
                      )),
          ),
        ],
      ),
    );
  }
}

class RevealPainter extends CustomPainter {
  final double dragPosition;
  final ui.Image image;
  final ui.Image overlayImage;

  RevealPainter(this.dragPosition, this.image, this.overlayImage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..colorFilter = ColorFilter.mode(
        Colors.red,
        BlendMode.srcIn,
      );
    final revealHeight = size.height * dragPosition;

    // Draw the revealed part of the main image

    // The source rectangle to be drawn from the image
    final srcRect = Rect.fromLTRB(0, image.height * (1 - dragPosition),
        image.width.toDouble(), image.height.toDouble());
    // The destination rectangle where the image portion will be drawn
    final dstRect =
        Rect.fromLTWH(0, size.height - revealHeight, size.width, revealHeight);
    // Draw the revealed part of the image
    canvas.drawImageRect(image, srcRect, dstRect, paint);

    // Draw dotted border around the revealed area
    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final borderPath = Path()
      ..moveTo(0, size.height - revealHeight)
      ..lineTo(size.width, size.height - revealHeight)
      ..close();

    // // print(revealHeight);

    _drawDottedPath(canvas, borderPath, borderPaint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    const double dashWidth = 5.0;
    const double dashSpace = 5.0;

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final start = distance;
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        final length = end - start;
        final tangent = metric.getTangentForOffset(start);

        if (tangent != null) {
          final offset = tangent.position;
          final dx = tangent.vector.dx;
          final dy = tangent.vector.dy;

          final dashPath = Path()
            ..moveTo(offset.dx, offset.dy)
            ..lineTo(
              offset.dx + length * dx,
              offset.dy + length * dy,
            );
          canvas.drawPath(dashPath, paint);
        }

        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LinePainter extends CustomPainter {
  final double dragPosition;
  final ui.Image image;

  LinePainter(this.dragPosition, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..colorFilter = ColorFilter.mode(
        Colors.blue,
        BlendMode.srcIn,
      );
    final revealHeight = size.height * dragPosition;

    canvas.drawImage(image, Offset(0, size.height - revealHeight), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
