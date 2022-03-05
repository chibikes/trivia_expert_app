class GameStats {
  static Map<String, Stats> gameStats = {
    'Science': Stats(0, 0),
    'math': Stats(0, 0),
  };
  static void updateStats(String category) {
    // gameStats.map((key, value) => null).
  }
}

class Stats {
  //TODO: consider making class final
  int score = 0;
  int categoryFrequency = 0;

  Stats(this.score, this.categoryFrequency);
}

/// score / noOfTimes category appeared
