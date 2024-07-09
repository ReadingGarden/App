import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookAddPage extends ConsumerStatefulWidget {
  _BookAddPageState createState() => _BookAddPageState();
}

class _BookAddPageState extends ConsumerState<BookAddPage> {
  final double _minY = 50.0; // 최소 y 값
  final double _maxY = 300.0; // 최대 y 값
  final double _baseHeight = 100.0; // 기본 높이
  final double _maxHeight = 200.0; // 최대 높이

  //현재 위치 저장
  // double _xOffset = 0;
  double _yOffset = 0;

  //드래그 만큼 위치 업데이트
  void _updatePosition(DragUpdateDetails details) {
    setState(() {
      // _xOffset += details.delta.dx;
      _yOffset += details.delta.dy;
      print(_yOffset);

      // y 포지션 제한
      if (_yOffset < _minY) {
        _yOffset = _minY;
      } else if (_yOffset > _maxY) {
        _yOffset = _maxY;
      }
    });
  }

  double _calculateHeight() {
    // y 위치에 따라 height 계산 (하단 고정)
    double heightRange = _maxHeight - _baseHeight;
    double yRange = _maxY - _minY;
    double heightFactor = (_maxY - _yOffset) / yRange;
    return _baseHeight + heightRange * heightFactor;
    // // y 위치에 따라 height 계산
    // double heightRange = _maxHeight - _baseHeight;
    // double yRange = _maxY - _minY;
    // double heightFactor = (_maxY - _yOffset) / yRange;
    // return _baseHeight + heightRange * heightFactor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300,
            height: 500,
            color: Colors.black,
          ),
          // Positioned.fill(
          //   child: CustomPaint(
          //     painter: BackgroundPainter(yOffset: _yOffset),
          //   ),
          // ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            // left: _xOffset,
            // top: _yOffset,
            child: GestureDetector(
              onPanUpdate: _updatePosition,
              child: Container(
                width: 300,
                height: _calculateHeight(),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Drag me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onVerticalDragUpdate: (details) {
            //     print('update $details');
            //   },
            //   onVerticalDragStart: (details) {
            //     print('start $details');
            //   },
            //   child: Container(
            //     width: 400,
            //     height: 100,
            //     color: Colors.red,
            //   ),
            // ),
          )
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double yOffset;

  BackgroundPainter({required this.yOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(0, size.height - yOffset, size.width, yOffset), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
