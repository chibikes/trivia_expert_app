import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_platform_interface/src/types/purchase_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/in_app_payment.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/crystal_page_card.dart';
import '../main_models/purchase_product.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(ShopState initialState) : super(initialState);
  final prefs = SharedPreferences.getInstance();
  final inAppPaymentInstance = InAppPayment.instance;
  StreamSubscription? _purchasesSubscription;
  List<PurchasableProduct> products = [

  ];

  void initPayment() {
    final purchaseUpdated = inAppPaymentInstance.purchaseStream;
    _purchasesSubscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }

  Future<void> loadPurchases() async{
    final available = await inAppPaymentInstance.isAvailable();
    if (!available) {
      return;
    }

    const ids = <String>{
      redCrystalConsumable,
      blueCrystalConsumable,
      rightAnswerConsumable,
    };
    final response = await inAppPaymentInstance.queryProductDetails(ids);
    products = response.productDetails.map((e) => PurchasableProduct(e)).toList();
    var map;
    response.productDetails.map((e) {
      map.putIfAbsent(e.id, () => PurchasableProduct(e));
    });

    emit(state.copyWith(products: map));
  }

  Future<void> buy(PurchasableProduct product) async {
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case blueCrystalConsumable:
        await inAppPaymentInstance.buyConsumable(purchaseParam: purchaseParam);
        break;
      case redCrystalConsumable:
        await inAppPaymentInstance.buyConsumable(purchaseParam: purchaseParam);
        break;
      case rightAnswerConsumable:
        await inAppPaymentInstance.buyNonConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  void buyItem(int noOfItems, ItemType itemType, PurchasableProduct? product) {
    try {
      if(itemType == ItemType.blueCrystal) {
        buy(product!);
        //TODO: save to cloud and local storage
        //TODO: handle case for correct purchase or failed transaction
        //TODO: create repository for purchase details
        emit(state.copyWith(blueDiamonds: noOfItems));
      } else if (itemType == ItemType.redCrystal) {

      }
    } on PlatformException catch(e) {

      print('$e');
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> event) {
  }

  void _updateStreamOnDone() {
    _purchasesSubscription?.cancel();
  }

  void _updateStreamOnError (Object obj) {
  }
  @override
  Future<void> close() {
    return super.close();
  }
}