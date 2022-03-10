import 'package:equatable/equatable.dart';
import 'package:trivia_expert_app/main_models/purchase_product.dart';

class ShopState extends Equatable {
  final int blueCrystals;
  final int redCrystals;
  final int rightAnswers;
  final Map<String, PurchasableProduct> products;


  ShopState({this.blueCrystals = 0, this.redCrystals = 0, this.rightAnswers = 0, this.products = const{}});

  ShopState copyWith({int? blueDiamonds, int? redDiamonds, int? rightAnswers, Map<String, PurchasableProduct>? products}) {
    return ShopState(
      blueCrystals: blueDiamonds ?? this.blueCrystals,
      redCrystals: redDiamonds ?? this.redCrystals,
      rightAnswers: rightAnswers ?? this.rightAnswers,
      products: products ?? this.products,
    );
}
  @override
  List<Object?> get props => [blueCrystals, redCrystals, rightAnswers, products];

}