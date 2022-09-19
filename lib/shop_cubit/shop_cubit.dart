import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_repo/in_app_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/consts.dart';
import 'package:trivia_expert_app/file_storage.dart';
import 'package:trivia_expert_app/in_app_payment.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/crystal_page_card.dart';
import '../main_models/purchase_product.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit({required InAppRepo inAppRepo}) : _inAppRepo = inAppRepo, super(ShopState());
  final prefs = SharedPreferences.getInstance();
  final inAppPaymentInstance = InAppPayment.instance;
  StreamSubscription? _purchasesSubscription;
  final InAppRepo _inAppRepo;
  List<PurchasableProduct> products = [

  ];

  void initPayment() {
    /// warning start listening to this stream. advisable to set lazyloading false
    final purchaseUpdated = inAppPaymentInstance.purchaseStream;
    _purchasesSubscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }

  Future<void> getPowerUpsFromStorage() async {
    var redC = 0;
    var blueC = 0;
    var rightA = 0;
    //TODO: save the scores to the cloud when the user exists the app (good to prevent excessive network calls)
    await FileStorage.instance.then((value) => redC = value.getInt(redCrystals) ?? state.redCrystals);
    await FileStorage.instance.then((value) => blueC = value.getInt(blueCrystals) ?? state.blueCrystals);
    await FileStorage.instance.then((value) => rightA = value.getInt(rightAnswers) ?? state.rightAnswers);

    emit(state.copyWith(blueCrystals: blueC, redCrystals: redC, rightAnswers: rightA));
  }

  Future<void> loadPurchases() async{
    final available = await inAppPaymentInstance.isAvailable();
    if (!available) {
      emit(state.copyWith(shopStatus: ShopStatus.unavailable));
      return;
    }

    const ids = <String>{
      blueCrystalConsumableFive,
      blueCrystalConsumableTen,
      blueCrystalConsumableFifteen,
      blueCrystalConsumableTwenty,
      blueCrystalConsumableTwentyFive,
      blueCrystalConsumableThirty,
    };
    final response = await inAppPaymentInstance.queryProductDetails(ids);
    products = response.productDetails.map((e) => PurchasableProduct(e)).toList();
    var map;
    response.productDetails.map((e) {
      map.putIfAbsent(e.id, () => PurchasableProduct(e));
    });

    emit(state.copyWith(products: map, shopStatus: ShopStatus.available));
  }

  Future<void> buy(PurchasableProduct product) async {
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case blueCrystalConsumableFive:
      case blueCrystalConsumableTen:
      case blueCrystalConsumableFifteen:
      case blueCrystalConsumableTwenty:
      case blueCrystalConsumableTwentyFive:
      case blueCrystalConsumableThirty:
        await inAppPaymentInstance.buyConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  void buyItem(int noOfItems, ItemType itemType, PurchasableProduct? product, int amount) {
    try {
      if(itemType == ItemType.blueCrystal) {
        buy(product!);
        //TODO: save to cloud and local storage
        //TODO: handle case for correct purchase or failed transaction
        //TODO: create repository for purchase details
        _inAppRepo.updatePurchaseDetails();
        emit(state.copyWith(blueCrystals: noOfItems, buyStatus: BuyStatus.blueCrystalBought));
      } else if (itemType == ItemType.redCrystal) {
        if(state.blueCrystals >= amount) {
          playNotif();
          emit(state.copyWith(blueCrystals: state.blueCrystals - amount, redCrystals: state.redCrystals + noOfItems, buyStatus: BuyStatus.redCrystalBought));
          FileStorage.instance.then((value) => value.setInt(redCrystals, state.redCrystals));
          FileStorage.instance.then((value) => value.setInt(blueCrystals, state.blueCrystals));

        }
      } else if (itemType == ItemType.rightAnswer) {
        if(state.blueCrystals >= amount) {
          playNotif();
          emit(state.copyWith(rightAnswers: state.rightAnswers + noOfItems, blueCrystals: state.blueCrystals - amount, buyStatus: BuyStatus.rightAnswerBought));
          FileStorage.instance.then((value) =>  value.setInt(rightAnswers, state.rightAnswers));
          FileStorage.instance.then((value) =>  value.setInt(blueCrystals, state.blueCrystals));
        }
      }
    }catch(e) {

      print('$e');
    }
  }
  void useItem(ItemType itemType, {int numberUsed = 0}) {
    switch(itemType) {
      case ItemType.rightAnswer:
        emit(state.copyWith(rightAnswers: state.rightAnswers - 1));
        FileStorage.instance.then((value) => value.setInt(rightAnswers, state.rightAnswers));
        break;
      case ItemType.redCrystal:
        emit(state.copyWith(redCrystals: numberUsed));
        FileStorage.instance.then((value) => value.setInt(redCrystals, state.redCrystals <=0 ? 0 : state.redCrystals));
        break;
      case ItemType.blueCrystal:
        break;
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(_handlePurchase);
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

  void _handlePurchase(PurchaseDetails purchaseDetails) {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      switch (purchaseDetails.productID) {
        case blueCrystalConsumableFive:
          emit(state.copyWith(blueCrystals: 5));
          break;
        case blueCrystalConsumableTen:
          emit(state.copyWith(blueCrystals: 10));
          break;
        case blueCrystalConsumableFifteen:
          emit(state.copyWith(blueCrystals: 15));
          break;
        case blueCrystalConsumableTwenty:
          emit(state.copyWith(blueCrystals: 20));
          break;
        case blueCrystalConsumableTwentyFive:
          emit(state.copyWith(blueCrystals: 25));
          break;
        case blueCrystalConsumableThirty:
          emit(state.copyWith(blueCrystals: 30));
          break;


      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      inAppPaymentInstance.completePurchase(purchaseDetails);
    }
  }

  void playNotif() {
    final audioPlayer = AudioCache();
    audioPlayer.play('high_score.mp3', mode: PlayerMode.LOW_LATENCY);
  }
}