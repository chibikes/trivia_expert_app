part of 'question_bloc.dart';

enum QuestionStatus{initial, success, failure}
class QuestionState extends Equatable {

  final QuestionStatus status;
  final List<Questions> questions;
  final bool hasReachedMax;
  final int offset;

  const QuestionState({
    this.offset = 0,
    this.status = QuestionStatus.initial,
    this.questions = const <Questions>[],
    this.hasReachedMax = false,

  });

  QuestionState copyWith({
    QuestionStatus? status,
    List<Questions>? questions,
    bool? hasReachedMax,
    int? offset,
  }) {
    return QuestionState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object> get props => [status, questions, hasReachedMax, offset];



}