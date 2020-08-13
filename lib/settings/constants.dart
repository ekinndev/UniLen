import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Constants {
  //SizedBox Aralıklar
  static const Widget aralikWidth10 = SizedBox(width: 10);
  static const Widget aralikWidth15 = SizedBox(width: 15);
  static const Widget aralikHeight15 = SizedBox(height: 15);
  static const Widget aralikHeight20 = SizedBox(height: 20);
  static const String apiLink = 'https://unilen-75828.firebaseio.com/';
  static const String defaultImg =
      'https://firebasestorage.googleapis.com/v0/b/unilen-75828.appspot.com/o/empty.png?alt=media&token=1db1a0a9-be49-4581-bffe-0df38347276c';
  static final Widget progressIndicator = Center(
      child: Lottie.asset(
    'assets/lottie/progress.json',
    height: 200,
    width: 200,
  ));
}
