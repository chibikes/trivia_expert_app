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
  void correctButtonSelected() { /// will the code be simpler without this cubit ? !
    emit(state.copyWith(status: GameStatus.correct));
  }

  void wrongButtonSelected() {
    emit(state.copyWith(status: GameStatus.incorrect));
  }


  void nextQuestion() {
    emit(state.copyWith(index: state.index + 1));
  }
  void buttonSelected(String answer, int buttonSelected) {
    List<Color> colors = List.generate(4, (index) {
      if(index == buttonSelected) {
        if(index == buttonSelected && state.questions[state.index].correctAnswer == answer) {
          return Colors.green;
        } else return Colors.red;
      }
      //TODO: correct answer should be indicated,
      return Colors.white;

    });
    emit(state.copyWith(colors: colors));
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