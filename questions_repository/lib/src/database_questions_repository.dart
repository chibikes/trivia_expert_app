import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:questions_repository/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'models/question.dart';
import 'models/questions.dart';
import 'questions_repository.dart';
import 'package:http/http.dart' as http;

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

class OnlineRepository implements QuestionRepository {
  @override
  Future<List<TriviaQuestion>> fetchQuestions(int offset, int limit) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    List<TriviaQuestion> questions = [];
    List<Result> results = [];
    var url = Uri.parse('https://opentdb.com/api.php?amount=10&encode=base64');

    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      var question = Question.fromJson(body);
      results = question.results!;

      for (int i = 0; i < results.length; i++) {
        questions.add(TriviaQuestion(
          category: stringToBase64.decode(results[i].category!),
          type: stringToBase64.decode(results[i].type!),
          difficulty: stringToBase64.decode(results[i].difficulty!),
          question: stringToBase64.decode(results[i].question!),
          correctAnswer: stringToBase64.decode(results[i].correctAnswer!),
          incorrectOne: stringToBase64.decode(results[i].incorrectAnswers![0]),
          incorrectTwo: results[i].incorrectAnswers!.length > 1
              ? stringToBase64.decode(results[i].incorrectAnswers![1])
              : '',
          incorrectThree: results[i].incorrectAnswers!.length > 2
              ? stringToBase64.decode(results[i].incorrectAnswers![2])
              : '',
        ));
      }
    }
    return questions;
  }
}
