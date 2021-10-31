import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repo_packages/repo_packakges.dart';

part 'gamestates_event.dart';
part 'gamestates_state.dart';

class GameStatesBloc extends Bloc<GameStatesEvent, GameStatesState> {
  final GameStateRepository _gameStatesRepository;
  UserRepository? userRepository;
  final User? user;
  StreamSubscription? _gameStatesSubscription;
  StreamSubscription? _singleGameStateSubscription;

  GameStatesBloc(
      {@required GameStateRepository? gameStatesRepository, this.user, this.userRepository})
      : _gameStatesRepository = gameStatesRepository!,
        super(GameStatesLoading());

  @override
  Stream<GameStatesState> mapEventToState(GameStatesEvent event) async* {
    if (event is LoadGameStates) yield* _mapLoadGameStatesToState();
    else if (event is GameStatesUpdated) yield* _mapGameStatesUpdateToState(event);
    if(event is CreateGameState) yield* _mapCreateGameStateToState(event);
    if (event is SearchForGameState) yield* _mapSearchForGameStateToState(event);
    if (event is UpdateGameState) yield* _mapUpdateGameStateToEvent(event);

  }

  @override
  Future<void> close() {
    _gameStatesSubscription?.cancel();
    _singleGameStateSubscription?.cancel();
    return super.close();
  }

  Stream<GameStatesState> _mapLoadGameStatesToState() async* {
    List<GameState?> statesLoaded = [];
    _gameStatesSubscription?.cancel();
    _gameStatesSubscription = _gameStatesRepository
        .getGameStates(this.user!)
        .listen((gameStates)  {
          statesLoaded = gameStates;
          add(GameStatesUpdated(gameStates));
        });
    yield GameStatesLoaded(statesLoaded);
  }

  Stream<GameStatesState>_mapGameStatesUpdateToState(GameStatesUpdated event) async* {
    yield GameStatesLoaded(event.gameStates);
  }
  Stream<GameStatesState> _mapCreateGameStateToState(CreateGameState event) async* {
    GameStatesState state = SearchForGameSessionInProgress(); /// if state is searchingforgame
    _singleGameStateSubscription?.cancel();
    _singleGameStateSubscription = _gameStatesRepository
        .startNewGameSession(this.user!)
        .timeout(Duration(seconds: 10), onTimeout: (sink) {
          print('********** ******** ****** !!!!!! Duration exceeded');
    })
        .listen((gameState)  async{
          String sevenSecondsSinceCreated = DateTime.parse(gameState!.timeCreated!).add(Duration(seconds: 7)).toString();
          if(DateTime.now().toUtc().toString().compareTo(sevenSecondsSinceCreated) >0) {
            _gameStatesRepository.deleteGameState(gameState);
            _singleGameStateSubscription!.cancel();
            gameState = await _gameStatesRepository.createNewGameSession(this.user!);
            updateGameIds(gameState, event.gameStateIndex, state);
            state = StartGameSession(gameState);
          } else if(gameState.player2 != null) {
            updateGameIds(gameState, event.gameStateIndex, state);
          }
        });
    yield state;
  }

  Stream<GameStatesState> _mapSearchForGameStateToState(SearchForGameState event) async* {
    GameState gameState = GameState.name();
    /// user.gameIds[no four] = gamestate.id. call load ids.
     gameState = await _gameStatesRepository.searchAvailableGameSessions(this.user!, event.gameStateIndex);
     if(gameState != GameState.empty && !(state is StartGameSession)) { /// search was successful
       this.user!.gameIds![event.gameStateIndex] = gameState.sessionID!;
       userRepository!.updateUser(this.user!);
        yield StartGameSession(gameState);
     } else {
       add(CreateGameState(gameState, event.gameStateIndex));
     }


  }
  void updateGameIds(GameState gameState, int index, GameStatesState state) {
    this.user!.gameIds![index] = gameState.sessionID!;
    userRepository!.updateUser(this.user!);
    _singleGameStateSubscription?.cancel();
    state = StartGameSession(gameState);
  }

  Stream<GameStatesState>_mapUpdateGameStateToEvent(UpdateGameState event) async*{
    _gameStatesRepository.updateGameState(event.updatedGameState);
  }
}

