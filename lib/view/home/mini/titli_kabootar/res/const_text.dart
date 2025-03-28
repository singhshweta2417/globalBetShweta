import 'package:flutter/material.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_constant.dart';


class ConstText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final int? maxLine;
  final double? fontSize;
  final bool? strikethrough;
  final FontWeight? fontWeight;
  final double? wordSpacing;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Paint? foreground;
  final Color? decorationColor;
  final FontStyle? fontStyle;

  const ConstText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.maxLine,
    this.textAlign,
    this.wordSpacing,
    this.letterSpacing,
    this.decoration,
    this.strikethrough,
    this.foreground,
    this.fontFamily,
    this.decorationColor, this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: fontSize ?? AppConstant.fontSizeTwo,
        fontWeight: fontWeight ?? AppConstant.medium,
        color: color ?? AppColors.white,
        wordSpacing: wordSpacing,
        foreground: foreground,
        fontStyle:fontStyle ,
        letterSpacing: letterSpacing,
        decoration: decoration,
        decorationColor: decorationColor,
        fontFamily: fontFamily ?? 'Inter',
        overflow: maxLine != null ? TextOverflow.ellipsis : null,
      ),
    );
  }
}

// Generalized Text Widget
Widget smallElement({
  required String text,
  Color color = AppColors.white,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: fontWeight ?? AppConstant.medium,
      fontSize: fontSize ?? AppConstant.fontSizeZero,
      fontFamily: 'Inter',
    ),
  );
}

Widget elementsBold({
  required String text,
  Color color = AppColors.white,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.bold,
      fontSize: fontSize ?? AppConstant.fontSizeOne,
      fontFamily: 'InterBold',
    ),
  );
}

Widget elementsMedium({
  required String text,
  Color color = AppColors.white,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.semiBold,
      fontSize: fontSize ?? AppConstant.fontSizeOne,
      fontFamily: "Inter",
    ),
  );
}

Widget elementsSmall({
  required String text,
  Color color = AppColors.white,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.medium,
      fontSize: fontSize ?? AppConstant.fontSizeOne,
      fontFamily: 'Inter',
    ),
  );
}

Widget titleBold({
  required String text,
  Color color = AppColors.black,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.bold,
      fontSize: fontSize ?? AppConstant.fontSizeThree,
      fontFamily: 'InterBold',
    ),
  );
}

Widget titleMedium({
  required String text,
  Color color = AppColors.black,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.semiBold,
      fontSize: fontSize ?? AppConstant.fontSizeThree,
      fontFamily: "Inter",
    ),
  );
}

Widget titleSmall({
  required String text,
  Color color = AppColors.black,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.regular,
      fontSize: fontSize ?? AppConstant.fontSizeThree,
      fontFamily: "Inter",
    ),
  );
}

Widget headingBold({
  required String text,
  Color color = AppColors.black,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.bold,
      fontSize: fontSize ?? AppConstant.fontSizeLarge,
      fontFamily: 'InterBold',
    ),
  );
}

Widget headingMedium({
  required String text,
  Color color = AppColors.black,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.semiBold,
      fontSize: fontSize ?? AppConstant.fontSizeLarge,
      fontFamily: "Inter",
    ),
  );
}

Widget headingSmall({
  required String text,
  Color color = AppColors.black,
  TextAlign textAlign = TextAlign.start,
  bool strikethrough = false,
  int? maxLines,
  double? fontSize,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontWeight: AppConstant.medium,
      fontSize: fontSize ?? AppConstant.fontSizeLarge,
      fontFamily: 'Inter',
    ),
  );
}

Widget lineThroughText({
  required String text,
  Color color = AppColors.black,
  double? fontSize,
}) {
  return ConstText(
    text: text,
    decoration: TextDecoration.lineThrough,
    color: color,
    fontSize: fontSize ?? AppConstant.fontSizeOne,
    decorationColor: color,
  );
}
class ConstRichText extends StatelessWidget {
  final String firstText;
  final TextStyle? firstTextStyle;
  final String secondText;
  final TextStyle? secondTextStyle;
  final String? thirdText;
  final TextStyle? thirdTextStyle;

  const ConstRichText({
    super.key,
    required this.firstText,
    this.firstTextStyle,
    required this.secondText,
    this.secondTextStyle,
    this.thirdText,
    this.thirdTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: firstTextStyle ??  TextStyle(color: AppColors.black, fontSize:AppConstant.fontSizeTwo,fontWeight: AppConstant.medium,fontFamily: 'Inter',overflow: TextOverflow.ellipsis),
          ),
          TextSpan(
            text: secondText,
            style: secondTextStyle ??  TextStyle(color: AppColors.black,fontSize:AppConstant.fontSizeTwo, fontWeight: AppConstant.semiBold,fontFamily: 'Inter',overflow: TextOverflow.ellipsis),
          ),
          TextSpan(
            text: thirdText,
            style: thirdTextStyle ??  TextStyle(color: Colors.red, fontSize: AppConstant.fontSizeTwo, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
