import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultiPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MultiPlayerState();
  }

}

class MultiPlayerState extends State<MultiPlayer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          child: Text('Profile'),
        ),
        SingleChildScrollView(

        ),
      ],
    );
  }
}