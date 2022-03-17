import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/main_models/questions.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';

class OnlineSinglePlayerCubit extends Cubit<OnlineSinglePlayerState> {
  OnlineSinglePlayerCubit(OnlineSinglePlayerState state) : super(state);
  StreamSubscription? _timeSubscription;
  final Ticker _ticker = Ticker();
  final prefs = SharedPreferences.getInstance();

  Future<void> startTimer() async {
    if (_timeSubscription != null) {
      await _timeSubscription?.cancel();
    }
    _timeSubscription = _ticker.tick().listen((event) {
      print('*************>>>>>>>>>>>>>>!!!!!!$event');
      emit(state.copyWith(time: state.time - 1));
    });
  }

  Future<void> stopTimer() async {
    await _timeSubscription?.cancel();
  }

  void retrieveIndex() async {
    int? index;
    await prefs.then((value) => index = value.getInt('index'));
    emit(state.copyWith(index: index ?? state.index));
  }

  void saveIndex(int index) async {
    await prefs.then((value) => value.setInt('index', index));
    emit(state.copyWith(index: index));
  }

  Future<void> updateQuestion(int score) {
    List<Color> colors = List.filled(4, Colors.white);
    //TODO: make duration parameter smaller
    //TODO: each new question will have a time of 3 seconds
    bool reachedQuestionsEnd = state.index == state.questions.length - 1;
    return Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(
          time: kTotalGameTime,
          playerScore: score,
          colors: colors,
          index: reachedQuestionsEnd ? state.index : state.index + 1,
          gameStatus: reachedQuestionsEnd
              ? GameStatus.getQuestions
              : GameStatus.inProgress),);
    });
  }

  void validateAnswer(int buttonSelected) {
    emit(state.copyWith(gameStatus: GameStatus.checkingAnswer));
    var question = state.questions[state.index];
    var score = state.playerScore;
    var answer = question.answers![buttonSelected];
    List<Color> colors = List.generate(question.answers!.length, (index) {
      if (index == buttonSelected) {
        if (question.correctAnswer == answer) {
          GameStats.gameStats.update(question.category!,
              (value) => Stats(value.score + 1, value.categoryFrequency + 1),
              ifAbsent: () {
            return Stats(1, 1);
          });
          score++;
          return Colors.teal;
        } else {
          emit(state.copyWith(life: state.life - 1));
          GameStats.gameStats.update(question.category!,
              (value) => Stats(value.score, value.categoryFrequency + 1),
              ifAbsent: () {
            return Stats(0, 0);
          });
          return Colors.red;
        }
      }
      return state.questions[state.index].correctAnswer == state.questions[state.index].answers![index] ? Colors.teal : Colors.white;
    });

    emit(state.copyWith(colors: colors));
    updateQuestion(score);
  }
  void useRightAnswer() {
    var question = state.questions[state.index];
    var buttonSelected = question.answers!.indexWhere((element) => element == question.correctAnswer);
    validateAnswer(buttonSelected);
  }

  @override
  Future<void> close() {
    _timeSubscription?.cancel();
    return super.close();
  }

  void emitQuestions(List<Questions> questions) {
    if(state.gameStatus == GameStatus.inProgress) {
      emit(state.copyWith(questions: questions,));
    } else if(state.gameStatus == GameStatus.getQuestions) {
      emit(state.copyWith(
          questions: questions,
          index: 0,
          gameStatus: GameStatus.inProgress));
    }
  }
}

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x);
  }
}
