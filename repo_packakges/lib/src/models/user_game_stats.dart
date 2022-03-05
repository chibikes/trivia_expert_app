import 'package:repo_packages/src/models/power_ups.dart';

class UserGameStats {
  Map<String, int> usersPlayed; /// map of users(id) played and no of wins
  final PowerUps powerUps;

  UserGameStats(this.usersPlayed, this.powerUps);

  Map<String, dynamic> toMap() {
    return {
      'usersPlayed' : usersPlayed,
      'powerUps' : powerUps.toMap(),
    };
  }
}
