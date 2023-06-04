import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/game/single_player/animations.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_cubit.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/crystal_page_card.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/power_up_container.dart';
import 'package:flutter/src/painting/gradient.dart' as gradient;
import 'package:trivia_expert_app/widgets/widgets.dart';

import '../../../../user_bloc/cubit/user_bloc.dart';
import '../../../../widgets/other_widgets/mainpage_container.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    Key? key,
  }) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late final AnimationController? _buttonTapController;
  late final AnimationController? _multiButtonMotionController =
      AnimationController(
    /// controls all motions  of all the  buttons
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final AnimationController? _cardController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late double chalkBoardWidth = 0.85 * MediaQuery.of(context).size.width;
  late double chalkBoardHeight = chalkBoardWidth / 1.6180;

  bool highScoreEvent = false;
  bool newLevelEvent = false;
  int score = 0;
  int xp = 0;
  Artboard? _artBoard;
  final landscapeFile = 'assets/landscape.riv';

  void _loadRiveFile() async {
    await rootBundle.load(landscapeFile).then((data) {
      final file = RiveFile.import(data);

      setState(() => _artBoard = file.mainArtboard
        ..addController(
          SimpleAnimation('moving_clouds'),
        ));
    });
  }

  @override
  void initState() {
    _loadRiveFile();
    AnimationHelper.initControllers(this);
    _multiButtonMotionController?.reset();
    _buttonTapController = AnimationController(vsync: this);
    context.read<OnlineSinglePlayerCubit>().startTimer();
    context.read<OnlineSinglePlayerCubit>().retrieveGameState();
    super.initState();
  }

  @override
  void deactivate() {
    GameStats.gameStats.clear();
    context.read<UserBloc>().add(UpdatePlayerStat(
        xp: xp, highScore: GamingStats.recentStats[highScore]?.toInt()));
    context
        .read<OnlineSinglePlayerCubit>()
        .saveGameState(context.read<OnlineSinglePlayerCubit>().state.index);
    deductExtraLife();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context).size;
    var currentHighScore = context.read<UserBloc>().state.gameDetails.highScore;
    return BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, questionState) {
      switch (questionState.status) {
        case QuestionStatus.inProgress:
          return Stack(
            children: [
              SizedBox(
                  height: data.height,
                  width: data.width,
                  child: MainPageContainer()),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        case QuestionStatus.failure:
          return const Center(child: Text('Failed to get questions'));
        case QuestionStatus.success:
          context
              .read<OnlineSinglePlayerCubit>()
              .emitQuestions(questionState.questions);
          return BlocBuilder<OnlineSinglePlayerCubit, OnlineSinglePlayerState>(
            builder: (context, gameState) {
              score = gameState.playerScore;
              xp = gameState.level;
              newLevelEvent = gameState.newLevelEvent;
              highScoreEvent = gameState.highScoreEvent;
              var question = gameState.questions[gameState.index];
              if (gameState.life <= 0 ||
                  gameState.time <= 0 ||
                  gameState.newLevelEvent) {
                var state = context.read<UserBloc>().state;
                var totalScore = state.gameDetails.highScore;
                GamingStats.recentStats[highScore] =
                    totalScore + gameState.playerScore;

                GamingStats.recentStats[gameLevel] = gameState.level;
                context.read<OnlineSinglePlayerCubit>().close();
                var stats = GameStats.gameStats;
                return FinishedGame(
                  stats: stats,
                  highScore: gameState.highScoreEvent,
                  score: totalScore + gameState.playerScore,
                  newLevel: gameState.newLevelEvent,
                  reward: gameState.reward,
                );
              } else if (gameState.gameStatus == GameStatus.getQuestions) {
                context.read<QuestionBloc>().add(FetchingQuestions());
              }
              return Stack(
                children: [
                  _artBoard != null
                      ? Rive(
                          artboard: _artBoard!,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                  Column(
                    children: [
                      SizedBox(
                        height: 0.05 * data.height,
                      ),
                      Text(
                        'Category: ' +
                            questionState.questions[gameState.index].category!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        ' ${gameState.playerScore} / 10',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      // Animated
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: BlocBuilder<ShopCubit, ShopState>(
                            builder: (context, shopState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(context
                                        .read<UserBloc>()
                                        .state
                                        .user!
                                        .photoUrl!),
                                  ),
                                  Text(''), //TODO: put player score here.
                                ],
                              ),
                              Clock(
                                width: 0.16 * data.width,
                                height: 0.16 * data.width,
                                text: gameState.time < 10
                                    ? '00:0${gameState.time}'
                                    : '00:${gameState.time}',
                              ),
                              SizedBox(
                                width: data.width * 0.05,
                              ),
                              Text(
                                '${gameState.playerScore}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              SizedBox(
                                width: data.width * 0.05,
                              ),
                              PowerUpContainer(
                                fontSize: 12,
                                height: 20,
                                width: 40,
                                powerUpQty: gameState.life.toString(),
                                powerUpIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const RedLifeCrystal(
                                      height: 8,
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ),
                              PowerUpContainer(
                                fontSize: 12,
                                height: 20,
                                width: 40,
                                powerUpQty: shopState.rightAnswers.toString(),
                                powerUpIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const RightAnswer(
                                      height: 10,
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      SizedBox(
                        height: 0.025 * data.height,
                      ),
                      ChalkBoard(
                        height: chalkBoardHeight,
                        width: chalkBoardWidth,
                        widget: Padding(
                          padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                          child: Text(
                            questionState.questions[gameState.index].question!,
                            style: GoogleFonts.aleo(
                              textStyle: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: data.height * 0.15,
                      ),
                      Column(
                        children: List.generate(
                          gameState.questions[gameState.index].answers!.length,
                          (index) => Column(
                            children: [
                              AnimatedCustomButton(
                                buttonController: _buttonTapController!,
                                onTap: () {
                                  if (gameState.gameStatus ==
                                      GameStatus.inProgress) {
                                    context
                                        .read<OnlineSinglePlayerCubit>()
                                        .validateAnswer(index);
                                  }
                                },
                                color: gameState.colors[index],
                                interval: Interval(0.25, 1.0,
                                    curve: Curves.elasticIn),
                                multiButtonMotionController:
                                    _multiButtonMotionController,
                                animationController:
                                    AnimationHelper.controllerTwo,
                                text: question.answers![index],
                              ),
                              SizedBox(height: 0.010 * data.height),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.020 * data.height,
                      ),
                      GestureDetector(
                        onTap: () {
                          var gameCubit =
                              context.read<OnlineSinglePlayerCubit>();
                          if (gameCubit.state.rightAnswersUsed == 3) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                content: Text('3 right answers already used'),
                                behavior: SnackBarBehavior.floating,
                              ));
                          } else {
                            var shopBloc = context.read<ShopCubit>();
                            if (shopBloc.state.rightAnswers >= 1 &&
                                gameState.gameStatus == GameStatus.inProgress) {
                              gameCubit.emit(gameState.copyWith(
                                  gameStatus: GameStatus.checkingAnswer));
                              gameCubit.useRightAnswer();
                              shopBloc.useItem(ItemType.rightAnswer);
                            }
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: RightAnswer(
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        default:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    _multiButtonMotionController?.dispose();
    _cardController?.dispose();
    _buttonTapController?.dispose();
    AnimationHelper.disposeControllers();
    super.dispose();
  }

  void deductExtraLife() {
    var gameCubit = context.read<OnlineSinglePlayerCubit>();
    var shopCubit = context.read<ShopCubit>();
    var remainingRedCrystals = gameCubit.state.life - gameLife;
    shopCubit.useItem(ItemType.redCrystal,
        numberUsed: remainingRedCrystals >= 0 ? remainingRedCrystals : 0);
  }
}
