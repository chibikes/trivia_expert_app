import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/const.dart';
import 'package:trivia_expert_app/main_models/questions.dart';
import 'package:trivia_expert_app/questions/models/question.dart';

enum GameStatus {getQuestions, inProgress, timeout}

/// should correct and incorrect be states? let's find out.

class OnlineSinglePlayerState extends Equatable {
  const OnlineSinglePlayerState({
    this.colors = const [Colors.white, Colors.white, Colors.white, Colors.white,],
    this.index = 0,
    this.questions = const [],
    this.gameStatus = GameStatus.inProgress,
    this.playerScore = 0,
    this.time = kTotalGameTime,
    this.gameStats = const {},
        /// for our offline the initial score is always the highest score.
  });
  final GameStatus gameStatus;
  final int playerScore;
  final List<Questions> questions;
  final List<Color> colors;
  final int index;
  final int time;
  final Map<String, int> gameStats;

  OnlineSinglePlayerState copyWith({
    GameStatus? gameStatus,
    int? playerScore,
    List<Questions>? questions,
    int? index,
    List<Color>? colors,
    int? time,
  }) {
    return OnlineSinglePlayerState(
      gameStatus: gameStatus ?? this.gameStatus,
      playerScore: playerScore ?? this.playerScore,
      index: index ?? this.index,
      colors: colors ?? this.colors,
      time: time ?? this.time,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object> get props => [gameStatus, playerScore, questions, colors, index, time];
}
