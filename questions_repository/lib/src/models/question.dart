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
    List<String>? incorrectAnswers = answersFromJson.cast<String>();
    return Result(
        category: parsedJson['category'],
        type: parsedJson['type'],
        difficulty: parsedJson['difficulty'],
        question: parsedJson['question']['text'],
        correctAnswer: parsedJson['correctAnswer'],
        incorrectAnswers: incorrectAnswers);
  }
}
