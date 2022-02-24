// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'package:repo_packages/repo_packakges.dart';
//
// part 'gamestates_event.dart';
// part 'gamestates_state.dart';
//
// class GameStatesBloc extends Bloc<GameStatesEvent, GameStatesState> {
//   final GameStateRepository _gameStatesRepository;
//   UserRepository? userRepository;
//   final User? user;
//   StreamSubscription? _gameStatesSubscription;
//   StreamSubscription? _singleGameStateSubscription;
//
//   GameStatesBloc({
//     @required GameStateRepository? gameStatesRepository,
//     this.user,
//     this.userRepository,
//   })  : _gameStatesRepository = gameStatesRepository!,
//         super(GameStatesLoading());
//
//   @override
//   Stream<GameStatesState> mapEventToState(GameStatesEvent event) async* {
//     if (event is LoadGameStates)
//       yield* _mapLoadGameStatesToState();
//     else if (event is GameStatesUpdated)
//       yield* _mapGameStatesUpdateToState(event);
//     else if (event is CreateGameState) yield* _mapCreateGameStateToState(event);
//     else if (event is SearchForGameState)
//       yield* _mapSearchForGameStateToState(event);
//     else if (event is UpdateGameState) yield* _mapUpdateGameStateToEvent(event);
//     else if (event is CreatedGameSuccess) yield* _mapCreatedGameSuccessToEvent(event);
//   }
//
//   @override
//   Future<void> close() {
//     _gameStatesSubscription?.cancel();
//     _singleGameStateSubscription?.cancel();
//     return super.close();
//   }
//
//   Stream<GameStatesState> _mapLoadGameStatesToState() async* {
//     List<GameState?> statesLoaded = [];
//     _gameStatesSubscription?.cancel();
//     _gameStatesSubscription =
//         _gameStatesRepository.getGameStates(this.user!).listen((gameStates) {
//       statesLoaded = gameStates;
//       add(GameStatesUpdated(gameStates));
//     });
//     yield GameStatesLoaded(statesLoaded);
//   }
//
//   Stream<GameStatesState> _mapGameStatesUpdateToState(
//       GameStatesUpdated event) async* {
//     yield GameStatesLoaded(event.gameStates);
//   }
//
//   Stream<GameStatesState> _mapCreateGameStateToState(
//       CreateGameState event) async* {
//
//     yield SearchForGameSessionInProgress();
//     GameState gameState = GameState.name(
//       sessionID: null,
//       creatorId: user!.id,
//       timeCreated: DateTime.now().toUtc().toString(),
//       player1: Player(id: user!.id, name: user!.name, photo: user!.photo),
//       player2: Player.empty
//     );
//     String id = await _gameStatesRepository.stubbedFunc(gameState);
//     _gameStatesRepository.updateGameState(gameState.copyWith(sessionId: id));
//
//     _singleGameStateSubscription?.cancel();
//     _singleGameStateSubscription = _gameStatesRepository
//         .startNewGameSession(id, user!)
//         .timeout(Duration(minutes: 25), onTimeout: (sink) async{
//       _gameStatesRepository.deleteGameState(gameState);
//       gameState = await _gameStatesRepository.FindNewUser(this.user!);
//       updateGameIds(gameState, event.gameStateIndex);
//     }).listen((gameSession){
//       gameState = gameSession!;
//       if (gameState.player2 != Player.empty) {
//         updateGameIds(gameState, event.gameStateIndex);
//       }
//     });
//   }
//
//   Stream<GameStatesState> _mapSearchForGameStateToState(
//       SearchForGameState event) async* {
//     // GameState gameState = GameState.name();
//
//     /// user.gameIds[no four] = gamestate.id. call load ids.
//     GameState gameState = await _gameStatesRepository
//         .searchAvailableGameSessions(this.user!, event.gameStateIndex);
//     if (gameState != GameState.empty && !(state is StartGameSession)) {
//       /// search was successful
//       updateGameIds(gameState, event.gameStateIndex);
//     } else {
//       add(CreateGameState(gameState, event.gameStateIndex));
//     }
//   }
//
//   void updateGameIds(GameState gameState, int pos) {
//     List gIds = List.generate(user!.gameIds.length, (index)  {
//       String gameId;
//       index == pos ? gameId = gameState.sessionID! :
//       gameId = user!.gameIds[index];
//       return gameId;
//     });
//
//     userRepository!.updateUser(user!.copyWith(gameIds: gIds));
//     add(CreatedGameSuccess(gameState));
//   }
//
//   Stream<GameStatesState> _mapUpdateGameStateToEvent(
//       UpdateGameState event) async* {
//     _gameStatesRepository.updateGameState(event.updatedGameState);
//   }
//
//   Stream<GameStatesState>_mapCreatedGameSuccessToEvent(event) async*{
//     _singleGameStateSubscription?.cancel();
//     yield StartGameSession(event.gameState);
//   }
// }
