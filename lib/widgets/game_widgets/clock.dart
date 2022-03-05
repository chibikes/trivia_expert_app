import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class Clock extends StatelessWidget {
  final height;
  final width;
  final widget;

  const Clock({Key? key, this.height, this.width, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: CustomPaint(
          painter: ClockPainter(),
          size: Size(width!, height!),
          child: widget,
        ));
  }
}
class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
    ..color = Colors.blueGrey;

    canvas.drawRect(Rect.fromPoints(Offset(0.02 * size.width, 0.02 * size.height), Offset(0.50 * size.width, 0.50 * size.height)), paint);
      paint
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth  = 4.0 // TODO: too thick?
      ..shader = ui.Gradient.linear(
          Offset(0.05 * size.width, 0.2 * size.height),
          Offset(size.width, size.height),
          [Colors.lightBlueAccent, Colors.lightBlue]);

    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height), 0.45 * size.width, paint);
    
    paint
      ..strokeWidth = 2.0
      ..color = Color(0xff318cb1)
      ..shader = ui.Gradient.linear(
          Offset(0.05 * size.width, 0.2 * size.height),
          Offset(size.width, size.height),
          [Color(0xff318cb1), Colors.teal]);

    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height), 0.43 * size.width, paint);
    
    Path firstPath = Path()
    ..moveTo(0.05 * size.width, 0.08 * size.height)
    ..arcToPoint(Offset(0.40 * size.width, 0.03 * size.height),largeArc: true,radius: Radius.circular(0.22 * size.width));

    paint
      ..strokeWidth = 2.0
      ..color = Color(0xfffcc201)
      ..shader = ui.Gradient.linear(
          Offset(0.05 * size.width, 0.08 * size.height),
          Offset(0.40 * size.width, 0.03 * size.height),
          [Color(0xffffa500), Color(0xfffcc201)]);

    canvas.drawPath(firstPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
  
}