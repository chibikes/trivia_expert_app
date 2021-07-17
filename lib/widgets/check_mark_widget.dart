import 'package:flutter/material.dart';
import 'dart:math' as math;

class CheckMark extends StatelessWidget {
  final double? height;
  final double? width;

  final bool smallSize;

  const CheckMark({
    Key? key,
    this.height,
    this.width,
    this.smallSize = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      alignment: Alignment.center,
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            // width: 10,
            // height: 10,
            child: CustomPaint(
              size: Size(0.90 * height!, 0.90 * width!),
              painter: CheckMarkPainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 58),
            child: Transform.rotate(
              angle: -0.698132,
              child: Container(
                height: smallSize ? 0.0 : 0.06 * height!,
                width: smallSize ? 0.0 : 0.20 * width!,
                decoration: BoxDecoration(
                    color: Color(0xb323cb6d),
                    borderRadius: BorderRadius.all(Radius.circular(24.0))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 15),
            child: Transform.rotate(
              angle: 0.698132,
              child: Container(
                height: smallSize ? 0.0 : 0.06 * height!,
                width: smallSize ? 0.0 : 0.1 * width!,
                decoration: BoxDecoration(
                    color: Color(0xb323cb6d),
                    borderRadius: BorderRadius.all(Radius.circular(24.0))),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CheckMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green
      // ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0.50 * size.width, 0.80 * size.height)
      ..lineTo(0.10 * size.width, 0.50 * size.height)
      // ..conicTo(0.10 * size.width, 0.50 * size.height, 0.40 * size.width,
      //     0.30 * size.height, 0.6)
      ..arcToPoint(Offset(0.25 * size.width, 0.35 * size.height),
          radius: Radius.circular(0.8), largeArc: true)
      ..lineTo(0.45 * size.width, 0.50 * size.height)
      ..lineTo(0.85 * size.width, 0.20 * size.height)
      ..arcToPoint(Offset(size.width, 0.35 * size.height),
          radius: Radius.circular(0.8), largeArc: true)
      ..lineTo(0.50 * size.width, 0.80 * size.height);
    // ..close();

    // ..lineTo(0.40 * size.width, 0.20 * size.height)
    // ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
