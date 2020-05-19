import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Constants {
  //SizedBox Aralıklar
  static const Widget aralikWidth10 = SizedBox(width: 10);
  static const Widget aralikWidth15 = SizedBox(width: 15);
  static const Widget aralikHeight15 = SizedBox(height: 15);
  static const Widget aralikHeight20 = SizedBox(height: 20);

  static final Widget progressIndicator = Lottie.asset(
      'assets/lottie/progress.json',
      height: 150,
      width: 150,
      fit: BoxFit.fill,
      alignment: Alignment.center);
}
