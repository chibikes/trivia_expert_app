class PowerUps {
  final int crystals;
  final int rubies;
  final int rightAnswers;

  PowerUps(this.crystals, this.rubies, this.rightAnswers);


  Map<String, dynamic> toMap(){
    return {
      // 'email' : email,
      'crystals' : crystals,
      'rubies' : rubies,
      'age' : rightAnswers,
    };
  }
}