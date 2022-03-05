part of 'main_page_bloc.dart';

abstract class MainEvent extends Equatable{

  @override
  List<Object?> get props => [];

}

class ChangeProfile extends MainEvent {

}
class UpdateChanges extends MainEvent {
  final User _user;
  UpdateChanges(this._user);
}
class FetchGameSessions extends MainEvent {
  final int gameNumber;
  FetchGameSessions(this.gameNumber);
}

class FetchUserData extends MainEvent {

}
class UserUpdated extends MainEvent {
  UserUpdated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
class UpdateUser extends MainEvent {
  final User user;

   UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}