part of 'user_bloc.dart';

enum HomeStatus{waiting, updated, failure_update, fetched}
class UserState extends Equatable {
  final HomeStatus homeStatus;
  final User? user;
  final int highScore;
  final int xp;
  final UserGameDetails gameDetails;
  final List<GameState> gameStates;

  const UserState({this.xp = 0, this.highScore = 0,this.gameStates = const [], this.user = User.empty, this.homeStatus = HomeStatus.waiting, this.gameDetails = const UserGameDetails()}); /// default state of item is zero which is tab zero

  UserState copyWith({
    HomeStatus? homeStatus,
    User? user,
    int? highScore,
    int? xp,
    List<GameState>? gameStates,
    UserGameDetails? gameDetails,

}) {
    return UserState(
      homeStatus: homeStatus ?? this.homeStatus,
      user: user ?? this.user,
      xp: xp ?? this.xp,
      gameStates: gameStates ?? this.gameStates,
      highScore: highScore ?? this.highScore,
      gameDetails: gameDetails ?? this.gameDetails,
    );
}
  @override
  List<Object> get props => [xp, highScore, homeStatus, user!, gameStates, gameDetails];

}