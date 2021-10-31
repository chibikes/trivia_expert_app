import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircularPads extends StatelessWidget {

  final text;
  final position;
  final function;
  final tapDownFunction;
  final tapUpFunction;
  final radius;

  const CircularPads({Key? key,  this.text, this.position, this.function, this.tapDownFunction, this.tapUpFunction, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: SizedBox(
            height: radius,
            width:  radius,
            child: RawMaterialButton(
              fillColor: Colors.cyan,
              onPressed: () {},
              child: Text(''),
              shape:
              RoundedRectangleBorder(
                side: BorderSide(color: Color(0xff000000), width: 1.0),
                borderRadius: BorderRadius.circular(30.0),
              ),

            ),
          ),
        ),
        SizedBox(
          height: radius,
          width: radius,
          child: GestureDetector(
            onLongPressEnd: tapUpFunction,
            onLongPress: tapDownFunction,
            child: RawMaterialButton(
              fillColor: Colors.cyan,
              onPressed: function,
              child: Text(text, style: GoogleFonts.blackHanSans(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700,)),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xff000000), width: 1.0),
                borderRadius: BorderRadius.circular(24.0),
              ),
              // shape: Border(), // TODO:

            ),
          ),
        ),
      ],
    );
  }
}