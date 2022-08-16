import 'package:equatable/equatable.dart';

abstract class LeaderBoardEvent extends Equatable {
  @override

  List<Object?> get props => [];

}

class CreateLeaderBoard extends LeaderBoardEvent {
  final List<Map<String, dynamic>> gameScores;

  CreateLeaderBoard(this.gameScores);

}

class GetUserId extends LeaderBoardEvent{
  final String id;

  GetUserId(this.id);
}
