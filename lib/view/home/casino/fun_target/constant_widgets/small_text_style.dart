import 'package:flutter/material.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/color.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallText extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final double? width;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final TextStyle? style;

  const SmallText(
      {super.key,
      this.title,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.width,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.padding,
      this.alignment,
      this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      alignment: alignment ?? Alignment.center,
      child: Text(
          textScaleFactor: 1.0,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          textAlign: textAlign,
          title == null ? "" : title!,
          style: style ??
              GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    fontSize:
                        fontSize ?? MediaQuery.of(context).size.width / 50,
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: textColor ?? ColorConstant.whiteColor),
              )),
    );
  }
}
