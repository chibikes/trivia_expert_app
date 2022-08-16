import 'package:equatable/equatable.dart';

enum LeaderBoardStatus {fetching, fetched, failed}
class LeaderBoardState extends Equatable {
  final List<Map<String, dynamic>> gameScores;
  final int position;
  final LeaderBoardStatus leaderBoardStatus;

  LeaderBoardState({
    this.leaderBoardStatus = LeaderBoardStatus.fetching,
    this.gameScores = const [],
    this.position = 0,
  });

  LeaderBoardState copyWith({
    List<Map<String, dynamic>>? gameScores,
    int? position,
    LeaderBoardStatus? leaderBoardStatus,
  }) {
    return LeaderBoardState(
      gameScores: gameScores ?? this.gameScores,
      position: position ?? this.position,
      leaderBoardStatus: leaderBoardStatus ?? this.leaderBoardStatus,
    );
  }

  @override
  List<Object?> get props => [gameScores, position, leaderBoardStatus];
}
