import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../stacked_button.dart';

class AnswerButton extends StatelessWidget {
  final AnimationController buttonController;
  final Widget? child;
  final AnimationController? animationController;
  final AnimationController? multiButtonMotionController;
  final Interval interval;
  final Color color;
  final Color secondary;
  final Function()? onTap;
  final String text;

  const AnswerButton(
      {Key? key,
      required this.animationController,
      this.child,
      required this.multiButtonMotionController,
      required this.interval,
      required this.color,
      required this.secondary,
      required this.onTap,
      required this.buttonController,
      this.text = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context).size;
    return StackedButtons(
      shadow: true,
      topColor: color,
      bottomColor: secondary,
      child: Text(text),
      onPress: onTap ?? () {},
      width: MediaQuery.of(context).size.width * 0.80,
      height: text.length >= 34 ? 0.07555 * data.height : 0.0555 * data.height,
    );
  }
}
