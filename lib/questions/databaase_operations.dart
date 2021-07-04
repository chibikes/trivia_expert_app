import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:trivia_expert_app/main_model/questions.dart';
import 'package:http/http.dart' as http;
import 'models/question.dart';

class DatabaseOperations {

  static Future<void> insertQuestions(Questions questions, Database database) async {
    final db = database;

    await db.insert('questions', questions.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  static Future<void> fetchQuestionsAndInsertToDatabase (Database database, int primaryKey) async {
    var url = Uri.parse('https://opentdb.com/api.php?amount=50');
    for (int i=0; i < 60; i++) {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        Question question = Question.fromJson(body);
        List<Result> results = question.results!;
        for (int i = 0; i < results.length; i++) {
          Questions questions = Questions(id: primaryKey,
            category: results[i].category,
            type: results[i].type,
            difficulty: results[i].difficulty,
            question: results[i].question,
            correctAnswer: results[i].correctAnswer,
            incorrectOne: results[i].incorrectAnswers![0],
            incorrectTwo: results[i].incorrectAnswers!.length > 1 ? results[i]
                .incorrectAnswers![1] : '',
            incorrectThree: results[i].incorrectAnswers!.length > 2 ? results[i]
                .incorrectAnswers![2] : '',);
          insertQuestions(questions, database);
          primaryKey++;
        }
      }
    }
  }

  static Future<List<Questions>> getQuestionsFromDatabase(Database database, int offSet) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('questions', limit: 10, offset: offSet);

    return List.generate(maps.length, (i) {
      return Questions(
        id: maps[i]['id'],
        category: maps[i]['category'],
        type: maps[i]['type'],
        difficulty: maps[i]['difficulty'],
        question: maps[i]['question'],
        correctAnswer: maps[i]['correctAnswer'],
        incorrectOne: maps[i]['incorrectone'],
        incorrectTwo: maps[i]['incorrecttwo'],
        incorrectThree: maps[i]['incorrectthree'],
      );
    });
  }
}