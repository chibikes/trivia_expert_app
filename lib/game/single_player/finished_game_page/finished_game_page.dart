import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_state.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/online_single_player.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/widgets/end_game_card.dart';
import 'package:trivia_expert_app/widgets/finished_game_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';
import '../../../file_storage.dart';
import '../../../widgets/stacked_button.dart';
import '../../../widgets/xp_icon.dart';
import 'dart:math' as math;

class FinishedGamePage extends StatefulWidget {
  final int score;
  final bool newLevel;
  final bool highScore;
  final double reward;
  final Map stats;
  const FinishedGamePage({
    Key? key,
    required this.score,
    required this.newLevel,
    required this.reward,
    required this.highScore,
    required this.stats,
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
  late AnimationController _offsetAnimController =
      AnimationController(vsync: this, duration: Duration(seconds: 1));
  late AnimationController _scaleCrystalController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  late Animation<double> animation;
  late Animation<double> heightFirstItem;
  late Animation<double> heightSecondItem;
  late AnimationController _buttonController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 50));

  @override
  void initState() {
    heightFirstItem = Tween<double>(begin: 500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _offsetAnimController,
            curve: Interval(0.0, 1.0, curve: Curves.easeInOut)));
    heightSecondItem = Tween<double>(begin: 500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _offsetAnimController,
            curve: Interval(0.50, 1.0, curve: Curves.easeInOut)));
    animation = Tween<double>(begin: 0, end: widget.reward).animate(
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
    await _offsetAnimController.forward().then((value) {
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
    var data = MediaQuery.of(context).size;
    var gameStats = GameStats.gameStats;
    List<Widget> listStats = [];
    listStats.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Game Stats',
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
    if (listStats.length > 5) listStats.removeRange(5, listStats.length);

    return BlocBuilder<GameEndCubit, GameEndState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      widget.highScore
                          ? 'NEW HIGH SCORE!'
                          : widget.newLevel
                              ? 'XP ACQUIRED!'
                              : 'SEE IF YOU CAN DO BETTER!',
                      style: GoogleFonts.droidSans(
                        fontSize: 25,
                        color: Colors.orange,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.03 * data.height,
                  ),
                  AnimatedBuilder(
                      animation: _offsetAnimController,
                      builder: (context, child) {
                        return SizedBox(
                          height: heightFirstItem.value,
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EndGameCard(
                        title: 'Score',
                        contents: SizedBox(
                          child: Stack(
                            children: [
                              Positioned(
                                top: 1.0,
                                left: 1.0,
                                child: Text(
                                  '${widget.score}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                '${widget.score}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        icon: Icon(
                          FontAwesomeIcons.trophy,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                      ),
                      EndGameCard(
                        title: 'XP',
                        contents: Stack(
                          children: [
                            Positioned(
                              top: 1.0,
                              left: 1.0,
                              child: Text(
                                '${GamingStats.recentStats[gameLevel]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              '${GamingStats.recentStats[gameLevel]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        icon: CustomPaint(
                            painter: XPPainter(
                              Colors.blue,
                              Colors.lightBlue,
                            ),
                            size: Size(23, 30)),
                      ),
                      EndGameCard(
                        title: 'Reward',
                        contents: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.07,
                            ),
                            BlueCrystal(
                              height: 0.025 * data.width,
                              width: 0.025 * data.width,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  top: 1.0,
                                  left: 1.0,
                                  child: Text(
                                    '$reward',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  '$reward',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        icon: Stack(
                          children: [
                            Transform.rotate(
                                angle: -math.pi / 8,
                                child: BlueCrystal(
                                  height: 30,
                                  width: 30,
                                )),
                            Positioned(
                                left: 3,
                                child: Transform.rotate(
                                    angle: math.pi / 15,
                                    child: RedLifeCrystal(
                                      height: 30,
                                      width: 30,
                                    ))),
                            RightAnswer(
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                    builder: (context, child) {
                      return SizedBox(
                        height: heightSecondItem.value,
                      );
                    },
                    animation: _offsetAnimController,
                  ),
                  SizedBox(
                    height: 0.020 * data.height,
                  ),
                  gameStats.isNotEmpty
                      ? Column(
                          children: listStats,
                        )
                      : Center(
                          child: Text(
                          'GET A SCORE TO SEE STATS',
                          style: GoogleFonts.droidSans(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                  AnimatedBuilder(
                    builder: (context, child) {
                      return SizedBox(
                        height: heightSecondItem.value,
                      );
                    },
                    animation: _offsetAnimController,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                  ),
                  Center(
                    child: StackedButtons(
                      height: 50,
                      width: 0.80 * data.width,
                      topColor: Color(0xffd45500),
                      bottomColor: Color(0xffd45500),
                      child: SizedBox(
                        width: 0.30 * data.width,
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                widget.newLevel ? 'Continue' : 'REPLAY',
                                style: GoogleFonts.blackHanSans(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPress: () {
                        GameStats.gameStats.clear();
                        context.read<QuestionBloc>().add(FetchQuestions());
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OnlineSinglePlayer();
                        }));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void deactivate() {
    var shopCubit = context.read<ShopCubit>();
    shopCubit.emit(shopCubit.state
        .copyWith(blueCrystals: shopCubit.state.blueCrystals + reward.toInt()));
    FileStorage.instance.then((value) => value.setInt(
        blueCrystals, (reward + shopCubit.state.blueCrystals).toInt()));
    widget.stats.clear();
    super.deactivate();
  }

  _pressButton() async {
    buttonClick();
    await _buttonController.forward();
    await _buttonController.reverse();
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OnlineSinglePlayer();
    }));
  }

  void buttonClick() {
    final audioPlayer = AudioCache();
    audioPlayer.play('button_click.mp3', mode: PlayerMode.LOW_LATENCY);
  }

  void playWinOrLose() {
    final audioPlayer = AudioCache();
    if (widget.highScore || widget.newLevel) {
      audioPlayer.play('well_done.wav',
          mode: PlayerMode.LOW_LATENCY, volume: 0.5);
    } else {
      audioPlayer.play(
        'fail_sound.mp3',
        mode: PlayerMode.LOW_LATENCY,
      );
    }
  }
}
