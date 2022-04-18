import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repo_packages/repo_packakges.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._userRepository, {
    required AuthenticationRepository authRepository,
  })  : _authRepository = authRepository,
        super(UserState()) {
    _authRepoSub = _authRepository.user.listen(
      (event)  {
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
    else if (event is UpdateUser) yield* _mapUpdateUserToState(event);
    else if (event is UpdateUserImage) _updateImage(event.imgPath);
  }



  Future<void> getUserData() async {
    _authRepoSub?.cancel();
     user = (await _userRepository.getUserData(user,));
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
  Future<void> _updateImage(String imgPath) async{
    String photoUrl = await _userRepository.saveUserImage(imgPath, user.id!);
    add(UpdateUser(user.copyWith(photoUrl: photoUrl,)));
  }
}
