import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';
import 'package:trivia_expert_app/main_models/user_game_details.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._userRepository, {
    required AuthenticationRepository authRepository, required GameRepository gameRepository,
  })  : _authRepository = authRepository, _gameRepository = gameRepository,
        super(UserState()) {
    _authRepoSubscription = _authRepository.user.listen(
      (event) {
        user = event;
        add(FetchUserData());
      },
    );
  }

  StreamSubscription? _authRepoSubscription, _scoreSubscription;
  final AuthenticationRepository _authRepository;
  final GameRepository _gameRepository;
  final FirebaseUserRepository _userRepository;
  User user = User.empty;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUserData)
      getUserData();
    else if (event is UserUpdated)
      yield _userChangedToState(event);
    else if (event is UpdateUser)
      yield* _mapUpdateUserToState(event);
    else if (event is UpdateUserImage)
      _updateImage(event.imgPath);
    else if (event is GetUserStat) {
      _getHighScore();
    } else if (event is UpdatePlayerStat) yield* _updateHighScore(event);
    else if (event is SavePlayerStat) _saveUserStats(event);
    else if (event is UserStatFetched) yield state.copyWith(gameDetails: event.gameDetails);
    else if (event is DeleteUser) {
      await _userRepository.deleteUser(user);
      await _userRepository.deleteUserImage(user.id ?? '');
      await _authRepository.deleteAccount();
      await _authRepository.logOut();
    }
  }

  Future<void> getUserData() async {
    _authRepoSubscription?.cancel();
    user = await _userRepository.getUserData(user);
    add(UserUpdated(user));
    add(GetUserStat());
  }

  @override
  Future<Function?> close() {
    _scoreSubscription?.cancel();
    _authRepoSubscription?.cancel();
    return super.close().then((value) => value as Function?);
  }

  UserState _userChangedToState(UserUpdated? event) {
    return state.copyWith(homeStatus: HomeStatus.fetched, user: event!.user);
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event) async* {
    yield state.copyWith(homeStatus: HomeStatus.waiting);
    try {
      await _userRepository.updateUser(event.user);
      yield state.copyWith(homeStatus: HomeStatus.updated);
      add(UserUpdated(event.user));
    } catch (e) {
      yield state.copyWith(homeStatus: HomeStatus.failure_update);
      yield state.copyWith(homeStatus: HomeStatus.fetched);
    }
  }

  Future<void> _updateImage(String imgPath) async {
    String photoUrl = await _userRepository.saveUserImage(imgPath, user.id!);
    add(UpdateUser(user.copyWith(
      photoUrl: photoUrl,
    )));
  }

   _getHighScore() {
    var gameDeets = state.gameDetails;
    _scoreSubscription = _gameRepository.getUserGameDetails(state.user!.id!).listen((userDetails) {
       gameDeets = userDetails;
       add(UserStatFetched(gameDeets));
    });
  }

  Stream<UserState> _updateHighScore(UpdatePlayerStat event) async* {
    add(SavePlayerStat(event.highScore ?? state.gameDetails.highScore, event.xp ?? state.gameDetails.xp));
    yield state.copyWith(highScore: event.highScore, xp: event.xp);
  }

  void _saveUserStats(SavePlayerStat event) {
    var user = state.user!;
    GameRepository.updateScore(user.id!, state.gameDetails.copyWith(userId: user.id, xp: event.xp, avatarUrl: user.photoUrl, userName: user.name, highScore: event.highScore));
  }
}
