import 'package:flutter/material.dart';
import 'package:game_on/view/home/casino/fun_target/Constant/color.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButton extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;

  const TextButton(
      {super.key,
      this.title,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.onTap,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Text(title == null ? "Press Me!" : title!,
            style: GoogleFonts.alike(
              textStyle: TextStyle(
                  fontSize: fontSize ?? 15,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: textColor ?? ColorConstant.blueColor),
            )),
      ),
    );
  }
}
