import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_page.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_state.dart';

class FinishedGame extends StatelessWidget {
  final int score;
  final bool newLevel;

  const FinishedGame({Key? key, required this.score, required this.newLevel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => GameEndCubit(GameEndState())..getGameStats(), child: FinishedGamePage(score: score, newLevel: newLevel,),);
  }

}