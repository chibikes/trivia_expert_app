import 'package:equatable/equatable.dart';
class Trivia extends Equatable {

  Trivia({
    this.difficulty,
    this.question,
    this.correct_answer,
    this.incorrect_answers,
    this.url_picture
  });
  final String? difficulty;
  final String? question;
  final String? correct_answer;
  final List<String>? incorrect_answers;
  final String? url_picture;

  @override
  List<Object?> get props => [difficulty, question,correct_answer];
}