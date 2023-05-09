import 'package:equatable/equatable.dart';

class GameEndState extends Equatable {
  final int accuracy;
  final double speed;
  final int totalQuestions;
  final int totalScores;
  final double proficiency;
  final Map stats;
  GameEndState({this.speed = 0, this.accuracy = 0, this.totalQuestions = 0, this.totalScores = 0, this.proficiency = 0, this.stats = const {}});
  GameEndState copyWith({int? accuracy, double? speed, int? totalQuestions, int? scores, double? proficiency, Map? stats}) {
    return GameEndState(
      speed: speed ?? this.speed,
      accuracy: accuracy ?? this.accuracy,
      totalScores: scores ?? this.totalScores,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      proficiency: proficiency ?? this.proficiency,
      stats: stats ?? this.stats,
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [accuracy, speed, totalQuestions, totalScores, proficiency, stats];

}