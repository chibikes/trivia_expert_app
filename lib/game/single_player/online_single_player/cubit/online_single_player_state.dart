
import 'package:equatable/equatable.dart';

enum GameStatus{ correct, incorrect, inprogress, timeout} /// should correct and incorrect be states? let's find out.

class OnlineSinglePlayerState extends Equatable {
  const OnlineSinglePlayerState({
    this.gameStatus = GameStatus.inprogress,
    this.playerScore = 0 /// for our offline the initial score is always the highest score.

});
  final GameStatus gameStatus;
  final int playerScore;

  OnlineSinglePlayerState copyWith({
    GameStatus? status,
     int? playerScore,
  }) {
    return OnlineSinglePlayerState(
      gameStatus: status ?? this.gameStatus, /// if null then it would default
      playerScore: playerScore ?? this.playerScore,
    );
  }



  @override
  // TODO: implement props
  List<Object> get props => [];

}