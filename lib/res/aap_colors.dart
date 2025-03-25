import 'package:flutter/material.dart';

class AppColors {
  static const unSelectColor = Color(0xFF9E9E9E);
  static const contSelectColor = Color(0xFF3f3f3f);
  static const contLightColor = Color(0xFF616161);
  static const black12 = Color(0x1F000000);
  static const greyColor = Color(0xFFBDBDBD);
  static const orangeColor = Color(0xFFf15b20);
  static const btnColor = Color(0xFF757ba6);
  static const constColor = Color(0xFF759fde);
  static const vip1 = Color(0xFFa3b5cf);
  static const vip2 = Color(0xFFe8a460);
  static const vip3 = Color(0xFFff8781);
  static const vip4 = Color(0xFF5ad1f3);
  static const vip5 = Color(0xFFf18ddf);
  static const vip6 = Color(0xFF33b57e);
  static const vip7 = Color(0xFF38aa57);
  static const vip8 = Color(0xFF458bed);
  static const vip9 = Color(0xFFa05afd);
  static const vip10 = Color(0xFFfb9c3d);
  static const vipColor3 = Color(0xFFf05c5c);
  static const vipColor1 = Color(0xFFf05c5c);
  static const vipColor2 = Color(0xFFf05c5c);
  static const vipColor4 = Color(0xFF31b5e8);
  static const vipColor5 = Color(0xFFe764c7);
  static const vipColor6 = Color(0xFF1db08a);
  static const vipColor7 = Color(0xFF1a9357);
  static const vipColor8 = Color(0xFF326fe5);
  static const vipColor9 = Color(0xFF7a32f2);
  static const vipColor10 = Color(0xFFef7b27);
  static const dividerColor = Color(0xFFa6a6a6);
  static const primaryContColor = Color(0xFFFFFFFF);
  static const containerBgColor = Color(0xFF446ccc);
  static const textBlack = Colors.black;
  static const firstColor = Color(0xFF2b3270);
  static const methodBlue = Color(0xff598ff9);
  static const goldenColor = Color(0xffedc100);
  static const goldenColorThree = Color.fromARGB(255, 250, 229, 159);
  static const darkColor = Color(0xFF3f3f3f);
  static const brownTextPrimary = Color(0xff8f5206);

  ///
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const primaryColor = Color(0xff731d1d);
  static const goldColor = Color(0xFFfead02);
  static const green = Colors.green;
  static const red = Colors.red;

  static const btnTextColor = Color(0xFF44260D);

  static const first2Color = Color(0xFF3f508e);
  static const btn2Color = Color(0xFF4f69a7);

//andarBahar
  static const textColor1 = Color(0xff9b797f);
  static const textColor2 = Color(0xffa88847);
  static const textColor3 = Color(0xff430c10);
  static const textColor4 = Color(0xff804a5d);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0x61000000), Color(0xFF3f3f3f)],
  );

  ///
  static const LinearGradient loginSecondaryGrad = LinearGradient(
      colors: [Color(0xFF000000), Color(0xFF3f3f3f)],
      tileMode: TileMode.mirror,
      begin: Alignment.centerRight,
      end: Alignment.topCenter);

  ///
  static const LinearGradient bgGrad = LinearGradient(
      colors: [Color(0xFF000000), Color(0xFF3f3f3f)],
      tileMode: TileMode.repeated,
      begin: Alignment.centerRight,
      end: Alignment.topCenter);

  ///
  static const LinearGradient contGrad = LinearGradient(
      colors: [Color(0x8A000000), Color(0x1F000000), Color(0xFF000000)],
      tileMode: TileMode.decal,
      begin: Alignment.centerRight,
      end: Alignment.topCenter);
  static const LinearGradient unSelectedColor = LinearGradient(
      colors: [Color(0xFF3f3f3f), Color(0xFF757575)],
      tileMode: TileMode.mirror,
      begin: Alignment.centerRight,
      end: Alignment.topCenter);
  static const LinearGradient lightGradColor = LinearGradient(
      colors: [Color(0x73000000), Color(0xFF757575)],
      tileMode: TileMode.mirror,
      begin: Alignment.centerRight,
      end: Alignment.topCenter);

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF22275b), Color(0xFF22275b)],
  );
  static LinearGradient goldenGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 250, 229, 159),
      Color.fromARGB(255, 196, 147, 63),
    ],
  );

  static LinearGradient transparentGradient = const LinearGradient(
    colors: [
      Colors.transparent,
      Colors.transparent,
    ],
  );
  static LinearGradient greenButtonGrad = const LinearGradient(
    colors: [
      Colors.green,
      Colors.green,
    ],
  );
  static LinearGradient redButton = const LinearGradient(
    colors: [
      Colors.red,
      Colors.red,
    ],
  );

  static LinearGradient goldenGradientDir = const LinearGradient(colors: [
    Color.fromARGB(255, 250, 229, 159),
    Color.fromARGB(255, 196, 147, 63),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static const LinearGradient primaryAppbarGrey = LinearGradient(
    colors: [
      Color(0xff727683),
      Color(0xffa5a6b1),
    ],
  );
  static const LinearGradient secondaryAppbar = LinearGradient(
    colors: [Color(0xFF3f3f3f), Color(0xFF3f3f3f)],
  );

  static const LinearGradient whiteGradient = LinearGradient(
    colors: [AppColors.whiteColor, AppColors.whiteColor],
  );
}
