import 'package:bloc/bloc.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
part 'question_event.dart';
part 'question_state.dart';
class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final http.Client httpClient;

  QuestionBloc({@required this.httpClient}) : super(const QuestionState());



  @override
  Stream<Transition<QuestionEvent, QuestionState>> transformEvents(
      Stream<QuestionEvent> events,
      TransitionFunction<QuestionEvent, QuestionState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if(event is QuestionsFetched) {
      yield await _mapQuestionFetchedToState(state);
    }
  }

  Future<QuestionState>_mapQuestionFetchedToState(QuestionState state) async {
    try {
      if(state.status == QuestionStatus.initial) {
        final results = await _fetchQuestions();
        return state.copyWith(
          status: QuestionStatus.success,
          questions: results,
          hasReachedMax: _hasReachedMax(results.length)
        );
      }
      final questions = await _fetchQuestions(state.questions.length);
      return questions.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: QuestionStatus.success,
        questions: List.of(state.questions)..addAll(questions),
        hasReachedMax: _hasReachedMax(questions.length),
      );

    } on Exception {
      return state.copyWith(status: QuestionStatus.failure);
    }
  }

  Future<List<Result>>_fetchQuestions([int startIndex = 0]) async {
    final response = await httpClient.get(
      'https://opentdb.com/api.php?amount=10',
    );

    if(response.statusCode == 200) {
      final body = json.decode(response.body);
      Question question = Question.fromJson(body);
      List<Result> results = question.results;
      return results;
    }
    throw Exception('error fetching questions');

  }

  bool _hasReachedMax(int postCount) => false;


}