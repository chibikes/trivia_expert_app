import 'package:flutter/material.dart';

import '../consts.dart';
import '../file_storage.dart';

class EndGameCard extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Widget contents;

  const EndGameCard({Key? key, this.title = '', required this.contents, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context).size;
    var cardHeight = 0.27 * data.width;
    return Stack(
      children: [
        Positioned(
          top: 0.20 * data.height,
          child: Container(
            width: 0.25 * data.width,
            height: cardHeight,
            decoration: BoxDecoration(
              color: Colors.cyan,
              // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        Container(
          width: 0.25 * data.width,
          height: cardHeight,
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin:Alignment.topCenter, end:Alignment.bottomCenter, colors: [Colors.white, Colors.cyan], stops: [0.7, 0.3]),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                icon ?? Text(''),
                SizedBox(height: 0.023 * data.height,),
                contents
              ],
            ),
          ),
        ),
      ],
    );
  }

}