import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/widgets/progress_indicator_widgets/roundrect_progress_indicator.dart';

class GameStatsCard extends StatelessWidget {
  final String category;
  final String score;
  final double ratio;

  const GameStatsCard({Key? key, required this.category, this.score = '', this.ratio = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text(category.length <= 30 ? category : category.replaceRange(30, category.length, '...'), style: style,), Text(score, style: style,)]),
        SizedBox(
          width: 0.80 * MediaQuery.of(context).size.width,
          height: 0.015 * MediaQuery.of(context).size.height,
          child: RoundRectIndicator(
            value: ratio,
            radius: 24.0,
            backgroundColor: Colors.amber,
            valueColor: AlwaysStoppedAnimation<Color>(ratio < 0.5 ? Colors.deepOrange : Colors.teal),
          ),
        ),
      ],
    );
  }
}