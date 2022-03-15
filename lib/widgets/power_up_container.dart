import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PowerUpContainer extends StatelessWidget {
  final double height;
  final double width;
  final String powerUpQty;
  final Widget powerUpIcon;

  const PowerUpContainer({Key? key, this.height = 0, this.width = 0, this.powerUpQty = '', required this.powerUpIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Container(
          height: height,
          width: 0.20 * width,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
            border: Border(),
          ),
          child: Center(child: Text(powerUpQty)),
        ),
        Container(
          height: height,
          width: 0.80 * width,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
            border: Border(),
          ),
          child: powerUpIcon,
        ),
      ],
    );
  }

}