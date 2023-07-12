import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/game/single_player/online_single_player/cubit/online_single_player_state.dart';
import 'package:trivia_expert_app/game_stats.dart';
import 'package:trivia_expert_app/main_models/questions.dart';
import 'package:audioplayers/audioplayers.dart';

class OnlineSinglePlayerCubit extends Cubit<OnlineSinglePlayerState> {
  OnlineSinglePlayerCubit(
      OnlineSinglePlayerState state, this.user, this.highScore)
      : super(state);
  StreamSubscription? _timeSubscription;
  final Ticker _ticker = Ticker();
  final prefs = SharedPreferences.getInstance();
  final User user;
  final int highScore;

  Future<void> startTimer() async {
    if (_timeSubscription != null) {
      await _timeSubscription?.cancel();
    }
    _timeSubscription = _ticker.tick().listen((event) {
      emit(state.copyWith(time: state.time - 1));
    });
  }

  Future<void> stopTimer() async {
    await _timeSubscription?.cancel();
  }

  void retrieveGameState() async {
    var level, index, life;

    await prefs.then((value) => index = value.getInt(gameIndex));
    await prefs.then((value) => level = value.getInt(gameLevel));
    await prefs.then((value) => life = value.getInt(redCrystals) ?? 0);
    life += state.life;
    emit(state.copyWith(
        index: index ?? state.index, level: level ?? state.level, life: life));
  }

  void saveGameState(int index) async {
    await prefs.then((value) => value.setInt(gameIndex, index));
    await prefs.then((value) => value.setInt(gameLevel, state.level));
    emit(state.copyWith(index: index));
  }

  Future<void> updateQuestion(int score) {
    List<Color> colors = List.filled(4, Colors.white);
    bool reachedQuestionsEnd = state.index == state.questions.length - 1;
    var nextQuestion = reachedQuestionsEnd
        ? state.questions[state.index]
        : state.questions[state.index + 1];
    bool isHardQuestion = nextQuestion.question!.length >= 60 ||
        nextQuestion.difficulty == 'hard';
    return Future.delayed(Duration(seconds: 1), () {
      emit(
        state.copyWith(
            time: isHardQuestion ? kTotalGameTime : 10,
            playerScore: score,
            colors: colors,
            index: reachedQuestionsEnd ? state.index : state.index + 1,
            gameStatus: reachedQuestionsEnd
                ? GameStatus.getQuestions
                : GameStatus.inProgress,
            answerStatus: AnswerStatus.initial,
            gameText: ''),
      );
    });
  }

  void validateAnswer(int buttonSelected) {
    emit(state.copyWith(gameStatus: GameStatus.checkingAnswer));
    var question = state.questions[state.index];
    var score = state.playerScore;
    var answer = question.answers![buttonSelected];
    List<Color> colors = List.generate(question.answers!.length, (index) {
      if (index == buttonSelected) {
        var category = getCategory(question.category!);

        if (question.correctAnswer == answer) {
          GameStats.gameStats.update(category,
              (value) => Stats(value.score + 1, value.categoryFrequency + 1),
              ifAbsent: () {
            return Stats(1, 1);
          });
          score++;
          var text = '';
          if (score <= 3) {
            text = 'GOOD!';
          } else if (score == 6) {
            text = 'NICE!';
          } else if (score == 9) {
            text = 'NICE!!';
          }
          emit(state.copyWith(
              reward: state.reward + 1,
              answerStatus: AnswerStatus.correct,
              gameText: text));
          if (state.highScoreEvent == false && score > highScore) {
            // playVictorySound();
            emit(
              state.copyWith(
                  gameStatus: GameStatus.highScore,
                  highScoreEvent: true,
                  reward: state.reward + 5),
            );
          }

          if (score == 10) {
            // playVictorySound();
            emit(state.copyWith(
                level: state.level + 1,
                gameStatus: GameStatus.levelChanged,
                newLevelEvent: true,
                reward: state.reward + 5));
          }

          playWinSound();

          return Colors.teal;
        } else {
          playFailSound();
          emit(state.copyWith(
              life: state.life - 1, answerStatus: AnswerStatus.wrong));
          GameStats.gameStats.update(category,
              (value) => Stats(value.score, value.categoryFrequency + 1),
              ifAbsent: () {
            return Stats(0, 1);
          });
          return Colors.red;
        }
      }
      //TODO: move this color logic to UI
      return question.correctAnswer == question.answers![index]
          ? Colors.teal
          : Colors.white;
    });

    emit(state.copyWith(colors: colors));
    updateQuestion(score);
  }

  String getCategory(String category) {
    if (RegExp('^Entertainment', caseSensitive: false).hasMatch(category)) {
      category = 'Entertainment';
    } else if (RegExp('^Art', caseSensitive: false).hasMatch(category)) {
      category = 'Art';
    } else if (RegExp('^Science', caseSensitive: false).hasMatch(category)) {
      category = 'Science';
    } else if (RegExp('^History', caseSensitive: false).hasMatch(category)) {
      category = 'History';
    }
    category = category.replaceAll('_', ' ');
    category = category.toUpperCase();
    return category;
  }

  void useRightAnswer() {
    emit(state.copyWith(rightAnswersUsed: state.rightAnswersUsed + 1));
    var question = state.questions[state.index];
    var buttonSelected = question.answers!
        .indexWhere((element) => element == question.correctAnswer);
    validateAnswer(buttonSelected);
  }

  @override
  Future<void> close() {
    _timeSubscription?.cancel();
    return super.close();
  }

  void emitQuestions(List<Questions> questions) {
    if (state.gameStatus == GameStatus.inProgress) {
      emit(state.copyWith(
        questions: questions,
      ));
    } else if (state.gameStatus == GameStatus.getQuestions) {
      emit(state.copyWith(
          questions: questions, index: 0, gameStatus: GameStatus.inProgress));
    }
  }

  void playWinSound() {
    final audioPlayer = AudioCache();
    audioPlayer.play(
      'win.mp3',
      volume: 0.5,
      mode: PlayerMode.LOW_LATENCY,
    );
  }

  void playFailSound() {
    final audioPlayer = AudioCache();
    audioPlayer.play('wrong_answer.mp3', mode: PlayerMode.LOW_LATENCY);
  }

  void playVictorySound() {
    final audioPlayer = AudioCache();
    audioPlayer.play('high_score.mp3', mode: PlayerMode.LOW_LATENCY);
  }

  void resetGameState({int? score}) {
    emit(state.copyWith(
        highScoreEvent: false, questions: [], playerScore: score ?? 0));
  }
}

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (x) => x);
  }
}
