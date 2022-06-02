import 'package:cloud_firestore/cloud_firestore.dart';

class HighScoreRepo {
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
}
