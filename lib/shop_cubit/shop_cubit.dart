import 'package:bloc/bloc.dart';
import 'package:trivia_expert_app/shop_cubit/shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit(ShopState initialState) : super(initialState);

  void buyBlueDiamonds(int noOfItems, double price) {
    try {
      emit(state.copyWith(blueDiamonds: state.blueDiamonds + noOfItems));
    } catch(e) {

    }
  }

  void buyRedDiamonds(int noOfItems, double price) {
    try {
      emit(state.copyWith(redDiamonds: state.redDiamonds + noOfItems));
    } catch(e) {

    }
  }

  void buyRightAnswers(int noOfItems, double price) {
    emit(state.copyWith(rightAnswers: state.rightAnswers + noOfItems));
  }
}