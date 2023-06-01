part of 'question_bloc.dart';

enum QuestionStatus { inProgress, success, failure }

class QuestionState extends Equatable {
  final QuestionStatus status;
  final List<Questions> questions;
  final bool hasReachedMax;
  final int offset;
  final int limit;
  final String category;

  const QuestionState({
    this.limit = databaseLimit,
    this.offset = 0,
    this.status = QuestionStatus.inProgress,
    this.questions = const <Questions>[],
    this.hasReachedMax = false,
    this.category = 'General',
  });

  QuestionState copyWith(
      {QuestionStatus? status,
      List<Questions>? questions,
      bool? hasReachedMax,
      int? offset,
      int? limit,
      String? category}) {
    return QuestionState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props =>
      [status, questions, hasReachedMax, offset, limit, category];
}
