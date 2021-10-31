import 'package:flutter/material.dart';

class FirstAidBox extends StatelessWidget {
  final double? height;
  final double? width;

  const FirstAidBox({Key? key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
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
            color: Colors.orange,
            width: width,
            height: 0.05 * height!,
          ),
          SizedBox(height: 0.25 * height!),
          Container(
            // width: 10,
            // height: 10,
            child: CustomPaint(
              size: Size(0.30 * height!, 0.30 * height!),
              painter: FirstAidPainter(),
            ),
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
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(0.5 * size.width, 0.5 * size.height), 0.5 * size.height, paint);
    paint.color = Colors.amber;
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
