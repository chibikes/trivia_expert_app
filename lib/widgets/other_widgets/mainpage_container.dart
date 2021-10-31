import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MainPageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const MainPageContainer({Key? key, this.height, this.width, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient:  LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            Color(0xff00b0ff),
            Color(0xff4ac997),
          ]),
        ),
        height: height,
        width: width,
        child: CustomPaint(
          painter: MainPagePainter(),
          // size: Size(width!, height!),
          child: child,
        ));
  }
}

class MainPagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // LinearGradient gradient = LinearGradient(colors: [Color(0xff1573a3), Colors.lightBlueAccent]);
    // final Shader shader = gradient.createShader(Rect.fromPoints(Offset(0.5, 0.5), Offset()))
    final Paint paint = Paint()
      ..color = Color(0xff80deea)
      ..style = PaintingStyle.fill;

    Path pathOne = Path()
      ..moveTo(0.10 * size.width, 0.50 * size.height)
      ..arcToPoint(Offset(0.45 * size.width, 0.45 * size.height),
          radius: Radius.circular(15.0),
          largeArc: true,
          clockwise: true,
          rotation: 24.0)
      ..arcToPoint(Offset(0.55 * size.width, 0.65 * size.height),
          radius: Radius.circular(15.0),
          largeArc: true,
          clockwise: true,
          rotation: 24.0)
      ..arcToPoint(Offset(0.10 * size.width, 0.50 * size.height),
          radius: Radius.circular(15.0),
          largeArc: true,
          clockwise: true,
          rotation: 24.0)
      ..lineTo(0.80 * size.width, 0.65 * size.height);
    canvas.drawPath(pathOne, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
