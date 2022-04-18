import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trivia_expert_app/game/game_cubit/game_play_cubit.dart';
import 'package:trivia_expert_app/get_image.dart';
import 'package:trivia_expert_app/home/first_page/cubit/first_page_state.dart';

class FirstPageCubit extends Cubit<FirstPageState> {
  FirstPageCubit(FirstPageState initialState) : super(initialState);


  void goToPage(BuildContext context, Widget widget,
      {AnimationController? buttonController}) async{
    if(buttonController != null) await buttonController.forward().whenComplete(() => buttonController.reverse());
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
  Future<String> retrieveImage() async {
    ImageSelector imageSelector = ImageSelector();
    var imagePath = imageSelector.getImageFromGallery();
    return imagePath;
  }
}


