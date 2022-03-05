import 'package:sqflite/sqflite.dart';
import 'models/questions.dart';
import 'question_repository.dart';

class DatabaseQuestionsRepository extends QuestionRepository {
  final int offset;
  final Database database;

  DatabaseQuestionsRepository(this.offset, this.database);

  @override
  Future <List<Question>> fetchQuestions() async {

    final List<Map<String, dynamic>> maps = await database.query('trivia_questions', limit: 10, offset: offset);

    return List.generate(maps.length, (i) {
      return Question(
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


}