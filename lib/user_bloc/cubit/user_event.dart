part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{

  @override
  List<Object?> get props => [];

}

class ChangeProfile extends UserEvent {

}


class UpdateUserImage extends UserEvent {
  final String imgPath;

  UpdateUserImage(this.imgPath);
}

class FetchUserData extends UserEvent {

}
class UserUpdated extends UserEvent {
  UserUpdated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
class UpdateUser extends UserEvent {
  final User user;

   UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class GetUserStat extends UserEvent{

}

class UpdatePlayerStat extends UserEvent {
  final int? highScore;
  final int? xp;

  UpdatePlayerStat({this.highScore, this.xp});
}

class SavePlayerStat extends UserEvent {
  final int highScore;
  final int xp;

  SavePlayerStat(this.highScore, this.xp);
}

class UserStatFetched extends UserEvent {
  final UserGameDetails gameDetails;
  UserStatFetched(this.gameDetails);

}