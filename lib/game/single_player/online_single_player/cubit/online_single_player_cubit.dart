
import 'package:bloc/bloc.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';

class OnlineSinglePlayerCubit extends Cubit<OnlineSinglePlayerState> {
  OnlineSinglePlayerCubit(OnlineSinglePlayerState state) : super(state);

  void correctButtonSelected() { /// will the code be simpler without this cubit ? !
    emit(state.copyWith(status: GameStatus.correct));
  }

  void wrongButtonSelected() {
    emit(state.copyWith(status: GameStatus.incorrect));
  }
}