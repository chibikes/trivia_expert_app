import '../src/models/questions.dart';
abstract class QuestionRepository {
  Future <List<Question>> fetchQuestions();
}