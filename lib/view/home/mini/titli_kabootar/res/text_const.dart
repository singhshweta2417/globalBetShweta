import 'package:flutter/material.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_colors.dart';


class TextConst extends StatelessWidget {
  const TextConst({
    super.key,
    this.title,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.maxLines,
    this.decoration,
    this.textAlign,
    this.textOverflow,
    this.decorationColor,
    this.letterSpacing,
  });

  final String? title;
  final Color? color;
  final Color? decorationColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxLines;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final double? letterSpacing; // Added property for spacing between letters

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        decoration: decoration,
        decorationColor: decorationColor,
        color: color ?? AppColors.black,
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? 'Poppins-Regular',
        letterSpacing: letterSpacing,
      ),
      overflow: textOverflow ?? TextOverflow.ellipsis,
    );
  }
}
