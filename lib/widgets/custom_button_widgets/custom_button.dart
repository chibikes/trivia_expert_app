
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/widgets/custom_button_widgets/proper_elevated_button.dart';

class AnimatedCustomButton extends StatelessWidget  {
  final AnimationController buttonController;
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

  const AnimatedCustomButton({Key? key, this.colors, this.notFailed = true, required this.animationController, this.child, this.isAnswerEmpty = false, required this.multiButtonMotionController, required this.interval, required this.color, required this.onTap, required this.buttonController}) : super(key: key);

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
        child: ProperElevatedButton(
          textColor: Colors.black54,
          bottomShade: Color(0xfff8f0e3),
          topShade: Color(0xfffaf9f6),
          text: 'child should be here',
          buttonHeight: isAnswerEmpty ? 0.0 : 40.0,
          buttonWidth: MediaQuery.of(context).size.width* 0.50,
          position:
          Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.12))
              .animate(CurvedAnimation(
              parent: buttonController, curve: Curves.linear)),
        ),
        // AnimatedContainer(
        //     child: child,
        //     alignment: Alignment.center,
        //     height: isAnswerEmpty ? 0.0 : 40.0,
        //     width: MediaQuery.of(context).size.width* 0.85,
        //     duration: Duration(milliseconds: 300),
        //     decoration: BoxDecoration(
        //       color: color,
        //       // color: notFailed ?  ColorTween(begin: Colors.white, end: Colors.teal).animate(CurvedAnimation(parent: animationController!, curve: Curves.linear)).value
        //       // : Colors.red,
        //       backgroundBlendMode: BlendMode.srcATop,
        //       borderRadius: BorderRadius.circular(8.0),
        //       // color: color
        //
        //     )
        // ),
      ),
    );
  }
  }


