part of 'question_bloc.dart';

enum QuestionStatus{initial, success, failure}
class QuestionState extends Equatable {

  final QuestionStatus status;
  final List<Questions> questions;
  final List<List<String>> answers;
  final bool hasReachedMax;

  const QuestionState({
    this.status = QuestionStatus.initial,
    this.questions = const <Questions>[],
    this.answers = const <List<String>>[],
    this.hasReachedMax = false,

  });

  QuestionState copyWith({
    QuestionStatus? status,
    List<List<String>>? answers,
    List<Questions>? questions,
    bool? hasReachedMax,
  }) {
    return QuestionState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, questions, answers, hasReachedMax];



}