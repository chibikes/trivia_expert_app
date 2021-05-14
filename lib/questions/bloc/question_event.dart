part of 'question_bloc.dart';


abstract class QuestionEvent extends Equatable {
  @override

  List<Object> get props => [];

}

class QuestionsFetched extends QuestionEvent {}
class QuestionsFetchedOffline extends QuestionEvent {}