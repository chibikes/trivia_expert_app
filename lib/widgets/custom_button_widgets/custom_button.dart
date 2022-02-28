
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedCustomButton extends StatelessWidget  {
  final Widget? child;
  final List<Color>? colors;
  final bool notFailed;
  final AnimationController? animationController;
  final bool isAnswerEmpty;
  final AnimationController? multiButtonMotionController;
  final Interval interval;
  final Color color;
  final Function()? onTap;
  /// intervals {0.0, 1.0,} {0.25, 1.0}, {0.5, 1.0} {0.75, 1.0} context.read<GamePlayCubit>().validateAnswer(
  ///           _multiButtonMotionController!,
  ///          state.answers[gameState.index!][1],
  ///          1,
  ///           _questionBloc,
  ///           context,
  ///         ),

  const AnimatedCustomButton({Key? key, this.colors, this.notFailed = true, required this.animationController, this.child, this.isAnswerEmpty = false, required this.multiButtonMotionController, required this.interval, required this.color, required this.onTap}) : super(key: key);

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
            height: isAnswerEmpty ? 0.0 : 40.0,
            width: MediaQuery.of(context).size.width* 0.85,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: color,
              // color: notFailed ?  ColorTween(begin: Colors.white, end: Colors.teal).animate(CurvedAnimation(parent: animationController!, curve: Curves.linear)).value
              // : Colors.red,
              backgroundBlendMode: BlendMode.srcATop,
              borderRadius: BorderRadius.circular(8.0),
              // color: color

            )
        ),
      ),
    );
  }

  // @override
  // State<StatefulWidget> createState() {
  //   return CustomButtonState(child: child, notFailed: notFailed, animationController: animationController, startAnimation: startAnimating);
  }


