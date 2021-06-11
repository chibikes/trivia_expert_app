part of 'question_bloc.dart';

enum QuestionStatus{initial, success, failure}
class QuestionState extends Equatable {

  final QuestionStatus status;
  final List<Questions> questions;
  final bool hasReachedMax;

  const QuestionState({
    this.status = QuestionStatus.initial,
    this.questions = const <Questions>[],
    this.hasReachedMax = false,

  });

  QuestionState copyWith({
    QuestionStatus status,
    List<String> answers,
    List<Questions> questions,
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