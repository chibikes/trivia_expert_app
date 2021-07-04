import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Clock extends StatelessWidget {
  final height;
  final width;
  final widget;

  const Clock({Key? key, this.height, this.width, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.center,
          child: widget,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}