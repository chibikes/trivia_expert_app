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
      add(QuestionsFetched());
    }

    else if(event is UpdateOffset) {
      yield await _updateOffset(event.offset);
      add(QuestionsFetched());
    }
    else if(event is FetchingQuestions) {
      yield state.copyWith(status: QuestionStatus.inProgress);
    }
  }

  Future<QuestionState> _mapQuestionFetchedToState(
      QuestionState state) async {
    try {
        List<String> answers = [];

        final questions = await _fetchQuestions();
        for (Questions question in questions) {
          answers = question.answers!;
          answers.add(question.correctAnswer!);
          answers.shuffle();
          answers.removeWhere((element) => element.isEmpty);
          question.copyWith(answers: answers);
        }

        return state.copyWith(
            status: QuestionStatus.success,
            questions: questions,
            hasReachedMax: _hasReachedMax(questions.length));

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
        await _questionRepository.fetchQuestions(state.offset, state.limit);

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
    await prefs.then((value) => offset = value.getInt('offset'));
    return state.copyWith(offset: offset ?? state.offset);
  }


  Future<QuestionState> _updateOffset(int offset)  async {
    //TODO : check to see inProgress should be emitting
    await prefs.then((value) => value.setInt('offset', offset));
    return state.copyWith(offset: offset, status: QuestionStatus.inProgress);
  }
}
