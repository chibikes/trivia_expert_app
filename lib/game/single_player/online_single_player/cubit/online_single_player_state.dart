import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/main_models/questions.dart';

enum GameStatus {
  getQuestions,
  inProgress,
  checkingAnswer,
  levelChanged,
  highScore
}

/// should correct and incorrect be states? let's find out.

class OnlineSinglePlayerState extends Equatable {
  const OnlineSinglePlayerState(
      {this.colors = const [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
      ],
      this.index = 0,
      this.rightAnswersUsed = 0,
      this.questions = const [],
      this.gameStatus = GameStatus.inProgress,
      this.playerScore = 0,
      this.time = kTotalGameTime,
      this.life = gameLife,
      this.level = 0,
      this.reward = 0,
      this.highScoreEvent = false,
      this.newLevelEvent = false,
      this.stats = const {}});
  final GameStatus gameStatus;
  final int playerScore;
  final List<Questions> questions;
  final List<Color> colors;
  final int rightAnswersUsed;
  final int index;
  final int time;
  final int life;
  final int level;
  final bool highScoreEvent;
  final bool newLevelEvent;
  final double reward;
  final Map stats;

  OnlineSinglePlayerState copyWith({
    GameStatus? gameStatus,
    int? playerScore,
    List<Questions>? questions,
    int? index,
    List<Color>? colors,
    int? time,
    int? life,
    int? level,
    int? highScore,
    bool? highScoreEvent,
    bool? newLevelEvent,
    double? reward,
    Map? stats,
    int? rightAnswersUsed,
  }) {
    return OnlineSinglePlayerState(
      gameStatus: gameStatus ?? this.gameStatus,
      playerScore: playerScore ?? this.playerScore,
      index: index ?? this.index,
      colors: colors ?? this.colors,
      time: time ?? this.time,
      questions: questions ?? this.questions,
      life: life ?? this.life,
      level: level ?? this.level,
      highScoreEvent: highScoreEvent ?? this.highScoreEvent,
      newLevelEvent: newLevelEvent ?? this.newLevelEvent,
      reward: reward ?? this.reward,
      stats: stats ?? this.stats,
      rightAnswersUsed: rightAnswersUsed ?? this.rightAnswersUsed,
    );
  }

  @override
  List<Object> get props => [
        gameStatus,
        playerScore,
        questions,
        colors,
        index,
        time,
        life,
        level,
        highScoreEvent,
        newLevelEvent,
        reward,
        stats,
        rightAnswersUsed
      ];
}
