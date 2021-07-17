import 'package:flutter/material.dart';

class FirstAidBox extends StatelessWidget {
  final double? height;
  final double? width;

  const FirstAidBox({Key? key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      alignment: Alignment.center,
      height: height,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: 0.15 * height!,
          ),
          Container(
            color: Colors.grey,
            width: width!,
            height: 0.10 * height!,
          ),
          SizedBox(height: 0.15 * height!),
          CustomPaint(
            size: Size(width! / 2.0, height! / 2.0),
            painter: FirstAidPainter(),
          ),
        ],
      ),
    );
  }
}

class FirstAidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(0.5 * size.width, 0.5 * size.height), 0.5 * size.height, paint);
    paint.color = Colors.white;
    Path path = Path()
      ..moveTo(0.40 * size.width, 0.20 * size.height)
      ..lineTo(0.40 * size.width, 0.40 * size.height)
      ..lineTo(0.20 * size.width, 0.40 * size.height)
      ..lineTo(0.20 * size.width, 0.60 * size.height)
      ..lineTo(0.40 * size.width, 0.60 * size.height)
      ..lineTo(0.40 * size.width, 0.80 * size.height)
      ..lineTo(0.60 * size.width, 0.80 * size.height)
      ..lineTo(0.60 * size.width, 0.60 * size.height)
      ..lineTo(0.80 * size.width, 0.60 * size.height)
      ..lineTo(0.80 * size.width, 0.40 * size.height)
      ..lineTo(0.60 * size.width, 0.40 * size.height)
      ..lineTo(0.60 * size.width, 0.20 * size.height)
      // ..lineTo(0.40 * size.width, 0.20 * size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
