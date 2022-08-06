import 'package:equatable/equatable.dart';

abstract class LeaderBoardEvent extends Equatable {
  @override

  List<Object?> get props => [];

}

class GetLeaderBoard extends LeaderBoardEvent {
  final List<Map<String, int>> gameScores;

  GetLeaderBoard(this.gameScores);

}