class GameStats {
  static Map<String, Stats> gameStats = {
  };
}

class Stats {
  int score = 0;
  int categoryFrequency = 0;

  Stats(this.score, this.categoryFrequency);
}
