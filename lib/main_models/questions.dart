class Questions {
  final int? id;
  final String? category;
  final String? type;
  final String? difficulty;
  final String? question;
  final String? correctAnswer;
  final List<String>? answers;

  Questions(
      {this.id,
      this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.answers,
      });


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
