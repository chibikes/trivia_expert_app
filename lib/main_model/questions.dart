class Questions {
  final int? id;
  final String? category;
  final String? type;
  final String? difficulty;
  final String? question;
  final String? correctAnswer;
  final String? incorrectOne;
  final String? incorrectTwo;
  final String? incorrectThree;

  Questions({this.id, this.category, this.type, this.difficulty, this.question, this.correctAnswer, this.incorrectOne, this.incorrectTwo, this.incorrectThree});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category' : category,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'correctAnswer': correctAnswer,
      'incorrectOne': incorrectOne,
      'incorrectTwo': incorrectTwo,
      'incorrectThree': incorrectThree,
    };
  }
}