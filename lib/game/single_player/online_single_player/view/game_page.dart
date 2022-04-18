import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/game/single_player/animations.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_page.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_cubit.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:trivia_expert_app/shop_cubit/shop_cubit.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/crystal_page_card.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/power_up_container.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';

import '../../../../user_bloc/cubit/user_bloc.dart';

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

  Result? results;

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
    context
        .read<OnlineSinglePlayerCubit>()
        .saveGameState(context.read<OnlineSinglePlayerCubit>().state.index);
    deductExtraLife();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: delete this bloc builder and use the one in the main gamepage
    return BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, questionState) {
      switch (questionState.status) {
        case QuestionStatus.inProgress:
          return Center(
            child: SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator(),
            ),
          );
        //TODO: add circular indicator for inProgress status
        case QuestionStatus.failure:
          return const Center(child: Text('failed to get questions'));
        case QuestionStatus.success:
          //TODO: should usually emit from savedIndex
          context.read<OnlineSinglePlayerCubit>().emitQuestions(questionState.questions);
          return BlocBuilder<OnlineSinglePlayerCubit, OnlineSinglePlayerState>(
            builder: (context, gameState) {
              var question = gameState.questions[gameState.index];
              if (gameState.life <= 0 || gameState.time <= 0) {
                if(gameState.highScoreEvent){
                  GamingStats.recentStats[highScore] = gameState.playerScore;
                }
                GamingStats.recentStats[gameLevel] = gameState.level;
                context.read<OnlineSinglePlayerCubit>().close();
                return FinishedGame(highScore: gameState.highScoreEvent,score: gameState.playerScore, newLevel: gameState.newLevelEvent, reward: gameState.reward,);
              }
              else if (gameState.gameStatus == GameStatus.getQuestions) {
                /// offset should be multiples of database limit parameter.
                /// the question should be inclusive of the last question
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
                        Text('category: ' +
                            questionState.questions[gameState.index].category!),
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
                                    width: 0.16 * MediaQuery.of(context).size.width,
                                    height:
                                        0.16 * MediaQuery.of(context).size.width,
                                    text: gameState.time < 10 ? '00:0${gameState.time}':'00:${gameState.time}',
                                  ),
                                  Text(
                                    '${gameState.playerScore}  LV${gameState.level}',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      RedLifeCrystal(height: 5, width: 5,),
                                      Text(gameState.life.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RightAnswer(height: 10, width: 10,),
                                      Text(shopState.rightAnswers.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      BlueCrystal(height: 10, width: 10,),
                                      Text(shopState.blueCrystals.toString()),
                                    ],
                                  ),
                                ],
                              );
                            }
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ChalkBoard(
                          height: chalkBoardHeight,
                          width: chalkBoardWidth,
                          widget: Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                            child: Text(
                              questionState
                                  .questions[gameState.index].question!,
                              style: GoogleFonts.aleo(
                                  textStyle: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: List.generate(gameState.questions[gameState.index].answers!.length, (index) => Column(
                            children: [
                              AnimatedCustomButton(
                                buttonController: _buttonTapController!,
                                onTap: () {
                                  if(gameState.gameStatus == GameStatus.inProgress){
                                    context
                                        .read<OnlineSinglePlayerCubit>()
                                        .validateAnswer(index);
                                  }
                                },
                                color: gameState.colors[index],
                                interval:
                                Interval(0.25, 1.0, curve: Curves.elasticIn),
                                multiButtonMotionController:
                                _multiButtonMotionController,
                                animationController: AnimationHelper.controllerTwo,
                                text: question.answers![index],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            var shopBloc = context.read<ShopCubit>();
                            if(shopBloc.state.rightAnswers >= 1){
                            context.read<OnlineSinglePlayerCubit>().useRightAnswer();
                            shopBloc.useItem(ItemType.rightAnswer);
                          }
                        },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                            ),
                            child: RightAnswer(
                              height: 15,
                              width: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(top: 20.0,left: 0.40 * MediaQuery.of(context).size.width, child: Text(gameState.gameStatus == GameStatus.levelChanged ? 'LEVEL ${gameState.level}' : gameState.gameStatus == GameStatus.highScore ? 'HIGH SCORE!' : '', style: TextStyle(fontSize: 30, fontFamily: 'ShowCardGothic', color: Colors.green),)),
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
    //TODO: dispose every expensive resources here
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
    shopCubit.useItem(ItemType.redCrystal, numberUsed: remainingRedCrystals >= 0 ? remainingRedCrystals : 0);
  }
}
