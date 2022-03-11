import 'package:equatable/equatable.dart';
import 'package:trivia_expert_app/main_models/purchase_product.dart';

enum ShopStatus{available, loading, unavailable}
class ShopState extends Equatable {
  final int blueCrystals;
  final int redCrystals;
  final int rightAnswers;
  final ShopStatus shopStatus;
  final Map<String, PurchasableProduct> products;


  ShopState({this.shopStatus = ShopStatus.unavailable, this.blueCrystals = 0, this.redCrystals = 0, this.rightAnswers = 0, this.products = const{}});

  ShopState copyWith({int? blueCrystals, int? redDiamonds, int? rightAnswers, Map<String, PurchasableProduct>? products, ShopStatus? shopStatus}) {
    return ShopState(
      blueCrystals: blueCrystals ?? this.blueCrystals,
      redCrystals: redDiamonds ?? this.redCrystals,
      rightAnswers: rightAnswers ?? this.rightAnswers,
      products: products ?? this.products,
      shopStatus: shopStatus ?? this.shopStatus,
    );
}
  @override
  List<Object?> get props => [blueCrystals, redCrystals, rightAnswers, products, shopStatus];

}