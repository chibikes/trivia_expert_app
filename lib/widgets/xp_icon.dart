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
      ..addPolygon([
        Offset(0.50 * size.width, 0),
        Offset(0, 0.25 * size.height),
        Offset(0, 0.75 * size.height),
        Offset(0.50 * size.width, size.height),
        Offset(size.width, 0.75 * size.height),
        Offset(size.width, 0.25 * size.height)
      ], true);
    canvas.drawPath(path, paint);

    paint.color = colorTwo;
    path.reset();
    path..addPolygon([
    Offset(0.50 * size.width, 0.10 * size.height),
    Offset(0.10 * size.width, 0.30 * size.height),
    Offset(0.10 * size.width, 0.70 * size.height),
    Offset(0.50 * size.width, 0.90 * size.height),
    Offset(0.90 * size.width, 0.70 * size.height),
    Offset(0.90 * size.width, 0.30 * size.height)
    ], true);

    canvas.drawPath(path, paint);
    path.reset();
    paint.color = Colors.white10;
    path..addPolygon([Offset(0, 0.60 * size.height), Offset(0, 0.75 * size.height), Offset(0.10 * size.width, 0.80 * size.height), Offset(size.width, 0.30 * size.height), Offset(size.width, 0.25 * size.height), Offset(0.77 * size.width, 0.15 * size.height)], false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
