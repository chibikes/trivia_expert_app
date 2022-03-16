
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/widgets/custom_button_widgets/proper_elevated_button.dart';

class AnimatedCustomButton extends StatelessWidget  {
  final AnimationController buttonController;
  final Widget? child;
  final AnimationController? animationController;
  final AnimationController? multiButtonMotionController;
  final Interval interval;
  final Color color;
  final Function()? onTap;

  const AnimatedCustomButton({Key? key, required this.animationController, this.child, required this.multiButtonMotionController, required this.interval, required this.color, required this.onTap, required this.buttonController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
          begin: Offset.zero, end: Offset(3.5, 0.0))
          .animate(CurvedAnimation(
          parent: multiButtonMotionController!,
          curve: interval,)),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
            child: child,
            alignment: Alignment.center,
            height: 40.0,
            width: MediaQuery.of(context).size.width * 0.85,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: color,
              backgroundBlendMode: BlendMode.srcATop,
              borderRadius: BorderRadius.circular(8.0),
              // color: color

            )
        ),
      ),
    );
  }
  }


