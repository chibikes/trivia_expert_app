import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trivia_expert_app/main_model/questions.dart';
import 'package:trivia_expert_app/mock_questions.dart';
import 'package:trivia_expert_app/questions/databaase_operations.dart';
import 'package:trivia_expert_app/questions/models/question.dart';
import 'package:path/path.dart';
part 'question_event.dart';
part 'question_state.dart';
class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {


  QuestionBloc() : super(const QuestionState());



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
      yield await _mapQuestionFetchedToState(state, QuestionsFetched.offSet);
    }
  }

  Future<QuestionState>_mapQuestionFetchedToState(QuestionState state, int offSet) async {
    try {
      if(state.status == QuestionStatus.initial) {
        List<List<String>> answers = [];
        final questions = await _fetchQuestions(offSet);
        int i = 0;
        for(Questions question in questions) {
          answers.add([question.correctAnswer!,
            question.incorrectOne!,
            question.incorrectTwo!,
            question.incorrectThree!,]
          );
          answers[i].shuffle();
          i++;
        }
        return state.copyWith(
            status: QuestionStatus.success,
            questions: questions,
            answers: answers,
            hasReachedMax: _hasReachedMax(questions.length)
        );
      }
      final questions = await _fetchQuestions(offSet);
      return questions.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: QuestionStatus.success,
        questions: List.of(state.questions)..addAll(questions),
        hasReachedMax: _hasReachedMax(questions.length),
      );

    } on Exception catch(e) {
      print('error: $e');
      return state.copyWith(status: QuestionStatus.failure);
    }
  }
  // Future<List<Result>> parseTrivia(String jsonBody) async {
  //
  // }

  Future<List<Questions>>_fetchQuestions(int offSet) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'trivia_ex.datbase'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE questions(id INTEGER PRIMARY KEY, category TEXT, type TEXT, difficulty TEXT, question TEXT, '
              'correctAnswer TEXT, incorrectone TEXT, incorrecttwo TEXT, incorrectthree TEXT)',
        );
      },
      version: 1,
    );

    // Future<List<Questions>> questions = DatabaseOperations.getQuestionsFromDatabase(await database, offSet);
    Future<List<Questions>> questions = MockQuestions.getMockQuestions();
    return questions;
  }

  bool _hasReachedMax(int postCount) => false; // TODO: if has reached max ? q = 0




}
