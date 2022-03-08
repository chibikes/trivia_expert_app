import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';
import 'package:trivia_expert_app/widgets/crystal_page_card.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(ShopState initialState) : super(initialState);
  final prefs = SharedPreferences.getInstance();

  void buyBlueDiamonds(int noOfItems, double price) {
    try {
      emit(state.copyWith(blueDiamonds: state.blueCrystals + noOfItems));
    } catch(e) {

    }
  }

  void buyRedDiamonds(int noOfItems, double price) {
    try {
      emit(state.copyWith(redDiamonds: state.redCrystals + noOfItems));
    } catch(e) {

    }
  }
  void buyItem(int noOfItems, double price, ItemType itemType) {
    try {
      if(itemType == ItemType.blueCrystal) {
        //TODO: save to cloud and local storage
        emit(state.copyWith(blueDiamonds: noOfItems));
      }
    } on PlatformException catch(e) {

      print('$e');
    }
  }

  void buyRightAnswers(int noOfItems, double price) {
    emit(state.copyWith(rightAnswers: state.rightAnswers + noOfItems));
  }
}