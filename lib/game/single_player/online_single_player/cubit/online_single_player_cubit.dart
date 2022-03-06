import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/game_stats.dart';

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
  void retrieveIndex() {
    int? index;
    prefs.then((value) => index = value.getInt('index'));
    emit(state.copyWith(index: index ?? state.index));
  }
  void saveIndex() {
    prefs.then((value) => value.setInt('index', state.index));
  }

  void correctButtonSelected() {
    /// will the code be simpler without this cubit ? !
    emit(state.copyWith(status: GameStatus.correct));
  }

  void wrongButtonSelected() {
    emit(state.copyWith(status: GameStatus.incorrect));
  }

  Future<void> updateQuestion(int score) {
    List<Color> colors = List.filled(4, Colors.white);
    //TODO: make duration parameter smaller
    //TODO: each new question will have a time of 3 seconds
    return Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(
          playerScore: score, colors: colors, index: state.index + 1));
    });
  }

  void answerValidate(int buttonSelected) {
    var question = state.questions[state.index];
    var score = state.playerScore;
    var answer = question.answers![buttonSelected];
    List<Color> colors = List.generate(4, (index) {
      if (index == buttonSelected) {
        if (question.correctAnswer == answer) {
          GameStats.gameStats.update(question.category!,
              (value) => Stats(value.score + 1, value.categoryFrequency + 1), ifAbsent: (){return Stats(1,1);});
          score++;
          return Colors.teal;
        } else {
          GameStats.gameStats.update(question.category!,
              (value) => Stats(value.score, value.categoryFrequency + 1), ifAbsent: (){return Stats(0, 0);});
          return Colors.red;
        }
      }
      //TODO: correct answer should be indicated,
      return Colors.white;
    });

    emit(state.copyWith(colors: colors));
    updateQuestion(score);
  }

  @override
  Future<void> close() {
    _timeSubscription?.cancel();
    return super.close();
  }
}

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x);
  }
}
