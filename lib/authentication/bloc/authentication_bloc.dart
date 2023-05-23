import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pedantic/pedantic.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
    AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
      _userSubscription = _authenticationRepository.user.listen(
          (user) => add(AuthenticationUserChanged(user)),
      );

  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription? _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event
      ) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthenticationLogOutRequested) {
      unawaited(_authenticationRepository.logOut());
    } else if (event is DeleteAccount) {
      await _authenticationRepository.deleteAccount();
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close().then((value) => value as Function?);
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
      AuthenticationUserChanged event,
      ) {
    return event.user != User.empty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }
}