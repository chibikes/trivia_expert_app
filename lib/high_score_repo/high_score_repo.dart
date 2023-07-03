import 'package:cloud_firestore/cloud_firestore.dart';
import '../main_models/user_game_details.dart';

class GameRepository {
  static final highScores = FirebaseFirestore.instance.collection('highScores');
  static Future<void> updateScore(String id, UserGameDetails gameDetails) {
    return highScores.doc(id).update(gameDetails.toMap()).onError(
        (error, stackTrace) => highScores.doc(id).set(gameDetails.toMap()));
  }

  Stream<UserGameDetails> getUserGameDetails(String id) {
    try {
      return highScores
          .doc(id)
          .snapshots()
          .map((event) => UserGameDetails.fromMap(event.data()!));
    } catch (e) {
      throw 'exception is: $e';
    }
  }

  Stream<List<Map<String, dynamic>>> getLeaderBoard() {
    var utc = DateTime.now().toUtc();
    utc.copyWith(hour: 0, second: 0, minute: 0, millisecond: 0, microsecond: 0);
    return highScores
        .orderBy('highScore', descending: true)
        // .where("time" isEqualTo: )
        .snapshots()
        .map((event) {
      return event.docs.map((e) => e.data()).toList();
    });
  }

  Future<void> updateUserGameDetails(String id, UserGameDetails gameDetails) {
    return highScores.doc(id).update(gameDetails.toMap()).onError(
        (error, stackTrace) => highScores.doc(id).set(gameDetails.toMap()));
  }
}
