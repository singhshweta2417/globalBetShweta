import 'package:flutter/material.dart';
import 'package:globalbet/res/aap_colors.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final InputDecoration? decoration = const InputDecoration();
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign = TextAlign.start;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly = false;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? icon;
  final Color? iconColor;
  final String? hintText;
  final bool? filled;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final void Function(String)? onChanged;
  final double? height;
  final double? width;
  final double? hintSize;
  final double? fontSize;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final double? cursorHeight;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BorderRadius? fieldRadius;
  final bool? enabled;
  final void Function()? onTap;
  final bool? autofocus;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? margin;
  final Color? hintColor;
  final String? errorText;
  final BorderSide? borderSide;
  final Color? textColor;
  final FontWeight? fontWeight;
  final FontWeight? hintWeight;
  final TextInputAction? textinputaction;

  const CustomTextField({
    super.key,
    this.controller,
    this.style,
    this.strutStyle,
    this.textAlignVertical,
    this.textDirection,
    this.minLines,
    this.maxLength,
    this.obscureText=false,
    this.keyboardType,
    this.icon,
    this.iconColor,
    this.hintText,
    this.filled,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.onChanged,
    this.height,
    this.width,
    this.hintSize,
    this.fontSize,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.contentPadding,
    this.cursorHeight,
    this.cursorColor,
    this.prefixIcon,
    this.suffixIcon,
    this.fieldRadius,
    this.enabled,
    this.maxLines,
    this.onTap,
    this.autofocus,
    this.onSaved,
    this.validator,
    this.margin,
    this.hintColor,
    this.errorText,
    this.borderSide,
    this.textColor,
    this.fontWeight,
    this.hintWeight,
    this.textinputaction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: height ?? 55,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: TextFormField(
          textInputAction: textinputaction?? TextInputAction.done,
          validator: validator,
          onSaved: onSaved,
          autofocus: autofocus ?? false,
          textAlignVertical: TextAlignVertical.center,
          enabled: enabled,
          controller: controller,
          cursorColor: cursorColor,
          cursorHeight: cursorHeight,
          onChanged: onChanged,
          maxLines: maxLines,
          maxLength: maxLength,
          readOnly: readOnly,
          obscureText: obscureText!,
          keyboardType: keyboardType,
          style: style ??
           TextStyle(
                    fontSize: fontSize ?? 16,
                    fontWeight: fontWeight??FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    color: textColor ?? Colors.white),

          decoration: InputDecoration(
            errorText: errorText,
            counterText: "",
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: filled ?? true,
            fillColor: fillColor ?? AppColors.filledColor,
            hintText: hintText,
            hintStyle:
             TextStyle(
                  fontSize: hintSize ?? 16,
                  fontWeight: hintWeight??FontWeight.normal,
                  color: hintColor ?? Colors.grey),

            contentPadding: contentPadding ??
                const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
            border: OutlineInputBorder(
                borderSide: borderSide == null
                    ? const BorderSide(width: 0, color: AppColors.filledColor,)
                    : borderSide!,
                borderRadius: fieldRadius == null
                    ? const BorderRadius.all(Radius.circular(10))
                    : fieldRadius!),
            focusedBorder: OutlineInputBorder(
                borderSide: borderSide == null
                    ? BorderSide(width: 1, color: AppColors.gradientFirstColor.withOpacity(0.5))
                    : borderSide!,
                borderRadius: fieldRadius == null
                    ? const BorderRadius.all(Radius.circular(10))
                    : fieldRadius!),
            disabledBorder: OutlineInputBorder(
                borderSide: borderSide == null
                    ? const BorderSide(width: 1, color:AppColors.filledColor,)
                    : borderSide!,
                borderRadius: fieldRadius == null
                    ? const BorderRadius.all(Radius.circular(10))
                    : fieldRadius!),
            enabledBorder: OutlineInputBorder(
                borderSide: borderSide == null
                    ? const BorderSide(width: 1, color: AppColors.filledColor,)
                    : borderSide!,
                borderRadius: fieldRadius == null
                    ? const BorderRadius.all(Radius.circular(10))
                    : fieldRadius!),
          ),
        ),
      ),
    );
  }
}

