import 'package:equatable/equatable.dart';

class UserGameDetails extends Equatable {
  final String userId;
  final String avatarUrl;
  final String userName;
  final int highScore;
  final int xp;
  final int blueCrystals;
  final int redCrystals;
  final int correctAnswers;

  const UserGameDetails(
      {required this.userId, this.avatarUrl = '', this.userName = '', this.highScore = 0, this.xp = 0, this.blueCrystals = 0, this.correctAnswers = 0, this.redCrystals = 0});
  @override
  // TODO: implement props
  List<Object?> get props => [userId, avatarUrl, userName, highScore, xp, blueCrystals, redCrystals, correctAnswers];

  Map<String, Object?> toMap() {
    return {
      'userId' : userId,
      'avatarUrl' : avatarUrl,
      'userName' : userName,
      'highScore' : highScore,
      'xp' : xp,
      'blueCrystals' : blueCrystals,
      'redCrystals' : redCrystals,
      'correctAnswers' : correctAnswers,
    };
  }
  UserGameDetails copyWith({String? userId, String? avatarUrl, String? userName, int? highScore, int? xp, int? blueCrystals, int? redCrystals, int? correctAnswers}) {
    return UserGameDetails(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      userName: userName ?? this.userName,
      highScore: highScore ?? this.highScore,
      xp: xp ?? this.xp,
      blueCrystals: blueCrystals ?? this.blueCrystals,
      redCrystals: redCrystals ?? this.redCrystals,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      userId: userId ?? this.userId,


    );
  }
  static UserGameDetails fromMap(Map<String, dynamic> gameDetails) {
    return UserGameDetails(
      userId: gameDetails['userId'] ?? '',
      avatarUrl: gameDetails['avatarUrl'] ?? '',
      userName: gameDetails['userName'] ?? '',
      highScore: gameDetails['highScore'] ?? 0,
      xp: gameDetails['xp'] ?? 0,
      blueCrystals: gameDetails['blueCrystals'] ?? 0,
      redCrystals: gameDetails['redCrystals'] ?? 0,
      correctAnswers: gameDetails['correctAnswers'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'UserGameDetails{userId: $userId, avatarUrl: $avatarUrl, userName: $userName, highScore: $highScore, xp: $xp, blueCrystals: $blueCrystals, redCrystals: $redCrystals, correctAnswers: $correctAnswers}';
  }
}