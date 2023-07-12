part of 'question_bloc.dart';

enum QuestionStatus { inProgress, success, failure }

enum QuestionType { text, image }

class QuestionState extends Equatable {
  final QuestionStatus status;
  final List<Questions> questions;
  final bool hasReachedMax;
  final int offset;
  final int limit;
  final String category;
  final QuestionType type;

  const QuestionState({
    this.limit = databaseLimit,
    this.offset = 0,
    this.type = QuestionType.text,
    this.status = QuestionStatus.inProgress,
    this.questions = const <Questions>[],
    this.hasReachedMax = false,
    this.category = 'General',
  });

  QuestionState copyWith({
    QuestionStatus? status,
    List<Questions>? questions,
    bool? hasReachedMax,
    int? offset,
    int? limit,
    String? category,
    QuestionType? type,
  }) {
    return QuestionState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      category: category ?? this.category,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props =>
      [status, questions, hasReachedMax, offset, limit, category, type];
}
