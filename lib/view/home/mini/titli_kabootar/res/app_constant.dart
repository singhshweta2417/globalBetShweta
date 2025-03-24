

import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';

class AppConstant{
  static String appName="Titli";
  static double get luckyBtnFont =>width < 850? 12: height*0.025;
  static double get luckyRoFont =>width < 850? 12: height*0.03;
  static double get luckyKaFont =>width < 850? 8: height*0.02;
  static double get luckyCoinFont =>width < 850? 10: height*0.03;
  static double get luckyColHi =>width < 850? height * 0.1: height * 0.08;
  static double get spinCoinFont =>width < 850? 16: height*0.03;
  static double get spinBtnFont =>width < 850? 18: height*0.035;
  static double get spinBetIdFont =>width < 850? 26: height*0.06;
  static double get spinBetAmFont =>width < 850? 14: height*0.03;
  static double get spinResFont =>width < 850? 20: height*0.045;
  static double get spinUsFont =>width < 850? 12: height*0.025;
  static double get spinWheelPosition =>width < 850? width*0.08: width*0.1;
  static double get spinErrorDPosition =>width < 850? width*0.04: width*0.008;
  static double get anBaResSize =>width < 850? height*0.06: height*0.05;
  static double get anBaTimerFont =>width < 850? 18: height*0.035;
  static double get anBaCoinConCe =>width < 850? height*0.02: height*0.03;
  static double get anBaExitFont =>width < 850? 12: height*0.025;
  static double get trChSlideConWi =>width < 850? width * 0.15: width*0.16;
  static double get trChSlidePlayIcon =>width < 850? 2.8:1.8;

  static double get fontSizeZero =>
      width < 500 ? width / 40 : width / 50;

  static double get fontSizeOne =>
      width < 500 ? width / 33 : width / 45;

  static double get fontSizeTwo =>
      width < 500 ? width / 28 : width / 38;

  static double get fontSizeThree =>
      width < 500 ? width / 23 : width / 33;

  static double get fontSizeLarge =>
      width < 500 ? width / 18 : width / 28;

  static double get fontSizeHeading =>
      width < 500 ? width / 13 : 23;


  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;



  static var  spaceWidth3 = SizedBox(width: width*0.011);
  static var  spaceWidth5 = SizedBox(width: width*0.014);
  static var spaceWidth8 = SizedBox(width: width*0.023);
  static var spaceWidth10 = SizedBox(width: width*0.028);
  static var spaceWidth12 = SizedBox(width: width*0.034);
  static var spaceWidth15 = SizedBox(width: width*0.042);
  static var spaceWidth18 = SizedBox(width: width*0.05);
  static var spaceWidth20 = SizedBox(width: width*0.058);
  static var spaceWidth23 = SizedBox(width: width*0.065);
  static var spaceWidth25 = SizedBox(width: width*0.07);

//,height=805
  static var spaceHeight3 = SizedBox(height: height*0.006);
  static var spaceHeight5 = SizedBox(height: height*0.009);
  static var spaceHeight8 = SizedBox(height: height*0.01);
  static var spaceHeight10 = SizedBox(height: height*0.013);
  static var spaceHeight12 = SizedBox(height: height*0.016);
  static var spaceHeight15 = SizedBox(height: height*0.021);
  static var spaceHeight18 = SizedBox(height: height*0.023);
  static var spaceHeight20 = SizedBox(height: height*0.025);
  static var spaceHeight23 = SizedBox(height: height*0.03);
  static var spaceHeight25 = SizedBox(height: height*0.035);
  static var spaceHeight30 = SizedBox(height: height*0.044);

}

class AppBorders {
  static const BorderRadius defaultRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius smallRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius mediumRadius = BorderRadius.all(Radius.circular(18));
  static const BorderRadius extraSmallRadius = BorderRadius.all(Radius.circular(5));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(35));
  static const BorderRadius btnRadius = BorderRadius.all(Radius.circular(25));
}


class AppPadding {
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 15,vertical: 15);
  static const EdgeInsets screenPaddingH = EdgeInsets.symmetric(horizontal: 15);
  static const EdgeInsets screenPaddingV = EdgeInsets.symmetric(vertical: 15);
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets extraSmallPadding = EdgeInsets.all(3.0);
  static const EdgeInsets mediumPadding = EdgeInsets.all(16.0);
  static const EdgeInsets largePadding = EdgeInsets.all(24.0);
}

class AppCapital {
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

}