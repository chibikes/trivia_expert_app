part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchQuestions extends QuestionEvent {}

class CategoryEvent extends QuestionEvent {
  final String category;

  CategoryEvent(this.category);
}

class FetchingQuestions extends QuestionEvent {}
