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
          'Category Stats',
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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 0.80 * MediaQuery.of(context).size.width,
                    height: 0.33 * MediaQuery.of(context).size.height,
                    // elevation: 8.0,
                    decoration:
                        BoxDecoration(color: Colors.white, border: Border.all(width: 2.0)),
                    child: Column(
                      children: listStats,
                    ),
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
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text('TOTAL QUESTIONS ANSWERED: '),
                              Text('${state.totalQuestions}', style: TextStyle(
                                  fontFamily: 'showCardGothic',
                                  color: Colors.blue,
                                  fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text('TOTAL SCORE: '),
                              Text('${state.totalScores}', style: TextStyle(
                                  fontFamily: 'showCardGothic',
                                  color: Colors.blue,
                                  fontSize: 18),),
                            ],
                          ),
                          SizedBox(height: 15,),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 0.80 * MediaQuery.of(context).size.width,
                    height: 0.33 * MediaQuery.of(context).size.height,
                    // elevation: 8.0,
                    decoration:
                    BoxDecoration(color: Colors.white, border: Border.all(width: 2.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Proficiency',
                            style: GoogleFonts.droidSans(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 15,),
                          Stack(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: CircularProgressIndicator(
                                  strokeWidth: 8.0,
                                  value: state.proficiency / 100,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                              Positioned(top: 26.0, left: 14.0,child: Text('${state.proficiency}%', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),))
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text(assessScore(state.proficiency), style: GoogleFonts.droidSans(
                              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w900),),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
  else return 'See if you can do better!';
}
