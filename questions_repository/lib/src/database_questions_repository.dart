import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models/questions.dart';
import 'questions_repository.dart';

class DatabaseQuestionsRepository implements QuestionRepository {
  Database? _database;


  @override
  Future <List<TriviaQuestion>> fetchQuestions(int offset) async {
    await initDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query('trivia_questions', limit: 50, offset: offset);

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
  Future<void> initDatabase() async {
    _database =  await openDatabase(
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
}