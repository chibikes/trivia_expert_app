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
    await FileStorage._instance?.setDouble('Accuracy', accuracy);
    if (gameStats.containsKey(scienceStat)) {
      stats = gameStats[scienceStat]!;
      await FileStorage._instance
          ?.setDouble(scienceStat, stats.score / stats.categoryFrequency);
    }
    if (gameStats.containsKey(historyStat)) {
      stats = gameStats[historyStat]!;
      await FileStorage._instance
          ?.setDouble(historyStat, stats.score / stats.categoryFrequency);
    }
    if (gameStats.containsKey(geographyStat)) {
      stats = gameStats[geographyStat]!;
      await FileStorage._instance
          ?.setDouble(historyStat, stats.score / stats.categoryFrequency);
    }
    if (gameStats.containsKey(entertainmentStat)) {
      stats = gameStats[entertainmentStat]!;
      await FileStorage._instance
          ?.setDouble(historyStat, stats.score / stats.categoryFrequency);
    }
  }
}
