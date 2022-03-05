class Scores {
  final String id;
  final int dailyScore;
  final int score;
  final int offlineScore;

  Scores(this.id, this.dailyScore, this.score, this.offlineScore);


  Map<String, dynamic> toMap(){
    return {
      // 'email' : email,
      'id' : id,
      'dailyScore' : dailyScore,
      'score' : score,
      'offLineScore' : offlineScore,
    };
  }
}