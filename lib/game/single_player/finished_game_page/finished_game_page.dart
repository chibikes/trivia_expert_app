import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/const.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_cubit.dart';
import 'package:trivia_expert_app/game/single_player/finished_game_page/finished_game_state.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/gamestates/gamestates_bloc.dart';
import 'package:trivia_expert_app/widgets/finished_game_card.dart';
import 'package:trivia_expert_app/widgets/progress_indicator_widgets/roundrect_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          'Category',
          style: GoogleFonts.droidSans(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900),
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
    return BlocBuilder<GameEndCubit, GameEndState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 0.80 * MediaQuery.of(context).size.width,
                  // elevation: 8.0,
                  decoration:
                      BoxDecoration(color: Colors.white, border: Border.all()),
                  child: Column(
                    children: listStats,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 0.80 * MediaQuery.of(context).size.width,
                  // elevation: 8.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Column(
                    children: [
                      Text(
                        'Game Stats',
                        style: GoogleFonts.droidSans(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text('SPEED : '),
                          Text(
                            //TODO: remove hard code
                            '${state.speed}Q/s',
                            style: TextStyle(
                                fontFamily: 'showCardGothic',
                                color: Colors.blue,
                                fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text('ACCURACY : '),
                          Text(
                            '${state.accuracy}%',
                            style: TextStyle(
                                fontFamily: 'showCardGothic',
                                color: Colors.blue,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 0.80 * MediaQuery.of(context).size.width,
                  // elevation: 8.0,
                  decoration:
                  BoxDecoration(color: Colors.white, border: Border.all()),
                  child: Column(
                    children: [
                      Text(assessScore(state.proficiency)),
                    ]
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

String assessScore(double score) {
  if(score >= 90) return 'Excellent!';
  else if(score >= 70) return 'Nice!';
  else if(score >= 50) return 'Good!';
  else return 'See if you can do better';
}
