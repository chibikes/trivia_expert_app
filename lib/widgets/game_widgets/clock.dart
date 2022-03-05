import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class Clock extends StatelessWidget {
  final height;
  final width;
  final widget;

  const Clock({Key? key, this.height, this.width, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.09 * MediaQuery.of(context).size.height,
      width: 0.09 * MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 0.3,
          width: 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Text('00: 22'),
        ),
      ),
    );
  }
}
