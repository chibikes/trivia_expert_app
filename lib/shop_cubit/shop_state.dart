import 'package:equatable/equatable.dart';

class ShopState extends Equatable {
  final int blueDiamonds;
  final int redDiamonds;
  final int rightAnswers;

  ShopState({this.blueDiamonds = 0, this.redDiamonds = 0, this.rightAnswers = 0});

  ShopState copyWith({int? blueDiamonds, int? redDiamonds, int? rightAnswers}) {
    return ShopState(
      blueDiamonds: blueDiamonds ?? this.blueDiamonds,
      redDiamonds: redDiamonds ?? this.redDiamonds,
      rightAnswers: rightAnswers ?? this.rightAnswers,
    );
}
  @override
  List<Object?> get props => [blueDiamonds, redDiamonds, rightAnswers];

}