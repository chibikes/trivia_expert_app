import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class Clock extends StatelessWidget {
  final double height;
  final double width;
  final String text;

  const Clock({Key? key, this.height = 5, this.width = 5, this.text = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            shape: BoxShape.circle,
          ),
          child: Container(
            height: 0.70 * height,
            width: 0.70 * width,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(text, style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),),),
          ),
        ),
      ),
    );
  }
}
