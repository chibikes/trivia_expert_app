class PowerUps {
  final String id;
  final int crystals;
  final int rubies;
  final int rightAnswers;

  PowerUps(this.id, this.crystals, this.rubies, this.rightAnswers);


  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'crystals' : crystals,
      'rubies' : rubies,
      'age' : rightAnswers,
    };
  }
}