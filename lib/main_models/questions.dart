class Questions {
  final int? id;
  final String? category;
  final String? type;
  final String? difficulty;
  final String? question;
  final String? correctAnswer;
  final List<String>? answers;
  //TODO: remove the fields below
  final String? incorrectOne;
  final String? incorrectTwo;
  final String? incorrectThree;

  Questions(
      {this.id,
      this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.answers,
      this.incorrectOne,
      this.incorrectTwo,
      this.incorrectThree
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'type': type,
      'difficulty': difficulty,
      'question': question,
      'correct_answer': correctAnswer,
      // 'answers': answers,
      'incorrect_one' : incorrectOne,
      'incorrect_two' : incorrectTwo,
      'incorrect_three' : incorrectThree,
    };
  }

  Questions copyWith({
    int? id,
    String? category,
    String? type,
    String? difficulty,
    String? question,
    String? correctAnswer,
    List<String>? answers,
  }) {
    return Questions(
      id: id ?? this.id,
      category: category ?? this.category,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      answers: answers ?? this.answers,
    );
  }
}
