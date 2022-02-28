import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:rive/rive.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/game/single_player/animations.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_cubit.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/main_bloc/cubit/main_page_bloc.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:trivia_expert_app/widgets/game_widgets/red_life_crystal.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key,}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  GameState gState = GameState.empty;
  late final AnimationController? _multiButtonMotionController = AnimationController( /// controls all motions  of all the  buttons
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final AnimationController? _cardController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late double chalkBoardWidth = 0.85 * MediaQuery.of(context).size.width;
  late double chalkBoardHeight = chalkBoardWidth / 1.6180;
  late QuestionBloc _questionBloc;

  Result? results;

  Artboard? _artboard;
  final landscapeFile = 'assets/landscape.riv';

  void _loadRiveFile() async {
    await rootBundle.load(landscapeFile).then((data) {
      final file = RiveFile.import(data);

      setState(() => _artboard = file.mainArtboard
        ..addController(
          SimpleAnimation('moving_clouds'),
        ));
    });
  }

  @override
  void initState() {
    // isButtonTapped = false;
    _loadRiveFile();
    AnimationHelper.initControllers(this);
    // context.read<GamePlayCubit>().initializeState(
    //       _cardController!,
    //       context,
    //       _questionBloc,
    //     );
    _multiButtonMotionController?.reset();
    context.read<OnlineSinglePlayerCubit>().startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: move questionbloc up the widget tree!..
    return BlocBuilder<QuestionBloc, QuestionState>(builder: (context, questionState) {
      switch (questionState.status) {
        case QuestionStatus.failure:
          return const Center(child: Text('failed to get questions'));
        case QuestionStatus.success:
          return BlocBuilder<OnlineSinglePlayerCubit, OnlineSinglePlayerState>(
            builder: (context, gameState) {
              var question = gameState.questions[gameState.index];
              if (gameState.time == 0) {
                //TODO: verify that it's close(); that you need
                context.read<OnlineSinglePlayerCubit>().close();
                return FinishedGamePage();
              } else
              return Stack(
                children: [
                  _artboard != null
                      ? Rive(
                          artboard: _artboard!,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(context
                                      .read<MainBloc>()
                                      .state
                                      .user!
                                      .photo!),
                                ),
                                Text(''), //TODO: put player score here.
                              ],
                            ),
                            Clock(
                              width: 50.0,
                              height: 40.0,
                              widget: Text(
                                '${gameState.time}',
                                style: GoogleFonts.aladin(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                            ),
                            Text('${gameState.playerScore}'),
                            SizedBox(
                              width: 10,
                            ),
                            RedLifeCrystal(height: 30, width: 30,),
                            CheckMark(height: 30, width: 30,),
                          ],
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
                            questionState.questions[gameState.index].question!,
                            style: GoogleFonts.aleo(
                                textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 50,
                      ),
                      AnimatedCustomButton(
                        onTap: () {context.read<OnlineSinglePlayerCubit>().answerValidate(0);},
                        color: gameState.colors[0],
                        interval: Interval(0.0, 1.0, curve: Curves.elasticIn),
                        multiButtonMotionController: _multiButtonMotionController,
                        isAnswerEmpty:
                            question.answers![0] == '',
                        animationController: AnimationHelper.controllerOne,
                        child: Text(question.answers![0],
                            style: MyTextStyle.style),
                      ),
                      SizedBox(
                          height: question.answers![1] == ''
                              ? 0
                              : 10),
                      AnimatedCustomButton(
                        onTap: () {context.read<OnlineSinglePlayerCubit>().answerValidate(1);},
                        color: gameState.colors[1],
                        interval: Interval(0.25, 1.0, curve: Curves.elasticIn),
                        multiButtonMotionController: _multiButtonMotionController,
                        isAnswerEmpty:
                            question.answers![1] ==
                                '',
                        animationController:
                            AnimationHelper.controllerTwo,
                        child: Text(
                          question.answers![1],
                          style: MyTextStyle.style,
                        ),
                      ),
                      SizedBox(
                          height: question.answers![2] == ''
                              ? 0
                              : 10),
                      AnimatedCustomButton(
                        onTap: () {context.read<OnlineSinglePlayerCubit>().answerValidate(2);},
                        color: gameState.colors[2],
                        interval: Interval(0.50, 1.0, curve: Curves.elasticIn),
                        multiButtonMotionController: _multiButtonMotionController,
                        isAnswerEmpty:
                            question.answers![2] == '',
                        animationController:
                            AnimationHelper.controllerThree,
                        child: Text(
                          question.answers![2],
                          style: MyTextStyle.style,
                        ),
                      ),
                      SizedBox(
                          height: question.answers![3] == ''
                              ? 0
                              : 10),
                      AnimatedCustomButton(
                        onTap: () {context.read<OnlineSinglePlayerCubit>().answerValidate(3);},
                        color: gameState.colors[3],
                        interval: Interval(0.75, 1.0, curve: Curves.elasticIn),
                        multiButtonMotionController: _multiButtonMotionController,
                        isAnswerEmpty:
                            question.answers![3] == '',
                        animationController:
                            AnimationHelper.controllerFour!,
                        child: Text(
                            question.answers![3],
                            style: MyTextStyle.style),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Card(
                          color: Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                    '1. Answer all questions in the science category\n '),
                                Text(
                                    '2. Beat the threshold time: that is score 30 > 40'),
                              ],
                            ),
                          ),
                          elevation: 8.0,
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
    //TODO: dispose every expensive resources here
    _multiButtonMotionController?.dispose();
    _cardController?.dispose();
    AnimationHelper.disposeControllers();
    super.dispose();
  }

}
