import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_state.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/widgets/custom_button_widgets/proper_elevated_button.dart';
import 'package:trivia_expert_app/widgets/finished_game_card.dart';
import 'package:trivia_expert_app/widgets/game_widgets/chalkboard.dart';
import 'package:trivia_expert_app/widgets/game_widgets/cyrstal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../file_storage.dart';
import '../../../widgets/xp_icon.dart';

class FinishedGamePage extends StatefulWidget {
  final int score;
  final bool newLevel;
  final bool highScore;
  final double reward;
  const FinishedGamePage({
    Key? key,
    required this.score,
    required this.newLevel,
    required this.reward,
    required this.highScore,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FinishedGamePageState();
  }
}

class FinishedGamePageState extends State<FinishedGamePage>
    with TickerProviderStateMixin {
  var reward = 0;
  late AnimationController _rewardController =
      AnimationController(vsync: this, duration: Duration(seconds: 1));
  late AnimationController _offsetAnimController = AnimationController(vsync: this, duration: Duration(seconds: 1));
  late AnimationController _scaleCrystalController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  late Animation<double> animation;
  late Animation<double> heightFirstItem;
  late Animation<double> heightSecondItem;
  late AnimationController _buttonController =
  AnimationController(vsync: this, duration: Duration(milliseconds: 50));

  @override
  void initState() {
    heightFirstItem = Tween<double>(begin: 500.0, end: 0.0).animate(CurvedAnimation(parent: _offsetAnimController, curve: Interval(0.0, 1.0, curve: Curves.easeInOut)));
    heightSecondItem = Tween<double>(begin: 500.0, end: 0.0).animate(CurvedAnimation(parent: _offsetAnimController, curve: Interval(0.50, 1.0, curve: Curves.easeInOut)));
    // Tween<Offset>(begin: Offset.zero, end: Offset(50, 100)).animate(parent);
    animation = Tween<double>(begin: 0, end: widget.reward + widget.score).animate(
        CurvedAnimation(parent: _rewardController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          reward = animation.value.toInt();
        });
      });
    _scaleCrystalController.addListener(() {
      if (reward == widget.reward || widget.reward == 0) {
        _scaleCrystalController.stop();
        playWinOrLose();
      }
    });
    _playAnim();

    super.initState();
  }
  _playAnim() async {
    await _offsetAnimController.forward().then((value)  {
      _rewardController.forward();
      _scaleCrystalController.forward();
      _scaleCrystalController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _rewardController.dispose();
    _scaleCrystalController.dispose();
    _buttonController.dispose();
    _offsetAnimController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var gameStats = GameStats.gameStats;
    List<Widget> listStats = [];
    listStats.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Category Stats',
          style: GoogleFonts.droidSans(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );

    gameStats.forEach((key, value) {
      if (value.categoryFrequency != 0) {
        listStats.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: GameStatsCard(
            category: key,
            score: '${value.score}/${value.categoryFrequency}',
            ratio: value.score / value.categoryFrequency,
          ),
        ));
      }
    });
    if(listStats.length > 5)
    listStats.removeRange(5, listStats.length);

    return BlocBuilder<GameEndCubit, GameEndState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Color(0xffF8F0E3),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  SizedBox(height: 10,),
                  AnimatedBuilder(
                    animation: _offsetAnimController,
                    builder: (context, child) {
                      return SizedBox(height: heightFirstItem.value,);
                    }
                  ),
                  ChalkBoard(
                    height: 0.33 * MediaQuery.of(context).size.height,
                    width: 0.80 * MediaQuery.of(context).size.width,
                    widget: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.highScore
                            ? 'NEW HIGH SCORE!'
                            : widget.newLevel
                                ? 'XP POINTS EARNED!'
                                : 'SEE IF YOU CAN DO BETTER!',
                        style: GoogleFonts.droidSans(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SCORE ${widget.score}',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomPaint(
                              painter: XPPainter(
                                Colors.orange,
                                Colors.orangeAccent,
                              ),
                              size: Size(28, 35)),
                          SizedBox(width: 10.0,),
                          Text(
                            'XP ${GamingStats.recentStats[gameLevel]}',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 0.37 * MediaQuery.of(context).size.width,
                          ),
                          ScaleTransition(
                              scale: Tween<double>(begin: 1.0, end: 0.75).animate(
                                  CurvedAnimation(
                                      parent: _scaleCrystalController,
                                      curve: Curves.bounceInOut)),
                              child: BlueCrystal(
                                height: 30,
                                width: 30,
                              ),),
                          SizedBox(width: 0.02 * MediaQuery.of(context).size.width,),
                          Text(
                            '$reward',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  AnimatedBuilder(
                    builder: (context, child) {
                      return SizedBox(height: heightSecondItem.value,);
                    }, animation: _offsetAnimController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ChalkBoard(
                    width: 0.80 * MediaQuery.of(context).size.width,
                    height: 0.40 * MediaQuery.of(context).size.height,
                    // elevation: 8.0,
                    widget: Column(
                      children: listStats,
                    ),
                  ),
                  AnimatedBuilder(
                    builder: (context, child) {
                      return SizedBox(height: heightSecondItem.value,);
                    }, animation: _offsetAnimController,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ProperElevatedButton(text: 'REPLAY', buttonWidth: 0.80 * MediaQuery.of(context).size.width, buttonHeight: 50.0, function: () => _pressButton(),position:
                  Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.12))
                      .animate(CurvedAnimation(
                      parent: _buttonController, curve: Curves.linear)),),
                ],
              ),
        ),
      );
    });
  }

  @override
  void deactivate() {
    var shopCubit = context.read<ShopCubit>();
    shopCubit.emit(shopCubit.state.copyWith(blueCrystals: shopCubit.state.blueCrystals + reward.toInt()));
    FileStorage.instance.then((value) => value.setInt(blueCrystals, (reward + shopCubit.state.blueCrystals).toInt()));
    GameStats.gameStats.clear();
    super.deactivate();
  }

  _pressButton() async {
    buttonClick();
    await _buttonController.forward();
    await _buttonController.reverse();
    Navigator.of(context).pop();
  }

  void buttonClick() {
    final audioPlayer = AudioCache();
    audioPlayer.play('button_click.mp3', mode: PlayerMode.LOW_LATENCY);
  }

  void playWinOrLose() {
    final audioPlayer = AudioCache();
    if(widget.highScore || widget.newLevel) {
      audioPlayer.play('well_done.mp3', mode: PlayerMode.LOW_LATENCY, volume: 0.2);
    } else {
      audioPlayer.play('try_again.mp3', mode: PlayerMode.LOW_LATENCY, volume: 0.2);
    }
  }
}
