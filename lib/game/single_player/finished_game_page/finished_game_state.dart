import 'package:equatable/equatable.dart';

class GameEndState extends Equatable {
  final int accuracy;
  final double speed;
  final int totalQuestions;
  final int totalScores;
  final double proficiency;

  GameEndState({this.speed = 0, this.accuracy = 0, this.totalQuestions = 0, this.totalScores = 0, this.proficiency = 0});
  GameEndState copyWith({int? accuracy, double? speed, int? totalQuestions, int? scores, double? proficiency}) {
    return GameEndState(
      speed: speed ?? this.speed,
      accuracy: accuracy ?? this.accuracy,
      totalScores: scores ?? this.totalScores,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      proficiency: proficiency ?? this.proficiency,
    );
}

  @override
  // TODO: implement props
  List<Object?> get props => [accuracy, speed, totalQuestions, totalScores, proficiency];

}