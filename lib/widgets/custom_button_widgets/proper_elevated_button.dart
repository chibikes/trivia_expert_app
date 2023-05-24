import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StackedButton extends StatelessWidget {
  final buttonWidth;
  final buttonHeight;
  final text;
  final position;
  final function;
  final tapDownFunction;
  final tapUpFunction;
  final Color bottomShade;
  final Color topShade;
  final Color textColor;

  const StackedButton({
    Key? key,
    this.buttonWidth,
    this.buttonHeight,
    this.text,
    this.position,
    this.function,
    this.tapDownFunction,
    this.tapUpFunction,
    this.bottomShade = const Color(0xffd45500),
    this.textColor = Colors.white,
    this.topShade = const Color(0xffd45500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: SizedBox(
            height: buttonHeight,
            width: buttonWidth * MediaQuery.of(context).size.width,
            child: RawMaterialButton(
              fillColor: bottomShade,
              // Color(0xffd45500),
              onPressed: () {},
              child: Text(''),
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        SlideTransition(
          position: position,
          child: SizedBox(
            height: buttonHeight,
            width: buttonWidth * MediaQuery.of(context).size.width,
            child: GestureDetector(
              onLongPressEnd: tapUpFunction,
              onLongPress: tapDownFunction,
              child: RawMaterialButton(
                fillColor: topShade,
                onPressed: function,
                child: Text(text,
                    style: GoogleFonts.blackHanSans(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xb1ffffff), width: 0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                // shape: Border(), // TODO:
              ),
            ),
          ),
        ),
      ],
    );
  }
}
