import 'package:flutter/material.dart';
import 'package:globalbet/view/home/casino/fun_target/Constant/color.dart';
import 'package:google_fonts/google_fonts.dart';


class SubTitleText extends StatelessWidget {
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
  const SubTitleText(
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
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      alignment: alignment ?? Alignment.center,
      child: Text(
          maxLines: maxLines,
          overflow: overflow,
          softWrap: softWrap,
          textAlign: textAlign,
          title == null ? "" : title!,
          style: GoogleFonts.ptSerif(
              textStyle: TextStyle(
            //15
            fontSize: fontSize ?? MediaQuery.of(context).size.width / 45,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontStyle: FontStyle.normal,
            color: textColor ?? ColorConstant.darkBlackColor,
          ))),
    );
  }
}
