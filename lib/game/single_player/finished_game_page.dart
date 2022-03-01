import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/const.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/gamestates/gamestates_bloc.dart';
import 'package:trivia_expert_app/widgets/finished_game_card.dart';
import 'package:trivia_expert_app/widgets/progress_indicator_widgets/roundrect_progress_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinishedGamePage extends StatefulWidget {

  const FinishedGamePage({Key? key, }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return FinishedGamePageState();
  }
}

class FinishedGamePageState extends State<FinishedGamePage> {
  double totalScore = 0;
  double totalQuestions = 0;
  @override
  Widget build(BuildContext context) {
    var gameStats = GameStats.gameStats;
    List<Widget> listStats = [];
    listStats.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
            'Category',
            style: GoogleFonts.droidSans(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
    ),);
    gameStats.forEach((key, value) {
      totalScore += value.score;
      totalQuestions += value.categoryFrequency;
      if(value.categoryFrequency != 0 ) {
      listStats.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: GameStatsCard(
          category: key,
          score: value.score,
          ratio: value.score / value.categoryFrequency,
        ),
      ));
      }
    });
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
                  // children: [
                  //   Text(
                  //     'Category',
                  //     style: GoogleFonts.droidSans(
                  //         fontSize: 20,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w900),
                  //   ),
                  //   SizedBox(
                  //     height: 15,
                  //   ),
                  //   Text('SCIENCE : $sciScore'),
                  //   SizedBox(
                  //     width: 0.80 * MediaQuery.of(context).size.width,
                  //     child: RoundRectIndicator(
                  //       value: 0.9,
                  //       radius: 24.0,
                  //       valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                  //     ),
                  //   ),
                  //   Text('MATH : $sciScore'),
                  //   SizedBox(
                  //     width: 0.80 * MediaQuery.of(context).size.width,
                  //     child: RoundRectIndicator(
                  //       value: 0.6,
                  //       radius: 24.0,
                  //       valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                  //     ),
                  //   ),
                  // ],
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
                        '${totalQuestions/kTotalGameTime}Q/s',
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
                        '${totalScore/totalQuestions}%',
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
          Card(
            child: Column(
              children: [
                Text(
                  'NICE',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Get 80% Accuracy and finish all missions to level up!')
              ],
            ),
          ),
        ],
      ),
    );
    // else {
    //   return Scaffold(
    //     body: Container(
    //       color: Colors.blue,
    //       child: Column(
    //         children: [
    //           Text('Round ${context.read<GamePlayCubit>().state.gameState!.rounds}'),
    //           Row(
    //             children: [
    //               CircleAvatar(
    //                 backgroundImage: NetworkImage(context.read<GamePlayCubit>().state.gameState!.player1!.photo!)
    //               ),
    //               CircleAvatar(
    //                 backgroundImage: NetworkImage(context.read<GamePlayCubit>().state.gameState!.player2!.photo!),
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}
