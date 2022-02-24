import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_cubit.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/game_page.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:http/http.dart' as http;

class OnlineSinglePlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: BlocProvider(
          create: (_) => OnlineSinglePlayerCubit(OnlineSinglePlayerState(questions: context.read<QuestionBloc>().state.questions)),
          child: GamePage(),
        ),
      ),
    );
  }

}