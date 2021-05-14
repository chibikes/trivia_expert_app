part of 'question_bloc.dart';

enum QuestionStatus{initial, success, failure}
class QuestionState extends Equatable {

  final QuestionStatus status;
  final List<Result> questions;
  final bool hasReachedMax;

  const QuestionState({
    this.status = QuestionStatus.initial,
    this.questions = const <Result>[],
    this.hasReachedMax = false,

  });

  QuestionState copyWith({
    QuestionStatus status,
    List<String> answers,
    List<Result> questions,
    bool hasReachedMax,
}) {
    return QuestionState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, questions, hasReachedMax];



}