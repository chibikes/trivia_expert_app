import 'package:equatable/equatable.dart';

class Question extends Equatable {

  final int? responseCode;
  final List<Result>? results;

  Question({
    this.responseCode,
    this.results
  });

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    List<Result> results = list.map((e) => Result.fromJson(e)).toList();
    return Question(responseCode: parsedJson['response_code'], results: results);
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

  Result({
    this.category, this.type, this.difficulty, this.question, this.correctAnswer, this.incorrectAnswers
  });

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    var answersFromJson = parsedJson['incorrect_answers'];
    List<String>? incorrectAnswers = answersFromJson.cast<String>();
    return Result(
      category: parsedJson['category'],
      type: parsedJson['type'],
      difficulty: parsedJson['difficulty'],
      question: parsedJson['question'],
      correctAnswer: parsedJson['correct_answer'],
      incorrectAnswers: incorrectAnswers
    );
  }

}