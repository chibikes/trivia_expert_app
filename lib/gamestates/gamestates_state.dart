part of 'gamestates_bloc.dart';

abstract class GameStatesState extends Equatable {
  const GameStatesState();

  @override
  List<Object> get props => [];
}

class GameStatesLoaded extends GameStatesState {
  final List<GameState?> gameStates;

  const GameStatesLoaded([this.gameStates = const []]);
}
class GetGameState extends GameStatesState {
  final GameState gameState;

  GetGameState(this.gameState);
}
class StartGameSession extends GameStatesState {
  final GameState gameState;

  StartGameSession(this.gameState);
}
class SearchForGameSessionInProgress extends GameStatesState {

}

class GameStatesLoading extends GameStatesState {

}