import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(MainPageState());

  void changeTabs(int value) {
    emit(state.copyWith(selectedItem: value));
  }

}