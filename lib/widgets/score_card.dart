import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_expert_app/widgets/trophy_cup_layer.dart';
import 'package:trivia_expert_app/widgets/xp_icon.dart';

import '../user_bloc/cubit/user_bloc.dart';

class ScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context).size;
    var state = context.read<UserBloc>().state;
    var highScore = state.gameDetails.highScore;
    var xp = state.gameDetails.xp;

    return Column(
      children: [
        Container(
          height: data.height * 0.16,
          width: data.height * 0.16,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xff8b5a2b)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Icon(
                          FontAwesomeIcons.trophy,
                          color: Colors.orange,
                          size: data.width * 0.09,
                        ),
                        Positioned(
                          top: 3.0,
                          left: data.width * 0.020,
                          child: CustomPaint(
                            painter: TrophyLayerPainter(),
                            size: Size(23, 20),
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          left: data.width * 0.055,
                          child: Container(
                            height: 3,
                            width: 3,
                            decoration: BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          highScore.toString().length <= 6 ? '$highScore' : highScore.toString().replaceRange(7, highScore.toString().length, '..'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                        Text(
                          'High Score',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        )
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: 2.0,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomPaint(
                        painter: XPPainter(
                          Colors.blue,
                          Colors.lightBlue,
                        ),
                        // size: Size(28, 35),
                        size: Size(data.width * 0.08, data.height * 0.05)
                    ),
                    Column(
                      children: [
                        Text(
                          '$xp',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                        Text(
                          'XP',
                          style: GoogleFonts.alegreyaSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}