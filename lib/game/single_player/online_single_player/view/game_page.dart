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
import 'package:trivia_expert_app/main_bloc/cubit/main_page_bloc.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:trivia_expert_app/widgets/widgets.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, this.otherPlayer}) : super(key: key);
  final int? otherPlayer;
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
    context.read<GamePlayCubit>().initializeState(
          _cardController!,
          context,
          _questionBloc,
        );
    _multiButtonMotionController?.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(builder: (context, state) {
      switch (state.status) {
        case QuestionStatus.failure:
          return const Center(child: Text('failed to connect to the internet'));
        case QuestionStatus.success:
          return BlocBuilder<GamePlayCubit, GamePlayState>(
            builder: (context, gamePlayState) {
              gState = gamePlayState.gameState!;
              if (gamePlayState.gameStatus == GameStatus.game_end) {
                return FinishedGamePage();
              }
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
                          state.questions[gamePlayState.index!].category!),
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
                                '${gamePlayState.secondsRemaining}',
                                style: GoogleFonts.aladin(
                                    fontWeight: FontWeight.w400, fontSize: 15),
                              ),
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(context
                                  .read<MainBloc>()
                                  .state
                                  .gameStates[widget.otherPlayer!]
                                  .player2!
                                  .photo!),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.solidHeart,
                              size: 30.0,
                              color: Colors.red,
                            )
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
                            state.questions[gamePlayState.index!].question!,
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
                      SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset.zero, end: Offset(3.5, 0.0))
                            .animate(CurvedAnimation(
                                parent: _multiButtonMotionController!,
                                curve: Interval(0.0, 1.0,
                                    curve: Curves.elasticIn))),
                        child: GestureDetector(
                          onTap: () {
                            context.read<GamePlayCubit>().validateAnswer(
                                  _multiButtonMotionController!,
                                  state.answers[gamePlayState.index!][0],
                                  0,
                                  _questionBloc,
                                  context,
                                );
                          },
                          child: CustomButton(
                            isAnswerEmpty:
                                state.answers[gamePlayState.index!][0] == '',
                            animationController: AnimationHelper.controllerOne,
                            notFailed: gamePlayState.listBol[0],
                            child: Text(state.answers[gamePlayState.index!][0],
                                style: MyTextStyle.style),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: state.answers[gamePlayState.index!][0] == ''
                              ? 0
                              : 10),
                      SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset.zero, end: Offset(3.5, 0.0))
                              .animate(CurvedAnimation(
                                  parent: _multiButtonMotionController!,
                                  curve: Interval(0.25, 1.0,
                                      curve: Curves.elasticIn))),
                          child: GestureDetector(
                              onTap: () {
                                context.read<GamePlayCubit>().validateAnswer(
                                      _multiButtonMotionController!,
                                      state.answers[gamePlayState.index!][1],
                                      1,
                                      _questionBloc,
                                      context,
                                    );
                                // validateAnswer(state.answers[index][1], 1);
                              },
                              child: CustomButton(
                                isAnswerEmpty:
                                    state.answers[gamePlayState.index!][1] ==
                                        '',
                                animationController:
                                    AnimationHelper.controllerTwo,
                                notFailed: gamePlayState.listBol[1],
                                child: Text(
                                  state.answers[gamePlayState.index!][1],
                                  style: MyTextStyle.style,
                                ),
                              ))),
                      SizedBox(
                          height: state.answers[gamePlayState.index!][1] == ''
                              ? 0
                              : 10),
                      SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset.zero, end: Offset(3.5, 0.0))
                              .animate(CurvedAnimation(
                                  parent: _multiButtonMotionController!,
                                  curve: Interval(0.50, 1.0,
                                      curve: Curves.elasticIn))),
                          child: GestureDetector(
                            onTap: () => {
                              context.read<GamePlayCubit>().validateAnswer(
                                  _multiButtonMotionController!,
                                  state.answers[gamePlayState.index!][2],
                                  2,
                                  _questionBloc,
                                  context,
                              )
                            },
                            child: CustomButton(
                              isAnswerEmpty:
                                  state.answers[gamePlayState.index!][2] == '',
                              animationController:
                                  AnimationHelper.controllerThree,
                              notFailed: gamePlayState.listBol[2],
                              child: Text(
                                state.answers[gamePlayState.index!][2],
                                style: MyTextStyle.style,
                              ),
                            ),
                          ),),
                      SizedBox(
                          height: state.answers[gamePlayState.index!][2] == ''
                              ? 0
                              : 10),
                      SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset.zero, end: Offset(3.5, 0.0))
                              .animate(CurvedAnimation(
                                  parent: _multiButtonMotionController!,
                                  curve: Interval(0.75, 1.0,
                                      curve: Curves.elasticIn))),
                          child: GestureDetector(
                            onTap: () {
                              context.read<GamePlayCubit>().validateAnswer(
                                  _multiButtonMotionController!,
                                  state.answers[gamePlayState.index!][3],
                                  3,
                                  _questionBloc,
                                  context,
                                  );
                            },
                            child: CustomButton(
                              isAnswerEmpty:
                                  state.answers[gamePlayState.index!][3] == '',
                              animationController:
                                  AnimationHelper.controllerFour!,
                              child: Text(
                                  state.answers[gamePlayState.index!][3],
                                  style: MyTextStyle.style),
                              notFailed: gamePlayState.listBol[3],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: _cardController!,
                                curve: Curves.linear)),
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
                      )
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
    AnimationHelper.disposeControllers();
    super.dispose();
  }

}
