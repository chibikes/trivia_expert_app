import 'package:flutter/material.dart';

class Shine extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? shineExtra;

  const Shine({Key? key, this.height, this.width, this.shineExtra})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CustomPaint(
        size: Size(width!, height!),
        painter: ShinePainter(shineExtra),
      ),
    );
  }
}

class ShinePainter extends CustomPainter {
  final shineXtra;

  ShinePainter(this.shineXtra);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0.5 * size.width, 0.50 * size.height),
        shineXtra ? 0.05 * size.height : 0.15 * size.height, paint);
    paint.color = Colors.white.withAlpha(170);

    canvas.drawCircle(Offset(0.50 * size.width, 0.50 * size.height),
        shineXtra ? 0.10 * size.height : 0.30 * size.width, paint);

    paint.color = Colors.white;
    Path path = Path()
      ..moveTo(size.width * 0.5, size.height * 0.50)
      ..lineTo(size.width, size.height * 0.50)
      ..lineTo(size.width * 0.5, size.height * 0.45);

    canvas.drawPath(path, paint);

    Path pathTwo = Path()
      ..moveTo(size.width * 0.5, size.height * 0.5)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(size.width * 0.55, size.height * 0.5);

    canvas.drawPath(pathTwo, paint);

    Path pathThree = Path()
      ..moveTo(size.width * 0.5, 0.5 * size.height)
      ..lineTo(0.0, 0.5 * size.width)
      ..lineTo(size.width * 0.5, 0.45 * size.height);

    canvas.drawPath(pathThree, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
