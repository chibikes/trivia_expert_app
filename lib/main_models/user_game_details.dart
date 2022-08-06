import 'package:equatable/equatable.dart';

class UserGameDetails extends Equatable {
  final int highScore;
  final int xp;
  final int blueCrystals;
  final int redCrystals;
  final int correctAnswers;

  const UserGameDetails(
      {this.highScore = 0, this.xp = 0, this.blueCrystals = 0, this.correctAnswers = 0, this.redCrystals = 0});
  @override
  // TODO: implement props
  List<Object?> get props => [highScore, xp, blueCrystals, redCrystals, correctAnswers];

  Map toMap() {
    return {
      'highScore' : highScore,
      'xp' : xp,
      'blueCrystals' : blueCrystals,
      'redCrystals' : redCrystals,
      'correctAnswers' : correctAnswers,
    };
  }
  static UserGameDetails fromMap(Map<String, int> gameDetails) {
    return UserGameDetails(
      highScore: gameDetails['highScore'] ?? 0,
      xp: gameDetails['xp'] ?? 0,
      blueCrystals: gameDetails['blueCrystals'] ?? 0,
      redCrystals: gameDetails['redCrystals'] ?? 0,
      correctAnswers: gameDetails['correctAnswers'] ?? 0,
    );
  }

}