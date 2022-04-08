import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PowerUpContainer extends StatelessWidget {
  final double height;
  final double width;
  final String powerUpQty;
  final Widget powerUpIcon;
  final radius = 5.0;

  const PowerUpContainer({Key? key, this.height = 0, this.width = 0, this.powerUpQty = '', required this.powerUpIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Container(
          height: height,
          width: 0.80 * width,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius)),
            border: Border(),
          ),
          child: Center(child: Text(powerUpQty,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        ),
        Container(
          height: height,
          width: 0.20 * width,
          decoration: BoxDecoration(
            color: Color(0xff23395d),
            borderRadius: BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius)),
            border: Border(),
          ),
          child: powerUpIcon,
        ),
      ],
    );
  }

}