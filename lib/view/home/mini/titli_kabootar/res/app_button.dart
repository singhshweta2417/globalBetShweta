import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_colors.dart';

class AppBtn extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? gradientColorOne;
  final Color? gradientColorTwo;
  final Color? shadowColor;
  final double? dx;
  final double? dy;
  final Gradient? gradient;
  final String? label;
  final TextStyle? style;
  final IconData? icon;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final double? blurRadius;
  final double? spreadRadius;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  final double? space;
  final double? iconSize;
  final List<BoxShadow>? boxShadow;
  final bool? isClicked; // Now marked as final
  final BoxShape? shape;
  final bool? inCol;
  final bool ?loading;
  final BoxBorder? border;

  const AppBtn({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.width,
    this.height,
    this.margin,
    this.gradientColorOne,
    this.gradientColorTwo,
    this.shadowColor,
    this.dx,
    this.dy,
    this.gradient,
    this.label,
    this.style,
    this.icon,
    this.fontWeight,
    this.fontStyle,
    this.iconColor,
    this.textColor = Colors.white,
    this.fontSize,
    this.begin,
    this.end,
    this.blurRadius,
    this.spreadRadius,
    this.child,
    this.borderRadius,
    this.onTap,
    this.space,
    this.iconSize,
    this.boxShadow,
    this.isClicked,
    this.loading = false,
    this.shape,
    this.inCol = false,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () async {
        if (onTap != null) {
          HapticFeedback.vibrate();
          onTap!();
        }
        SystemSound.play(SystemSoundType.click);
      },
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        padding: padding,
        height: height ?? 48,
        width: width ?? widths,
        decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            borderRadius: borderRadius ?? BorderRadius.circular(5),
            color: color ?? AppColors.red,
            gradient: gradient,
            boxShadow: boxShadow,
            border: border),
        child: child ??
            (icon == null
                ? loading!
                ? const CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            )
                : Text(
              label ?? "",
              style: TextStyle(
                fontSize: fontSize ?? 20,
                color: textColor,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontFamily: "Poppins-Medium",
              ),
              textAlign: TextAlign.center,
            )
                : inCol == false
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize,
                ),
                SizedBox(
                  width: space ?? 5,
                ),
                Text(
                  label ?? "",
                  style: TextStyle(
                    fontSize: fontSize ?? 10,
                    color: textColor,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                  ),
                ),
              ],
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize,
                ),
                SizedBox(
                  width: space ?? 5,
                ),
                Text(
                  label ?? "",
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize ?? 13,
                    fontWeight: fontWeight ?? FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                  ),
                ),
              ],
            )),
      ),
    );
  }
}


