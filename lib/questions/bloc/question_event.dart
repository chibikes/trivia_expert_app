part of 'question_bloc.dart';


abstract class QuestionEvent extends Equatable {
  @override

  List<Object> get props => [];

}

class QuestionsFetched extends QuestionEvent {


}
class RetrieveOffset extends QuestionEvent {

}


class UpdateOffset extends QuestionEvent {
  final int offset;

  UpdateOffset(this.offset);
}

class FetchingQuestions extends QuestionEvent {

}