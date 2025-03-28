import 'package:flutter/material.dart';
import 'package:game_on/view/home/casino/fun_target/Constant/color.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichText extends StatelessWidget {
  final List<CustomTextSpan> textSpans;
  final TextAlign? textAlign;
  final void Function()? onTap;

  const CustomRichText(
      {super.key, required this.textSpans, this.textAlign, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [];

    for (CustomTextSpan span in textSpans) {
      children.add(
        TextSpan(
            text: span.text,
            style: GoogleFonts.ptSerif(
              textStyle: TextStyle(
                  //15
                  fontSize:
                      span.fontSize ?? MediaQuery.of(context).size.width / 65,
                  fontWeight: span.fontWeight ?? FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: span.textColor ?? ColorConstant.darkBlackColor,
                  overflow: TextOverflow.ellipsis,
                  height: 1.5),
            )),
      );
    }

    return InkWell(
      onTap: onTap,
      child: RichText(
        textAlign: textAlign == null ? TextAlign.left : textAlign!,
        text: TextSpan(children: children),
      ),
    );
  }
}

class CustomTextSpan {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  CustomTextSpan({
    required this.text,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });
}
