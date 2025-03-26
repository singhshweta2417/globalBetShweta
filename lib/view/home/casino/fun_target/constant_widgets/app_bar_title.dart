import 'package:flutter/material.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/color.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingOne extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final TextAlign? textAlign;
  const HeadingOne(
      {super.key,
      this.title,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.width,
      this.padding,
      this.alignment,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      alignment: alignment ?? Alignment.centerLeft,
      child: Text(
        title == null ? "" : title!,
        style: GoogleFonts.ptSans(
          textStyle: TextStyle(
              fontSize: fontSize ?? 22,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontStyle: FontStyle.normal,
              color: textColor ?? ColorConstant.whiteColor),
        ),
        textAlign: textAlign,
      ),
    );
  }
}
