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
  final double xHeight;
  final bool shadow;

  const StackedButtons({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    this.topColor = Colors.teal,
    this.bottomColor = Colors.teal,
    this.borderRadius = 0,
    this.xHeight = 6.0,
    this.shadow = false,
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
      height: widget.height + widget.xHeight,
      child: Stack(
        children: [
          Positioned(
            top: widget.xHeight,
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  boxShadow: widget.shadow ? kElevationToShadow[1] : [],
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
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
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
