
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget  {
  final Widget? child;
  final List<Color>? colors;
  final bool notFailed;
  final AnimationController? animationController;
  final bool isAnswerEmpty;

  const CustomButton({Key? key, this.colors, required this.notFailed, required this.animationController, this.child, this.isAnswerEmpty = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        child: child,
        alignment: Alignment.center,
        height: isAnswerEmpty ? 0.0 : 40.0,
        width: MediaQuery.of(context).size.width* 0.85,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: notFailed ?  ColorTween(begin: Colors.white, end: Colors.teal).animate(CurvedAnimation(parent: animationController!, curve: Curves.linear)).value
          : Colors.red,
          backgroundBlendMode: BlendMode.srcATop,
          // gradient: LinearGradient(
          //   colors:  notFailed ? colors! : [Colors.red, Colors.red],),//[colorOne!, colorTwo!, colorThree!] : [Colors.red, Colors.redAccent],),
          borderRadius: BorderRadius.circular(8.0),
          // color: color

        )
    );
  }

  // @override
  // State<StatefulWidget> createState() {
  //   return CustomButtonState(child: child, notFailed: notFailed, animationController: animationController, startAnimation: startAnimating);
  }


// }
// class CustomButtonState extends State<CustomButton> with TickerProviderStateMixin{
//
//
//
//   CustomButtonState({Key? key,this.colors, this.child, required this.notFailed, required this.animationController, required this.startAnimation}) : super();
//   AnimationController animationController;
//   final Widget? child;
//   final List<Color>? colors;
//   final bool notFailed;
//   bool startAnimation;
//   var colorOne;
//   var colorTwo;
//   var colorThree;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//         child: child,
//         alignment: Alignment.center,
//         height: 40.0,
//         width: MediaQuery.of(context).size.width* 0.85,
//         duration: Duration(milliseconds: 300),
//         decoration: BoxDecoration(
//           backgroundBlendMode: BlendMode.srcATop,
//           gradient: LinearGradient(
//             colors:  notFailed ? colors! : [Colors.red, Colors.red],),//[colorOne!, colorTwo!, colorThree!] : [Colors.red, Colors.redAccent],),
//           borderRadius: BorderRadius.circular(8.0),
//           // color: color
//
//         )
//     );
//   }
//
//
//   @override
//   void initState() {
//      animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//      colorOne = ColorTween(begin: Colors.white, end: Colors.green).animate(CurvedAnimation(parent: animationController, curve: Curves.linear)).value;
//      colorTwo = ColorTween(begin: Colors.white, end: Colors.lightGreen).animate(CurvedAnimation(parent: animationController, curve: Curves.linear)).value;
//      colorThree = ColorTween(begin: Colors.white, end: Colors.green).animate(CurvedAnimation(parent: animationController, curve: Curves.linear)).value;
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(CustomButton oldWidget) {
//     animationController.forward();
//     animationController.reverse();
//     super.didUpdateWidget(oldWidget);
//   }
// }
