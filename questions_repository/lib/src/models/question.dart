import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int? responseCode;
  final List<Result>? results;

  Question({this.responseCode, this.results});

  factory Question.fromJson(parsedJson) {
    var list = parsedJson as List;
    List<Result> results = list.map((e) => Result.fromJson(e)).toList();
    return Question(results: results);
  }

  @override
  List<Object?> get props => [responseCode, results];
}

class Result {
  final String? category;
  final String? type;
  final String? difficulty;
  final String? question;
  final String? correctAnswer;
  final List<String>? incorrectAnswers;

  Result(
      {this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.incorrectAnswers});

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    var answersFromJson = parsedJson['incorrectAnswers'];
    var type = parsedJson['type'];

    List<String>? incorrectAnswers = [];
    if (type == 'image_choice') {
      var answerList = answersFromJson as List<dynamic>;
      for (List answer in answerList) {
        Map<String, dynamic> dy = answer[0];
        incorrectAnswers.add(answer[0]['url'] as String);
      }
    } else {
      incorrectAnswers = answersFromJson.cast<String>();
    }
    return Result(
        category: parsedJson['category'],
        type: parsedJson['type'],
        difficulty: parsedJson['difficulty'],
        question: parsedJson['question']['text'],
        correctAnswer: type == 'text_choice'
            ? parsedJson['correctAnswer']
            : parsedJson['correctAnswer'][0]['url'],
        incorrectAnswers: incorrectAnswers);
  }
}
