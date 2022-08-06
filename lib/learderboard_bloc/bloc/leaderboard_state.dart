import 'package:equatable/equatable.dart';

class LeaderBoardState extends Equatable {
  final List<Map<String, int>> gameScores;
  final int position;

  LeaderBoardState({
    this.gameScores = const [],
    this.position = 0,
  });

  LeaderBoardState copyWith({
    List<Map<String, int>>? gameScores,
    int? position,
  }) {
    return LeaderBoardState(
      gameScores: gameScores ?? this.gameScores,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [gameScores, position];
}
