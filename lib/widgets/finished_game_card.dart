import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/widgets/progress_indicator_widgets/roundrect_progress_indicator.dart';

class GameStatsCard extends StatelessWidget {
  final String category;
  final int score;
  final double ratio;

  const GameStatsCard({Key? key, required this.category, this.score = 0, this.ratio = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$category : $score%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 0.80 * MediaQuery.of(context).size.width,
          height: 0.015 * MediaQuery.of(context).size.height,
          child: RoundRectIndicator(
            value: ratio,
            radius: 24.0,
            valueColor: AlwaysStoppedAnimation<Color>(ratio < 0.5 ? Colors.deepOrange : Colors.indigo),
          ),
        ),
      ],
    );
  }
}