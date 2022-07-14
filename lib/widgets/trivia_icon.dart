import 'package:flutter/material.dart';

class TriviaIcon extends StatelessWidget {
  final double width;
  final color = Colors.blue;

  const TriviaIcon({Key? key, this.width = 0, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = 0.15 * width;
    var space = 0.05 * width;
    var widths = 0.7 * width;
    return Column(
      children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        SizedBox(
          height: space,
        ),
        Container(
          height: height,
          width: widths,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        SizedBox(
          height: space,
        ),
        Container(
          height: height,
          width: widths,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        SizedBox(
          height: space,
        ),
        Container(
          height: height,
          width: widths,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        SizedBox(
          height: space,
        ),
        Container(
          height: height,
          width: widths,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ],
    );
  }

}