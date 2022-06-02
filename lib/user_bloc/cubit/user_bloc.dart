import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repo_packages/repo_packakges.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/high_score_repo/high_score_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._userRepository, {
    required AuthenticationRepository authRepository,
  })  : _authRepository = authRepository,
        super(UserState()) {
    _authRepoSub = _authRepository.user.listen(
      (event) {
        user = event;
        add(FetchUserData());
      },
    );
  }

  StreamSubscription? _authRepoSub;
  final AuthenticationRepository _authRepository;
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
      yield* _getHighScore();
    } else if (event is UpdatePlayerStat) yield* _updateHighScore(event);
    else if (event is SavePlayerStat) _saveUserStats(event);
  }

  Future<void> getUserData() async {
    _authRepoSub?.cancel();
    user = (await _userRepository.getUserData(
      user,
    ));
    add(UserUpdated(user));
  }

  @override
  Future<Function?> close() {
    _authRepoSub?.cancel();
    return super.close().then((value) => value as Function?);
  }

  UserState _userChangedToState(UserUpdated? event) {
    return state.copyWith(homeStatus: HomeStatus.fetched, user: event!.user);
  }

  Stream<UserState> _mapUpdateUserToState(UpdateUser event) async* {
    yield state.copyWith(homeStatus: HomeStatus.waiting);
    try {
      await _userRepository.updateUser(event.user);
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

  Stream<UserState> _getHighScore() async* {
    var score =
        await FileStorage.instance.then((value) => value.getInt(highScore));
    var xp =
        await FileStorage.instance.then((value) => value.getInt(gameLevel));
    yield state.copyWith(highScore: score, xp: xp);
  }

  Stream<UserState> _updateHighScore(UpdatePlayerStat event) async*{
    add(SavePlayerStat(event.highScore ?? state.highScore, event.xp ?? state.xp));
    yield state.copyWith(highScore: event.highScore, xp: event.xp);
  }

  void _saveUserStats(SavePlayerStat event) {
    HighScoreRepo.updateScore(state.user!.id!, event.highScore, state.user!.photoUrl!, state.user!.name!);
    FileStorage.instance.then((value) => value.setInt(highScore, event.highScore));
    FileStorage.instance.then((value) => value.setInt(gameLevel, event.xp));
  }
}
