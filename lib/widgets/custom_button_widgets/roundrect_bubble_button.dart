import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundRectBubbleButton extends StatefulWidget {
  final onPressed;
  final String text;

  const RoundRectBubbleButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  State<RoundRectBubbleButton> createState() => _RoundRectBubbleButtonState();
}

class _RoundRectBubbleButtonState extends State<RoundRectBubbleButton>
    with TickerProviderStateMixin {
  late AnimationController? buttonController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.70).animate(CurvedAnimation(
          parent: buttonController!, curve: Curves.bounceInOut)),
      child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 8.0)),
            elevation: MaterialStateProperty.all(8.0),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.orange, width: 2.0))),
            alignment: Alignment.topCenter,
            backgroundColor: MaterialStateProperty.all(Colors.orange),
          ),
          onPressed: () async {
            buttonClick();
            if (buttonController != null)
              await buttonController
                  ?.forward()
                  .whenComplete(() => buttonController?.reverse());
            widget.onPressed();
          },
          child: Stack(
            // clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.none, width: 0.0),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color(0x25ffffff),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 5.0),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(style: BorderStyle.none, width: 0.0),
                    color: Color(0x50ffffff),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7.0, left: 15.0),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(style: BorderStyle.none, width: 0.0),
                    color: Color(0x50ffffff),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 11.0),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(style: BorderStyle.none, width: 0.0),
                    color: Color(0x30ffffff),
                  ),
                ),
              ),
              Center(
                  child: Text(
                widget.text,
                style: GoogleFonts.blackHanSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ))
            ],
          )),
    );
  }

  void buttonClick() {
    final audioPlayer = AudioCache();
    audioPlayer.play('button_click.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}
