import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class StackedButtons extends StatefulWidget {
  final double height;
  final double width;
  final Widget child;
  final Color topColor;
  final Color bottomColor;
  final Function onPress;
  final double borderRadius;

  const StackedButtons({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    this.topColor = Colors.teal,
    this.bottomColor = Colors.teal,
    this.borderRadius = 0,
    required this.onPress,
  }) : super(key: key);

  @override
  State<StackedButtons> createState() => _StackedButtonsState();
}

class _StackedButtonsState extends State<StackedButtons>
    with TickerProviderStateMixin {
  late AnimationController _buttonController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 50));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height + 6.0,
      child: Stack(
        children: [
          Positioned(
            top: 6.0,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.bottomColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          SlideTransition(
            position: Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.12))
                .animate(
              CurvedAnimation(parent: _buttonController, curve: Curves.linear),
            ),
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: GestureDetector(
                onTap: () async {
                  buttonClick();
                  await _buttonController.forward();
                  await _buttonController.reverse();
                  widget.onPress();
                },
                onLongPress: () async {
                  buttonClick();
                  await _buttonController.forward();
                },
                onLongPressEnd: (details) async {
                  await _buttonController.reverse();
                  widget.onPress();
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: widget.topColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    border: Border.all(
                      width: 0.5,
                      color: Color(0xb1ffffff),
                    ),
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  void buttonClick() {
    final audioPlayer = AudioCache();
    audioPlayer.play('button_click.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}
