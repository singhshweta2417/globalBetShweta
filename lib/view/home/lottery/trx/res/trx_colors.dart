import 'package:flutter/material.dart';

class TrxColors {
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const marronBlack = Color(0xFF150102);
  static const lighterMaroon = Color(0xFF3c0000);
  static const lightMarron = Color(0xFF770002);
  static const darkYellow = Color(0xFFfec925);
  static const darkColor = Color(0xfff6f7ff);
  static const btnColor = Color(0xFF757ba6);
  static const goldenColor = Color(0xffedc100);
  static const firstColor = Color(0xFF2b3270);

  static const LinearGradient transparentGradient = LinearGradient(
    colors: [Colors.transparent, Colors.transparent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient loginSecondaryGrad = LinearGradient(
      colors: [Color(0xFF000000), Color(0xFF3f3f3f)],
      tileMode: TileMode.mirror,
      begin: Alignment.centerRight,
      end: Alignment.topCenter);

  static const LinearGradient loginSecondaryGrid = LinearGradient(
    colors: [Colors.grey, Colors.grey],
  );

  static LinearGradient goldenGradientDir = const LinearGradient(colors: [
    Color.fromARGB(255, 250, 229, 159),
    Color.fromARGB(255, 196, 147, 63),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
