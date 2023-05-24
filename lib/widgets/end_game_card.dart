import 'package:flutter/material.dart';

class EndGameCard extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Widget contents;

  const EndGameCard(
      {Key? key, this.title = '', required this.contents, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context).size;
    var cardHeight = 0.27 * data.width;
    return SizedBox(
      width: 0.25 * data.width,
      height: 1.50 * cardHeight,
      child: Stack(
        children: [
          Positioned(
            top: 4,
            child: Container(
              width: 0.25 * data.width,
              height: 1.06 * cardHeight,
              decoration: BoxDecoration(
                color: Colors.cyan.shade700,
                // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Container(
            width: 0.25 * data.width,
            height: 1.06 * cardHeight,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(blurRadius: 0.5, color: Colors.black38),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.cyan.shade500],
                  stops: [0.7, 0.3]),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.white54, width: 0.3),
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
                  SizedBox(
                    height: 0.023 * data.height,
                  ),
                  contents
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
