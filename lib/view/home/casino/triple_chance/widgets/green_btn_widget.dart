import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';

class GreenBtnWidget extends StatelessWidget {
  const GreenBtnWidget({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.09,
        width: width * 0.177,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.tripleChanceGBtnBg),
                fit: BoxFit.fill)),
        child: Text(
          title,
          style:  TextStyle(
              color: const Color(0xff053005), fontWeight: FontWeight.bold,fontSize: height*0.03),
        ),
      ),
    );
  }
}
