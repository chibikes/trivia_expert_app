import 'package:flutter/material.dart';

class XPPainter extends CustomPainter {
  final Color color;
  final Color colorTwo;

  XPPainter(this.color, this.colorTwo);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0.10 * size.width, 0.50 * size.height)
      ..lineTo(0.40 * size.width, 0.10 * size.height)
      ..quadraticBezierTo(0.50 * size.width, 0.05 * size.height,
          0.55 * size.width, 0.15 * size.height)
      ..lineTo(0.55 * size.width, 0.35 * size.height)
      ..lineTo(0.90 * size.width, 0.40 * size.height)
      ..quadraticBezierTo(0.95 * size.width, 0.45 * size.height,
          0.93 * size.width, 0.50 * size.height)
      ..lineTo(0.55 * size.width, 0.90 * size.height)
      ..quadraticBezierTo(0.45 * size.width, 0.95 * size.height,
          0.40 * size.width, 0.87 * size.height)
      ..lineTo(0.40 * size.width, 0.60 * size.height)
      ..lineTo(0.15 * size.width, 0.55 * size.height)
      ..quadraticBezierTo(0.07 * size.width, 0.50 * size.height,
          0.10 * size.width, 0.50 * size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
