import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/authentication/authentication.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_cubit.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/view/game_page.dart';
import 'package:trivia_expert_app/questions/bloc/question_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:trivia_expert_app/user_bloc/cubit/user_bloc.dart';

class OnlineSinglePlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.status == QuestionStatus.inProgress ? Color(0xff81d4fa) : Colors.green,
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: BlocProvider(
              create: (_) => OnlineSinglePlayerCubit(OnlineSinglePlayerState(), context.read<UserBloc>().state.user ?? User(), context.read<UserBloc>().state.gameDetails.highScore),
              child: GamePage(),
            ),
          ),
        );
      }
    );
  }

}