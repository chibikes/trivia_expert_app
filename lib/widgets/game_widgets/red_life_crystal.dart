import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RedLifeCrystal extends StatelessWidget {
  final double? height;
  final double? width;

  const RedLifeCrystal({Key? key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: CustomPaint(
          painter: CrystalPainter(),
          size: Size(width!, height!),
        ));
  }
}

class CrystalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // LinearGradient gradient = LinearGradient(colors: [Color(0xff1573a3), Colors.lightBlueAccent]);
    // final Shader shader = gradient.createShader(Rect.fromPoints(Offset(0.5, 0.5), Offset()))
    final Paint paint = Paint()
      ..color = Color(0xffe57373)
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset(0.70 * size.width, 0.2 * size.height),
          Offset(size.width, 0.50 * size.height),
          [Color(0xffbf360c), Color(0xffff5722)]);

    Path pathTwo = Path()
      ..moveTo(0.9 * size.width, 0.539 * size.height)
      ..lineTo(0.50 * size.width, 0)
      ..lineTo(2 / 3 * size.width, 0.65 * size.height);
    canvas.drawPath(pathTwo, paint);

    paint
      ..color = Color(0xffff1744)
      ..shader = ui.Gradient.linear(
          Offset(2 / 3 * size.width, 0.65 * size.height),
          Offset(0.50 * size.width, 0.0 * size.height),
          [Color(0xffe64a19), Color(0xffd84315)]);

    Path pathThree = Path()
      ..moveTo(2 / 3 * size.width, 0.65 * size.height)
      ..lineTo(1 / 3 * size.width, 0.65 * size.height)
      ..lineTo(0.50 * size.width, 0.0);
    canvas.drawPath(pathThree, paint);

    paint
      ..color = Color(0xffe57373)
      ..shader = ui.Gradient.linear(
          Offset(0.5 * size.width, 0.0 * size.height),
          Offset(1 / 3 * size.width, 0.65 * size.height),
          [Color(0xffd32f2f), Color(0xffd84315)]);
    Path pathFour = Path()
      ..moveTo(0.50 * size.width, 0.0)
      ..lineTo(0.1 * size.width, 0.539 * size.height)
      ..lineTo(1 / 3 * size.width, 0.65 * size.height);

    canvas.drawPath(pathFour, paint);

    paint
      ..color = Color(0xffff1744)
      ..shader = ui.Gradient.linear(
          Offset(0.1 * size.width, 0.539 * size.height),
          Offset(1 / 3 * size.width, 0.65 * size.height),
          [Color(0xffff1744), Color(0xffe53935)]);
    Path pathFive = Path()
      ..moveTo(0.1 * size.width, 0.539 * size.height)
      ..lineTo(0.50 * size.width, size.height)
      ..lineTo(1 / 3 * size.width, 0.65 * size.height);
    canvas.drawPath(pathFive, paint);

    paint
      ..color = Color(0xffff1744)
      ..shader = ui.Gradient.linear(
          Offset(1 / 3 * size.width, 0.65 * size.height),
          Offset(2 / 3 * size.width, 0.65 * size.height),
          [Color(0xffc62828), Color(0xffd84315)]);

    Path pathSix = Path()
      ..moveTo(1 / 3 * size.width, 0.65 * size.height)
      ..lineTo(0.50 * size.width, size.height)
      ..lineTo(2 / 3 * size.width, 0.65 * size.height);
    canvas.drawPath(pathSix, paint);

    paint
      ..color = Color(0xffb71c1c)
      ..shader = ui.Gradient.linear(
          Offset(2 / 3 * size.width, 0.65 * size.height),
          Offset(0.50 * size.width, size.height),
          [Color(0xffb71c1c), Color(0xffd32f2f)]);

    Path pathSeven = Path()
      ..moveTo(2 / 3 * size.width, 0.65 * size.height)
      ..lineTo(0.90 * size.width, 0.539 * size.height)
      ..lineTo(0.50 * size.width, size.height);

    canvas.drawPath(pathSeven, paint);

    paint.color = Colors.blue.withAlpha(64);
    canvas.drawCircle(
        Offset(0.5 * size.width, 0.5 * size.height), 0.25 * size.width, paint);
    Paint paintRhombus = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path pathRhombus = Path()
      ..addPolygon([
        Offset(0.1 * size.width, 0.539 * size.height),
        Offset(0.50 * size.width, 0.0),
        Offset(0.90 * size.width, 0.539 * size.height),
        Offset(0.50 * size.width, size.height)
      ], true);

    canvas.drawPath(pathRhombus, paintRhombus);

    final Paint paintLine = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    Path path = Path()
      ..moveTo(0.1 * size.width, 0.539 * size.height)
      ..lineTo(1 / 3 * size.width, 0.65 * size.height)
      ..lineTo(2 / 3 * size.width, 0.65 * size.height)
      ..lineTo(0.90 * size.width, 0.539 * size.height);
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
