import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_state.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/gamestates/gamestates_bloc.dart';
import 'package:trivia_expert_app/widgets/finished_game_card.dart';
import 'package:trivia_expert_app/widgets/game_widgets/chalkboard.dart';
import 'package:trivia_expert_app/widgets/progress_indicator_widgets/roundrect_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../file_storage.dart';

class FinishedGamePage extends StatefulWidget {
  final int score;
  final bool newLevel;
  const FinishedGamePage({
    Key? key, required this.score, required this.newLevel
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FinishedGamePageState();
  }
}

class FinishedGamePageState extends State<FinishedGamePage> {
  @override
  Widget build(BuildContext context) {
    var gameStats = GameStats.gameStats;
    List<Widget> listStats = [];
    listStats.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Category Stats',
          style: GoogleFonts.droidSans(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
    gameStats.forEach((key, value) {
      if (value.categoryFrequency != 0) {
        listStats.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: GameStatsCard(
            category: key,
            score: '${value.score}/${value.categoryFrequency}',
            ratio: value.score / value.categoryFrequency,
          ),
        ));
      }
    });
    return BlocBuilder<GameEndCubit, GameEndState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Color(0xffF8F0E3),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Center(child: Text('TRIVIA EXPERT', style: GoogleFonts.aBeeZee(color: Colors.blueAccent, fontSize: 30, fontWeight: FontWeight.bold))),
              ChalkBoard(
                height: 0.33 * MediaQuery.of(context).size.height,
                width: 0.80 * MediaQuery.of(context).size.width,
                widget: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.score > GamingStats.recentStats[highScore]! ? 'NEW HIGH SCORE!' : widget.newLevel ? 'NEW LEVEL UNLOCKED!' : 'SEE IF YOU CAN DO BETTER!', style: GoogleFonts.droidSans(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SCORE ${widget.score}',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        'LEVEL ${GamingStats.recentStats[gameLevel]}',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              ChalkBoard(
                width: 0.80 * MediaQuery.of(context).size.width,
                height: 0.40 * MediaQuery.of(context).size.height,
                // elevation: 8.0,
                widget: Column(
                  children: listStats,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void deactivate() {
    GamingStats.saveGamingStats(
        context.read<GameEndCubit>().state.proficiency / 100);
    GameStats.gameStats.clear();
    // context.read<GameEndCubit>().close();
    super.deactivate();
  }
}

String assessScore(double score) {
  // a score >= 10 definitely means a new level event!
  if (score >= 10)
    return 'NEW LEVEL UNLOCKED!';
  else
    return 'See if you can do better!';
}
