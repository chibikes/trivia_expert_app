import 'main_model/questions.dart';

class MockQuestions {
  static Future<List<Questions>> getMockQuestions() async {
    List<Questions> questions = [];
    for (int i=0;i< 100; i++) {
      var question = Questions(
        id:i, category: 'Science',
        difficulty: i % 2 ==0 ? 'hard': 'false',
        question: i % 2 ==0 ? ' who framed roger rabbit' : 'Who kill \'em jenkins brothers',
        correctAnswer: 'The rabbit',
        incorrectOne: 'No body',
        incorrectTwo: 'The Sheriff?',
        incorrectThree: 'No man on earth');
      questions.add(question);
    }
    return questions;
  }
}