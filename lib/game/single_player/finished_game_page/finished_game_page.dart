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
  const FinishedGamePage({
    Key? key,
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
            score: ((value.score / value.categoryFrequency) * 100).toInt(),
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
              ChalkBoard(
                height: 0.33 * MediaQuery.of(context).size.height,
                width: 0.80 * MediaQuery.of(context).size.width,
                widget: Column(
                    // if new level nice if not see if you can try better
                    children: [
                      Text(''),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'SCORE ${GamingStats.recentStats[highScore]}',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        'LEVEL ${GamingStats.recentStats[gameLevel]}',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ]),
              ),
              SizedBox(
                height: 20.0,
              ),
              ChalkBoard(
                width: 0.80 * MediaQuery.of(context).size.width,
                height: 0.33 * MediaQuery.of(context).size.height,
                // elevation: 8.0,
                widget: Column(
                  children: listStats,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 0.80 * MediaQuery.of(context).size.width,
                  height: 0.33 * MediaQuery.of(context).size.height,
                  // elevation: 8.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Game Stats',
                          style: GoogleFonts.droidSans(
                              fontSize: 20,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('TOTAL QUESTIONS ANSWERED: '),
                            Text(
                              '${state.totalQuestions}',
                              style: TextStyle(
                                  fontFamily: 'showCardGothic',
                                  color: Colors.blue,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Text('TOTAL SCORE: '),
                            Text(
                              '${state.totalScores}',
                              style: TextStyle(
                                  fontFamily: 'showCardGothic',
                                  color: Colors.blue,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('SPEED: '),
                            Text(
                              //TODO: remove hard code
                              '${state.speed} Q/s',
                              style: TextStyle(
                                  fontFamily: 'showCardGothic',
                                  color: Colors.blue,
                                  fontSize: 18),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text('ACCURACY: '),
                            Text(
                              '${state.accuracy}%',
                              style: TextStyle(
                                  fontFamily: 'showCardGothic',
                                  color: Colors.blue,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
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
    GamingStats.setRecentStats(
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
