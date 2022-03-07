import 'models/questions.dart';
abstract class QuestionRepository {
  Future <List<TriviaQuestion>> fetchQuestions(int offset, int limit);
}