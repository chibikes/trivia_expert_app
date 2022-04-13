import 'package:flutter/material.dart';

class CameraIcon extends CustomPainter {
  final double height;
  final double width;

  CameraIcon({this.height = 20, this.width = 25});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromPoints(Offset(0,0.10 * size.height), Offset(size.width, 0.90 * size.height)), Radius.circular(3.0)), paint);

    paint.color = Colors.black45;
    canvas.drawRect(Rect.fromPoints(Offset(0, 0.30 * size.height), Offset(size.width, 0.70 * size.height)), paint);

    paint..color = Colors.black87
    ..style = PaintingStyle.stroke
    ..strokeWidth  = 1.0;

    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height), 0.35 * size.height, paint);
    paint..color = Colors.black54
    ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height), 0.35 * size.height, paint);

    paint.color = Colors.lightBlue;
    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height), 0.30 * size.height, paint);

    paint.color = Colors.white38;
    canvas.drawCircle(Offset(0.43 * size.width, 0.43 * size.height), 0.10 * size.height, paint);

    paint.color = Colors.black87;
    canvas.drawRect(Rect.fromPoints(Offset(0.10 * size.width, 0), Offset(0.30 * size.width,0.10 * size.height)), paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}