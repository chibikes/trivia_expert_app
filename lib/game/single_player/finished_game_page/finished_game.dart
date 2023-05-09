import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_page.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_state.dart';

class FinishedGame extends StatelessWidget {
  final int score;
  final bool newLevel;
  final bool highScore;
  final double reward;
  final Map stats;


  const FinishedGame({Key? key, required this.score, required this.newLevel, required this.reward, required this.highScore, required this.stats}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => GameEndCubit(GameEndState())..getGameStats(), child: FinishedGamePage(stats: stats, highScore: highScore,score: score, newLevel: newLevel, reward: reward,),);
  }

}