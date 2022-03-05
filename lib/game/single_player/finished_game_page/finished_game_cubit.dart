import 'package:bloc/bloc.dart';
import 'package:trivia_expert_app/const.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_state.dart';
import 'package:trivia_expert_app/game_stats.dart';

class GameEndCubit extends Cubit<GameEndState> {
  GameEndCubit(GameEndState initialState) : super(initialState);

  void calcStats() {
    var speed = state.totalQuestions / kTotalGameTime;
    var accuracy = (state.totalScores / state.totalQuestions) * 100;
    emit(state.copyWith(speed: speed, accuracy: accuracy.toInt()));
    calcProficiency();
  }
  void calcProficiency() {
    var proficiency = (3 / 4 * state.accuracy) + (1 / 4 * speedToPercentage(state.speed));
    emit(state.copyWith(proficiency: proficiency));
  }


  num speedToPercentage(double speed) {
    return speed > 1 ? 100 : speed * 100;
  }
  void getGameStats() {
    var totalScores = 0;
    var questions = 0;
    GameStats.gameStats.forEach((key, value) {
      totalScores += value.score;
      questions += value.categoryFrequency;
    });
    emit(state.copyWith(scores: totalScores, totalQuestions: questions));
    calcStats();

  }

}