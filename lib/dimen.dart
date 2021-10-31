import 'package:flutter/material.dart';
class Dimen {
  // /// dimension for long buttons
  // static double longButtonWidth = 0.80 * screenWidth(context);
  // static double longButtonHeight;
  //
  // /// dimension for short buttons
  // static double shortButtonWidth;
  // static double shortButtonHeight;

  static double screenHeight (BuildContext context) {return MediaQuery.of(context).size.height;}
  static double screenWidth (BuildContext context) {return MediaQuery.of(context).size.height;}


}