// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:repo_packages/repo_packakges.dart';
// import 'package:rive/rive.dart';
// import 'package:trivia_expert_app/game/single_player/animations.dart';
// import 'package:trivia_expert_app/game/single_player/finished_game_page.dart';
// import 'package:trivia_expert_app/gamestates/gamestates_bloc.dart';
// import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
// import 'package:trivia_expert_app/questions/models/question.dart';
// part 'game_play_state.dart';
//
// class GamePlayCubit extends Cubit<GamePlayState> {
//   GamePlayCubit(GamePlayState initialState) : super(initialState);
//
//   StreamSubscription? _timeSubscription;
//   final Ticker _ticker = Ticker();
//
//   void fetchGameState(GameState gameState, GameStatus gameStatus) {
//     state.copyWith(gameState: gameState);
//     emit(state);
//   }
//
//   void monitorTimer(AnimationController? controller, BuildContext context, int time) {
//       if (time == state.totalTime) {
//         AnimationHelper.startAnimationFour = true;
//         context.read<GameStatesBloc>().add(UpdateGameState(state.gameState!));
//         emit(state.copyWith(gameStatus: GameStatus.game_end));
//       } else {
//         if(time % (state.totalTime! / 3) == 0)
//           controller?.forward().whenComplete(() => {controller.reverse()});
//
//       }
//   }
//
//   void validateAnswer(
//       AnimationController multiButtonMotionController,
//       String? value,
//       int tapped,
//       QuestionBloc questionBloc,
//       BuildContext context,
//       ) {
//     GamePlayState gamePlayState = state;
//     if (!state.isButtonTapped!) {
//       AnimationController? _controllerX;
//       switch (tapped) {
//         case 0:
//           _controllerX = AnimationHelper.controllerOne;
//           break;
//         case 1:
//           _controllerX = AnimationHelper.controllerTwo;
//           break;
//         case 2:
//           _controllerX = AnimationHelper.controllerThree;
//           break;
//         case 3:
//           _controllerX = AnimationHelper.controllerFour;
//           break;
//       }
//       questionBloc = context.read<QuestionBloc>();
//
//       emit(gamePlayState.copyWith(isButtonTapped: true, correctAnswer: questionBloc.state.questions[state.index!].correctAnswer));
//       if (value == state.correctAnswer) {
//         updateProgress(context);
//
//         emit(state.copyWith(qAnswered: 1, gameState: state.gameState!.copyWith(player1: state.gameState!.player1!.copy(score: 1))));
//         _playAnimation(_controllerX, multiButtonMotionController, questionBloc);
//       } else {
//         // you only need to fail once and that's all for you
//         gamePlayState.listBol[tapped] = false;
//         emit(gamePlayState);
//         _playAnimation(_controllerX, multiButtonMotionController, questionBloc);
//       }
//     }
//   }
//
//   void updateProgress(BuildContext context) {
//     if (state.qAnswered == 10) {
//       _timeSubscription?.cancel();
//       Navigator.pop(context);
//     }
//
//   }
//
//   Future<void> _playAnimation(AnimationController? colorController,
//       AnimationController? controller, QuestionBloc questionBloc) async {
//     try {
//       await colorController!.forward().then((value) {});
//       await controller!.forward().whenComplete(() {
//         resetState(questionBloc);
//       });
//       await colorController.reverse();
//
//       await controller.reverse().whenComplete(() {
//         emit(state.copyWith(isButtonTapped: false));
//       });
//     } on TickerCanceled {
//       // the animation got canceled, probably because we were disposed
//     }
//   }
//
//   void resetState(QuestionBloc questionBloc) {
//     // _cardController?.forward().whenComplete(() {
//     //   _cardController?.reverse();
//     // });
//     emit(state.copyWith(listBol: [true, true, true, true], index: 1));
//     fetchQuestions(questionBloc,);
//   }
//   void fetchQuestions(QuestionBloc questionBloc) {
//     if (state.index == 9) {
//       QuestionsFetched.offSet += 10;
//       questionBloc.add(QuestionsFetched());
//       emit(state.copyWith(index: 0));
//     }
//   }
//
//   void initializeState(AnimationController controller, BuildContext context, QuestionBloc questionBloc,) {
//     fetchQuestions(questionBloc);
//     startTimer(controller, context);
//   }
//
//   Future<void> startTimer(AnimationController controller, BuildContext context) async {
//     if(_timeSubscription != null) {
//       await _timeSubscription?.cancel();
//     }
//     _timeSubscription = _ticker.tick().listen((event) {
//       monitorTimer(controller, context, event);
//       emit(state.copyWith(secondsRemaining: state.totalTime! - event));
//     });
//   }
//   Future<void> _playAnimationFail(AnimationController? colorController) async {
//     try {
//       await colorController!.forward().whenComplete(() {
//         colorController.reverse();
//       });
//     } on TickerCanceled {}
//   }
//   @override
//   Future<void> close() {
//     _timeSubscription?.cancel();
//     return super.close();
//   }
// }
// class Ticker {
//   Stream<int> tick() {
//     return Stream.periodic(const Duration(seconds: 1), (x) => x);
//   }
// }
//
