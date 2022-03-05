part of 'question_bloc.dart';


abstract class QuestionEvent extends Equatable {
  @override

  List<Object> get props => [];

}

class QuestionsFetched extends QuestionEvent {
   static int offSet = 0;

}
class QuestionsFetchedOffline extends QuestionEvent {}