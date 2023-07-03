part of 'user_bloc.dart';

enum HomeStatus { waiting, updated, failure_update, fetched }

class UserState extends Equatable {
  final HomeStatus homeStatus;
  final User? user;
  final int highScore;
  final int xp;
  final UserGameDetails gameDetails;
  final List<GameState> gameStates;
  final bool timeElasped;

  const UserState(
      {this.timeElasped = false,
      this.xp = 0,
      this.highScore = 0,
      this.gameStates = const [],
      this.user = User.empty,
      this.homeStatus = HomeStatus.waiting,
      this.gameDetails = const UserGameDetails(userId: '')});

  UserState copyWith({
    HomeStatus? homeStatus,
    User? user,
    int? highScore,
    int? xp,
    List<GameState>? gameStates,
    UserGameDetails? gameDetails,
    bool? timeElaps,
  }) {
    return UserState(
      homeStatus: homeStatus ?? this.homeStatus,
      user: user ?? this.user,
      xp: xp ?? this.xp,
      gameStates: gameStates ?? this.gameStates,
      highScore: highScore ?? this.highScore,
      gameDetails: gameDetails ?? this.gameDetails,
      timeElasped: timeElaps ?? this.timeElasped,
    );
  }

  @override
  List<Object> get props =>
      [xp, highScore, homeStatus, user!, gameStates, gameDetails, timeElasped];
}
