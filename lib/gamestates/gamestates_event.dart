part of 'gamestates_bloc.dart';

abstract class GameStatesEvent extends Equatable {
  const GameStatesEvent();

  @override
  List<Object> get props => [];
}

class LoadGameStates extends GameStatesEvent {}

class CreateGameState extends GameStatesEvent {
  final GameState gameState;
  final int gameStateIndex;

  const CreateGameState(this.gameState, this.gameStateIndex);

  @override
  List<Object> get props => [gameState];
}
class SearchForGameState extends GameStatesEvent {
  final int gameStateIndex;

  SearchForGameState(this.gameStateIndex);
}



class UpdateGameState extends GameStatesEvent {
  final GameState updatedGameState;

  const UpdateGameState(this.updatedGameState);

  @override
  List<Object> get props => [updatedGameState];

}

class DeleteGameState extends GameStatesEvent {
  final GameState gameState;

  const DeleteGameState(this.gameState);

  @override
  List<Object> get props => [gameState];
}
class GameStatesUpdated extends GameStatesEvent {
  final List<GameState?> gameStates;

  const GameStatesUpdated(this.gameStates);

  @override
  List<Object> get props => [gameStates];
}
