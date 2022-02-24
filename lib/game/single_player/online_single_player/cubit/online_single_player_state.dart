import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/main_models/questions.dart';
import 'package:trivia_expert_app/questions/models/question.dart';

enum GameStatus { correct, incorrect, inprogress, timeout }

/// should correct and incorrect be states? let's find out.

class OnlineSinglePlayerState extends Equatable {
  const OnlineSinglePlayerState({
    this.colors = const [Colors.white, Colors.white, Colors.white, Colors.white,],
    this.index = 0,
    this.questions = const [],
    this.gameStatus = GameStatus.inprogress,
    this.playerScore = 0,
    this.time = 20,
        /// for our offline the initial score is always the highest score.
  });
  final GameStatus gameStatus;
  final int playerScore;
  final List<Questions> questions;
  final List<Color> colors;
  final int index;
  final int time;

  OnlineSinglePlayerState copyWith({
    GameStatus? status,
    int? playerScore,
    int? index,
    List<Color>? colors,
    int? time,
  }) {
    return OnlineSinglePlayerState(
      gameStatus: status ?? this.gameStatus,
      playerScore: playerScore ?? this.playerScore,
      index: index ?? this.index,
      colors: colors ?? this.colors,
      time: time ?? this.time,
    );
  }

  @override
  List<Object> get props => [playerScore, questions, colors, index, time];
}
