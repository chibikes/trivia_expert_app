import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/game_page.dart';

class AnimationHelper extends State<StatefulWidget> with TickerProviderStateMixin{
  late final BuildContext context;
  static AnimationController? controllerOne;
  static AnimationController? controllerTwo;
  static AnimationController? controllerThree;
  static AnimationController? controllerFour;

  static bool startAnimationOne = false;
  static bool startAnimationTwo = false;
  static bool startAnimationThree = false;
  static bool startAnimationFour = false;

  @override
  Ticker createTicker(TickerCallback onTick) {
    // TODO: implement createTicker
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError;
  }
  static void initControllers(TickerProvider provider) {
    AnimationHelper.controllerFour =
        AnimationController(vsync: provider, duration: Duration(milliseconds: 100));
    AnimationHelper.controllerThree =
        AnimationController(vsync: provider, duration: Duration(milliseconds: 100));
    AnimationHelper.controllerTwo =
        AnimationController(vsync: provider, duration: Duration(milliseconds: 100));
    AnimationHelper.controllerOne =
        AnimationController(vsync: provider, duration: Duration(milliseconds: 100));
  }
  static void disposeControllers() {
    AnimationHelper.controllerOne?.dispose();
    AnimationHelper.controllerTwo?.dispose();
    AnimationHelper.controllerThree?.dispose();
    AnimationHelper.controllerFour?.dispose();
  }
}