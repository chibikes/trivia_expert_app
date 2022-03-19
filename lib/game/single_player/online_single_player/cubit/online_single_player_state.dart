import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/main_models/questions.dart';
import 'package:trivia_expert_app/questions/models/question.dart';

enum GameStatus {getQuestions, inProgress, checkingAnswer, levelChanged, highScore}

/// should correct and incorrect be states? let's find out.

class OnlineSinglePlayerState extends Equatable {
  const OnlineSinglePlayerState({
    this.colors = const [Colors.white, Colors.white, Colors.white, Colors.white,],
    this.index = 0,
    this.questions = const [],
    this.gameStatus = GameStatus.inProgress,
    this.playerScore = 0,
    this.time = kTotalGameTime,
    this.life = 3,
    this.level = 0,
    this.highScore = 0,
    this.highScoreEvent = false,
  });
  final int highScore;
  final GameStatus gameStatus;
  final int playerScore;
  final List<Questions> questions;
  final List<Color> colors;
  final int index;
  final int time;
  final int life;
  final int level;
  final bool highScoreEvent;

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
      highScore: highScore ?? this.highScore,
      highScoreEvent: highScoreEvent ?? this.highScoreEvent,
    );
  }

  @override
  List<Object> get props => [gameStatus, playerScore, questions, colors, index, time, life, level, highScoreEvent, highScore,];
}
