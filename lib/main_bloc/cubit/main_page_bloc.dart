import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:repo_packages/repo_packakges.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(
    this._userRepository, {
    required AuthenticationRepository authRepository,
  })  : _authRepository = authRepository,
        super(MainState()) {
    _authRepoSub = _authRepository.user.listen(
      (event)  {
        user = event;
        add(FetchUserData());
        },
    );
  }

  StreamSubscription? _authRepoSub;
  final AuthenticationRepository _authRepository;
  final UserRepository _userRepository;
  User user = User.empty;


  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    // if (event is UpdateChanges)  yield await _updateProfileChanges(state, event._user);
    if (event is FetchGameSessions)
      yield await _fetchGameSess(event);
    else if (event is FetchUserData)
      yield* getData();
    else if (event is UserUpdated)
      yield _userChangedToState(event);
    else if (event is UpdateUser) yield* _mapUpdateUserToState(event);
  }

  Future<MainState> _fetchGameSess(FetchGameSessions event) async {
    try {
      searchAvailableGameSessions(state, event.gameNumber);
    } catch (e) {
      GameState gameState = GameState.name(
          rounds: 0,
          tTL: '',
          sessionID: '',
          player1: Player(
              id: state.user!.id,
              name: state.user!.name,
              photo: state.user!.photo),
          player2: null);
      createGameSess(gameState, event.gameNumber);
    }

    return state; // TODO: return state?.!
  }

  void createGameSess(GameState gameState, int gameNo) async {
    try {
      CollectionReference gameStates =
          FirebaseFirestore.instance.collection('gameStates');
      await gameStates.add(gameState.toMap()).then((value) =>
          state.user!.gameIds![gameNo] =
              value.id); // TODO: initialize gameId 'n' game states
      state.gameStates.add(gameState);
    } catch (e) {
      print('Firestore Error: $e');
    }
  }

  void searchAvailableGameSessions(MainState state, int gameNo) {
    try {
      FirebaseFirestore.instance
          .collection('gameStates')
          .where('playerTwo', isNull: true)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((docs) {
          state.user!.gameIds![gameNo] = docs.id;
          GameState gameState = GameState.name(
            rounds: docs["rounds"],
            tTL: docs["tTL"],
            player1: docs["playerOne"] as Player,
            player2: Player(
              id: state.user!.id,
              name: state.user!.name,
              photo: state.user!.photo,
            ),
            sessionID: docs.id,
          );

          updateGameState(gameState); // TODO: create a timeout funct~n
          state.gameStates.add(gameState);
        });
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> retrieveGameSession(int gameNum) async {
    Map<String, dynamic> map = Map();
    await FirebaseFirestore.instance
        .collection('gameStates')
        .doc(state.user!.gameIds![gameNum])
        .get()
        .then((value) {
      map = value.data()!;
    });
    state.gameStates[gameNum] = GameState.fromMap(map);
  }

  void updateGameState(GameState state) {
    FirebaseFirestore.instance
        .collection('gameStates')
        .doc(state.sessionID)
        .update(state.toMap());
  }

  Stream<MainState> getData() async* {
    _authRepoSub?.cancel();

      _userRepository.getUser(user.id!, _authRepository).listen(
            (event) {
              user = event!;
            }
          );
      add(UserUpdated(user));
  }

  @override
  Future<Function?> close() {
    _authRepoSub?.cancel();
    return super.close().then((value) => value as Function?);
  }

  MainState _userChangedToState(UserUpdated? event) {
    return state.copyWith(homeStatus: HomeStatus.fetched, user: event!.user);
  }

  Stream<MainState> _mapUpdateUserToState(UpdateUser event) async* {
    _userRepository.updateUser(event.user);
  }
}
