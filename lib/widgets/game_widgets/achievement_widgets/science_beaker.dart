import 'package:flutter/material.dart';

class ScienceBeaker extends StatelessWidget {
  const ScienceBeaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BeakerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
        ..color = Colors.blueGrey
        ..style = PaintingStyle.stroke;

    final Path path = Path()
    ..moveTo(size.width * 0.375, size.height * 0.15)
    ..lineTo(size.width * 0.375, size.height * 0.50)
    ..lineTo(size.width * 0.25, size.height * 0.85);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

}
