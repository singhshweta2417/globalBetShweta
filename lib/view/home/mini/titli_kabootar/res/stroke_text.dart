import 'package:flutter/material.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color textColor;
  final Color strokeColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final TextOverflow? overflow;
  final int? maxLines;

  const StrokeText({
    super.key,
    required this.text,
    this.strokeWidth = 2,
    this.strokeColor = Colors.yellow,
    this.textColor = AppColors.golden,
    this.fontSize,
    this.fontStyle,
    this.textStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.overflow,
    this.maxLines,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle, // Added fontStyle
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ).merge(textStyle),
          textAlign: textAlign,
          textDirection: textDirection,
          textScaler: textScaler,
          overflow: overflow,
          maxLines: maxLines,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle, // Added fontStyle
          ).merge(
            textStyle,
          ),
          textAlign: textAlign,
          textDirection: textDirection,
          textScaler: textScaler,
          overflow: overflow,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
