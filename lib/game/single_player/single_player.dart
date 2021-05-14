
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';

import 'online_single_player/view/online_single_player.dart';

class SinglePlayerPage extends StatelessWidget { /// should have win lose or initial so if you fail in game play you'll come back here with a state of lose
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('TRIVIA'),
        ElevatedButton(
            onPressed: () {Navigator.push(
            context, MaterialPageRoute(builder: (context){
              return OnlineSinglePlayer();
            })
      );
    },
            child: Text('Start')
        )
      ],
    );
  }

}