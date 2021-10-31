
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChalkBoard extends StatelessWidget {
  final height;
  final width;
  final widget;

  const ChalkBoard({Key? key, this.height, this.width, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xffdf9031),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 0.85 * height,
          width: 0.85 * width,
          child: widget,
          decoration: BoxDecoration(
            color: Color(0xff285d34),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}