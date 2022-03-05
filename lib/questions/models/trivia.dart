import 'package:trivia_expert_app/questions/models/question.dart';

class Trivia {
  final List<Question> questions;

  Trivia(this.questions);

  factory Trivia.fromJson(List<dynamic> parsedJson) { /// initially list<dynamic>
    var list = parsedJson;
    List<Question> questions = [];
    questions = list.map((e) => Question.fromJson(e)).toList();
    return Trivia(questions);
  }
}