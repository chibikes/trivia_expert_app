import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/main_models/questions.dart';
import 'package:questions_repository/questions_repository.dart';
part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final prefs = SharedPreferences.getInstance();

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
      yield await _mapQuestionFetchedToState(state);
    }
    else if(event is RetrieveOffset) {
      yield await _retrieveOffset();
    }
    else if(event is SaveOffset) {
      await _saveOffset();
    }
    else if(event is UpdateOffset) {
      _updateOffset(event.offset);
    }
  }

  Future<QuestionState> _mapQuestionFetchedToState(
      QuestionState state) async {
    add(RetrieveOffset());
    try {
      if (state.status == QuestionStatus.initial) {
        List<String> answers = [];
        final questions = await _fetchQuestions();
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
      final questions = await _fetchQuestions();
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

  Future<List<Questions>> _fetchQuestions() async {
    List<Questions> questions = await retrieveQuestionsFromDatabase();
    return questions;
  }

  bool _hasReachedMax(int postCount) =>
      false; // TODO: delete hasREachedmax
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

  Future<QuestionState> _retrieveOffset() async {
    int? offset;
    prefs.then((value) => offset = value.getInt('offset'));
    return state.copyWith(offset: offset ?? state.offset);
  }

  Future<void> _saveOffset() async {
    return prefs.then((value) => value.setInt('offset', state.offset));
  }

  Stream<void> _updateOffset(int offset) async* {
    yield state.copyWith(offset: offset);
    add(QuestionsFetched());
  }
}
