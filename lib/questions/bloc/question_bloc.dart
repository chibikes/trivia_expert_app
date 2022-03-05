import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trivia_expert_app/main_models/questions.dart';
import 'package:trivia_expert_app/mock_questions.dart';
import 'package:trivia_expert_app/questions/databaase_operations.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:questions_repository/questions_repository.dart';
import 'package:path/path.dart';
import 'package:trivia_expert_app/questions/models/trivia.dart';
part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  //TODO: rename class to GameBloc. it should have game failure and game success as statuses

  QuestionBloc({required QuestionRepository questionRepository})
      : _questionRepository = questionRepository,
        super(const QuestionState());

  final QuestionRepository _questionRepository;

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
    if (event is QuestionsFetched) {
      yield await _mapQuestionFetchedToState(state, QuestionsFetched.offSet);
    }
  }

  Future<QuestionState> _mapQuestionFetchedToState(
      QuestionState state, int offSet) async {
    try {
      if (state.status == QuestionStatus.initial) {
        List<String> answers = [];
        final questions = await _fetchQuestions(offSet);
        for (Questions question in questions) {
          answers = question.answers!;
          answers.add(question.correctAnswer!);
          answers.shuffle();
          question.copyWith(answers: answers);
        }

        return state.copyWith(
            status: QuestionStatus.success,
            questions: questions,
            hasReachedMax: _hasReachedMax(questions.length));
      }
      final questions = await _fetchQuestions(offSet);
      return questions.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: QuestionStatus.success,
              questions: List.of(state.questions)..addAll(questions),
              hasReachedMax: _hasReachedMax(questions.length),
            );
    } on Exception catch (e) {
      print('error: $e');
      return state.copyWith(status: QuestionStatus.failure);
    }
  }

  Future<List<Questions>> _fetchQuestions(int offSet) async {
    Future<List<Questions>> questions = retrieveQuestionsFromDatabase();
    return questions;
  }

  bool _hasReachedMax(int postCount) =>
      false; // TODO: if has reached max ? q = 0
  Future<List<Questions>> retrieveQuestionsFromDatabase() async {
    List<TriviaQuestion> triviaQuestions =
        await _questionRepository.fetchQuestions(state.offset);

    return List.generate(
      triviaQuestions.length,
      (index) => Questions(
          id: triviaQuestions[index].id,
          type: triviaQuestions[index].type,
          category: triviaQuestions[index].category,
          difficulty: triviaQuestions[index].difficulty,
          question: triviaQuestions[index].question,
          correctAnswer: triviaQuestions[index].correctAnswer,
          answers: [
            triviaQuestions[index].incorrectOne!,
            triviaQuestions[index].incorrectTwo!,
            triviaQuestions[index].incorrectThree!
          ]),
    );
  }
}
