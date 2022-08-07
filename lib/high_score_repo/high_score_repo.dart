import 'package:cloud_firestore/cloud_firestore.dart';

import '../main_models/user_game_details.dart';

class GameRepository {
  static final highScores = FirebaseFirestore.instance.collection('highScores');
  static Future<void> updateScore(
    String id,
    int highScore,
    String photoUrl,
    String userName,
  ) {
      return highScores.doc(id).update({
        'highScore': highScore,
        'avatarUrl': photoUrl,
      }).onError((error, stackTrace) => highScores.doc(id).set({
        'highScore': highScore,
        'avatarUrl': photoUrl,
        'id': id,
        'userName': userName,
      }));
  }
  Stream<UserGameDetails> getUserGameDetails(String id) {
    return highScores.doc(id).snapshots().map((event) => UserGameDetails.fromMap(event.data()! as Map<String, int>));
  }
  Stream<List<Map<String, int>>> getLeaderBoard() {
    return highScores.snapshots().map((event)  {
      return event.docs.map((e) => e.data() as Map<String, int>).toList();
    });
  }
  Future<void> updateUserGameDetails(String id, UserGameDetails gameDetails) {
    return highScores.doc(id).update(gameDetails.toMap()).onError((error, stackTrace) => highScores.doc(id).set(gameDetails.toMap()));
  }
}
