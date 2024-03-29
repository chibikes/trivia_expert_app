part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User user;

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class AuthenticationLogOutRequested extends AuthenticationEvent {

}

class DeleteAccount extends AuthenticationEvent {

}
