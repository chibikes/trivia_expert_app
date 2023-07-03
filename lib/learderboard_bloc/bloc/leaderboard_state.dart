import 'package:equatable/equatable.dart';

enum LeaderBoardStatus { fetching, fetched, failed }

class LeaderBoardState extends Equatable {
  final List<Map<String, dynamic>> gameScores;
  final int position;
  final LeaderBoardStatus leaderBoardStatus;
  final String time;

  LeaderBoardState({
    this.leaderBoardStatus = LeaderBoardStatus.fetching,
    this.gameScores = const [],
    this.position = 0,
    this.time = '',
  });

  LeaderBoardState copyWith({
    List<Map<String, dynamic>>? gameScores,
    int? position,
    LeaderBoardStatus? leaderBoardStatus,
    String? time,
  }) {
    return LeaderBoardState(
      gameScores: gameScores ?? this.gameScores,
      position: position ?? this.position,
      leaderBoardStatus: leaderBoardStatus ?? this.leaderBoardStatus,
      time: time ?? this.time,
    );
  }

  @override
  List<Object?> get props => [gameScores, position, leaderBoardStatus, time];
}
