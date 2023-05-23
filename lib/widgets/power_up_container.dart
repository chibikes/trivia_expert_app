import 'package:flutter/material.dart';

class PowerUpContainer extends StatelessWidget {
  final double height;
  final double width;
  final String powerUpQty;
  final Widget powerUpIcon;
  final double fontSize;
  final radius = 5.0;

  const PowerUpContainer(
      {Key? key,
      this.height = 0,
      this.width = 0,
      this.fontSize = 14,
      this.powerUpQty = '',
      required this.powerUpIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: height,
          width: 0.30 * width,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius)),
            border: const Border(),
          ),
          child: powerUpIcon,
          // Center(
          //     child: Text(
          //   powerUpQty,
          //   style: TextStyle(
          //       fontSize: fontSize,
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold),
          // ),
          // ),
        ),
        Container(
          height: height,
          width: 0.70 * width,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(radius),
                bottomRight: Radius.circular(radius)),
            border: const Border(),
          ),
          child: //
              Center(
            child: Text(
              powerUpQty,
              style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
