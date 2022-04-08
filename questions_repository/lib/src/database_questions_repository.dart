import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:questions_repository/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'models/questions.dart';
import 'questions_repository.dart';

class DatabaseQuestionsRepository implements QuestionRepository {
  static Database? _database;
  static int? offsetX;
  static int? databaseRows;
  final prefs = SharedPreferences.getInstance();

  @override
  Future<List<TriviaQuestion>> fetchQuestions(int offset, int limit) async {
    await initDatabase();
    offsetX == null ? await getOffsetFromStorage() : await updateAndSaveOffset();
    final List<Map<String, dynamic>> maps = await _database!
        .query('trivia_questions', limit: rowsRetrieved, offset: offsetX);
    debugPrint('************************************************************row beelow');
    debugPrint(databaseRows.toString());
    return List.generate(maps.length, (i) {
      return TriviaQuestion(
        id: maps[i]['id'],
        category: maps[i]['category'],
        type: maps[i]['type'],
        difficulty: maps[i]['difficulty'],
        question: maps[i]['question'],
        correctAnswer: maps[i]['correct_answer'],
        incorrectOne: maps[i]['incorrect_one'],
        incorrectTwo: maps[i]['incorrect_two'],
        incorrectThree: maps[i]['incorrect_three'],
      );
    });
  }
  static Future<int?> getRow() async {
    return Sqflite.firstIntValue(await _database!.rawQuery('SELECT COUNT(*) FROM $triviaDBaseTable'));
  }
  // Future<int> getOffsetFromStorage() async {
  //   int? offset;
  //   await prefs.then((value)  {offset = value.getInt('offset') ?? 0;});
  //   return offset;
  // }

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'trivia_ex.database'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE trivia_questions(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, category TEXT, type TEXT, difficulty TEXT, question TEXT, '
          'correct_answer TEXT, incorrect_one TEXT, incorrect_two TEXT, incorrect_three TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> getOffsetFromStorage() async {
      await prefs.then((value)  {offsetX = value.getInt('offset') ?? 0;});
  }

  updateAndSaveOffset() async {
    databaseRows ??= await getRow();
    var newOffset = offsetX! + rowsRetrieved;
    offsetX = databaseRows! - newOffset < rowsRetrieved ? 0 : newOffset;
    prefs.then((value) => value.setInt('offset', offsetX!));
  }
}
