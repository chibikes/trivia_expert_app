import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/game_stats.dart';

class FileStorage {
  static SharedPreferences? _instance;

  static Future<SharedPreferences> get instance async {
    _instance ??= await SharedPreferences.getInstance();
    return _instance!;
  }
}

class RecentStats {
  static Map<String, double?> recentStats = {
    accuracyStat: FileStorage._instance?.getDouble(accuracyStat),
    scienceStat: FileStorage._instance?.getDouble(scienceStat),
    historyStat: FileStorage._instance?.getDouble(historyStat),
    geographyStat: FileStorage._instance?.getDouble(geographyStat),
    entertainmentStat: FileStorage._instance?.getDouble(entertainmentStat),
  };
  static void setRecentStats(double accuracy) async {
    var gameStats = GameStats.gameStats;
    var stats;
    await FileStorage._instance?.setDouble(accuracyStat, calcAvg(accuracyStat, accuracy, totalGamePlayed));
    if (gameStats.containsKey(scienceStat)) {
      stats = gameStats[scienceStat]!;
      await FileStorage._instance
          ?.setDouble(scienceStat, calcAvg(scienceStat, stats.score / stats.categoryFrequency, totalSci));
    }
    if (gameStats.containsKey(historyStat)) {
      stats = gameStats[historyStat]!;
      await FileStorage._instance
          ?.setDouble(historyStat, calcAvg(historyStat, stats.score / stats.categoryFrequency, totalHis));
    }
    if (gameStats.containsKey(geographyStat)) {
      stats = gameStats[geographyStat]!;
      await FileStorage._instance
          ?.setDouble(historyStat, calcAvg(geographyStat, stats.score / stats.categoryFrequency, totalGeo));
    }
    if (gameStats.containsKey(entertainmentStat)) {
      stats = gameStats[entertainmentStat]!;
      await FileStorage._instance
          ?.setDouble(entertainmentStat, calcAvg(entertainmentStat,stats.score / stats.categoryFrequency, totalEnt));
    }
  }
  static double calcAvg(String key, num newValue, String totalNKey) {
    var prevValue = getPrevVal(key);
    var n = getN(totalNKey) + 1;
    FileStorage._instance?.setInt(totalNKey, n);
    return (prevValue + newValue) / n;
  }

  static double getPrevVal(String key) {
    return FileStorage._instance?.getDouble(key) ?? 0;
  }

  static int getN(String key) {
    return FileStorage._instance?.getInt(key) ?? 0;
  }
}
