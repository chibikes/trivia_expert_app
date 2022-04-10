import 'package:flutter/material.dart';
class TrophyLayer extends StatelessWidget {
  final double height;
  final double width;

  const TrophyLayer({Key? key, this.height = 0, this.width  = 0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      height: height,
      width: width,
      child: CustomPaint(
        painter: TrophyLayerPainter(),
        size: Size(width, height),
      ),
    );

  }

}

class TrophyLayerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
        ..color = Colors.white24
        ..style = PaintingStyle.fill;

    Path path = Path()
    ..moveTo(0.55 * size.width, 0.10 * size.height)
    ..lineTo(0.20 * size.width, 0.10 * size.height)
    ..cubicTo(0.203 * size.width, 0.11 * size.height, 0.208 * size.width, 0.68 * size.height, 0.55 * size.width, 0.70 * size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}