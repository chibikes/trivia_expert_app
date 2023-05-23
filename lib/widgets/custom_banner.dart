import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  final double height;
  final double width;
  final String? content;

  const CustomBanner(
      {Key? key, required this.height, required this.width, this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BannerPainter(content ?? ''),
      size: Size(0.85 * width, height),
    );
  }
}

class BannerPainter extends CustomPainter {
  final String text;

  BannerPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xff1e66ae)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0.15 * size.width, 0.10 * size.height)
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromPoints(Offset(0.15 * size.width, 0.10 * size.height),
              Offset(0.90 * size.width, 0.50 * size.height)),
          Radius.circular(8.0),
        ),
      );

    canvas.drawPath(path, paint);

    paint..color = Color(0xff1e4b7a);
    Path path2 = Path()
      ..moveTo(0.18 * size.width, 0.50 * size.height)
      ..lineTo(0.26 * size.width, 0.58 * size.height)
      ..lineTo(0.26 * size.width, 0.50 * size.height);

    canvas.drawPath(path2, paint);

    path2
      ..moveTo(0.87 * size.width, 0.50 * size.height)
      ..lineTo(0.79 * size.width, 0.58 * size.height)
      ..lineTo(0.79 * size.width, 0.50 * size.height);

    canvas.drawPath(path2, paint);

    paint..color = Color(0xff1e66ae);
    Path path3 = Path()
      ..moveTo(0.20 * size.width, 0.519 * size.height)
      ..lineTo(0.20 * size.width, 0.60 * size.height)
      ..lineTo(0.26 * size.width, 0.58 * size.height);

    canvas.drawPath(path3, paint);

    path3
      ..moveTo(0.85 * size.width, 0.519 * size.height)
      ..lineTo(0.85 * size.width, 0.60 * size.height)
      ..lineTo(0.79 * size.width, 0.58 * size.height);

    canvas.drawPath(path3, paint);

    paint..color = Color(0xff1e4b7a);
    Path path4 = Path()
      ..moveTo(0.20 * size.width, 0.60 * size.height)
      ..lineTo(0.23 * size.width, 0.63 * size.height)
      ..lineTo(0.23 * size.width, 0.59 * size.height);

    canvas.drawPath(path4, paint);

    path4
      ..moveTo(0.85 * size.width, 0.60 * size.height)
      ..lineTo(0.82 * size.width, 0.63 * size.height)
      ..lineTo(0.82 * size.width, 0.59 * size.height);

    canvas.drawPath(path4, paint);

    var subText = text.split(' ').first;

    if (subText.length > 10) {
      subText = subText.replaceRange(10, subText.length, '');
    }
    final textStyle = TextStyle(
        color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold);
    final textSpan = TextSpan(
      text: subText,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    final offset = Offset(0.19 * size.width, 0.15 * size.height);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
