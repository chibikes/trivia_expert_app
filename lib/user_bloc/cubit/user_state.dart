part of 'user_bloc.dart';

enum HomeStatus{waiting, updated, failure_update, fetched}
class UserState extends Equatable {
  final HomeStatus homeStatus;
  final User? user;
  final List<GameState> gameStates;

  const UserState({this.gameStates = const [], this.user = User.empty, this.homeStatus = HomeStatus.waiting}); /// default state of item is zero which is tab zero

  UserState copyWith({
    HomeStatus? homeStatus,
    User? user,
    List<GameState>? gameStates,

}) {
    return UserState(
      homeStatus: homeStatus ?? this.homeStatus,
      user: user ?? this.user,
      gameStates: gameStates ?? this.gameStates,
    );
}
  @override
  List<Object> get props => [homeStatus, user!, gameStates];

}