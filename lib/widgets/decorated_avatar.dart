import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DecoratedAvatar extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const DecoratedAvatar({Key? key, this.height, this.width, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: CustomPaint(
          painter: DecoratedAvatarPainter(),
          size: Size(width!, height!),
          child: child,
        ));
  }
}

class DecoratedAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // LinearGradient gradient = LinearGradient(colors: [Color(0xff1573a3), Colors.lightBlueAccent]);
    // final Shader shader = gradient.createShader(Rect.fromPoints(Offset(0.5, 0.5), Offset()))
    final Paint paint = Paint()
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth  = 4.0 // TODO: too thick?
      ..shader = ui.Gradient.linear(
          Offset(0.05 * size.width, 0.2 * size.height),
          Offset(size.width, size.height),
          [Colors.lightBlueAccent, Colors.lightBlue]);

    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height), 0.48 * size.width, paint);
    paint
    ..strokeWidth = 2.0
    ..color = Color(0xff318cb1)
      ..shader = ui.Gradient.linear(
          Offset(0.05 * size.width, 0.2 * size.height),
          Offset(size.width, size.height),
          [Color(0xff318cb1), Colors.teal]);

    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height), 0.46 * size.width, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
