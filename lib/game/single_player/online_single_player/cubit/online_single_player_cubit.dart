import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';

class OnlineSinglePlayerCubit extends Cubit<OnlineSinglePlayerState> {
  OnlineSinglePlayerCubit(OnlineSinglePlayerState state) : super(state);
  StreamSubscription? _timeSubscription;
  final Ticker _ticker = Ticker();

  Future<void> startTimer() async{
    if(_timeSubscription != null) {
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
  void correctButtonSelected() { /// will the code be simpler without this cubit ? !
    emit(state.copyWith(status: GameStatus.correct));
  }

  void wrongButtonSelected() {
    emit(state.copyWith(status: GameStatus.incorrect));
  }


  Future<void> nextQuestion(int score) {
    List<Color> colors = List.filled(4, Colors.white);
    //TODO: make duration parameter smaller
    return Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(playerScore: score, colors: colors, index: state.index + 1));
    });
  }
  void answerValidate(int buttonSelected) {
    var score = state.playerScore;
    var answer = state.questions[state.index].answers![buttonSelected];
    var correctAnswer = state.questions[state.index].correctAnswer;
    List<Color> colors = List.generate(4, (index) {
      if(index == buttonSelected) {
        if(correctAnswer == answer) {
          score++;
          return Colors.teal;
        } else return Colors.red;
      }
      //TODO: correct answer should be indicated,
      return Colors.white;

    });
    emit(state.copyWith(colors: colors));
    nextQuestion(score);
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