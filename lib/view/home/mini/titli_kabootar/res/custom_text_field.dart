import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.icon,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.isMobile = false,
  });

  final String title;
  final Widget? icon; // Icon is now optional
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.08,
      width: width * 0.34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.green.withAlpha((244 * 0.2).toInt())),
        color: AppColors.black,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        textCapitalization: textCapitalization,
        keyboardType: isMobile ? TextInputType.number : keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        cursorColor: Colors.red,
        cursorHeight: height * 0.04,
        controller: controller,
        inputFormatters: isMobile
            ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)]
            : inputFormatters,
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: icon, // Icon only if provided
          hintText: title,
          counterText: "", // Hide the character counter
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
          contentPadding: const EdgeInsets.only(bottom: 16),
        ),
      ),
    );
  }
}
