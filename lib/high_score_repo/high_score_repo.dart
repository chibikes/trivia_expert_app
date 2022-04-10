import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HighScoreRepo {
  final highScores = FirebaseFirestore.instance.collection('highScores');
  Future<void> updateScore(
    String id,
    String highScore,
    String photoUrl,
    String userName,
  ) {
    try {
      return highScores.doc(id).update({
        'highScore': highScore,
        'avatarUrl': photoUrl,
      });
    } catch (e) {
      return highScores.add({
        'highScore': highScore,
        'avatarUrl': photoUrl,
        'id': id,
        'userName': userName,
      });
    }
  }
}
