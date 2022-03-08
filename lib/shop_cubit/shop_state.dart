import 'package:equatable/equatable.dart';

class ShopState extends Equatable {
  final int blueCrystals;
  final int redCrystals;
  final int rightAnswers;

  ShopState({this.blueCrystals = 0, this.redCrystals = 0, this.rightAnswers = 0});

  ShopState copyWith({int? blueDiamonds, int? redDiamonds, int? rightAnswers}) {
    return ShopState(
      blueCrystals: blueDiamonds ?? this.blueCrystals,
      redCrystals: redDiamonds ?? this.redCrystals,
      rightAnswers: rightAnswers ?? this.rightAnswers,
    );
}
  @override
  List<Object?> get props => [blueCrystals, redCrystals, rightAnswers];

}