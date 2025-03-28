import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_constant.dart';


class Lucky12Btn extends StatelessWidget {

  const Lucky12Btn({
    super.key,
    required this.title,
    required this.onTap,
    this.fontSize,
    this.heights,
  });
  final String title;
  final VoidCallback onTap;
  final double? fontSize;
  final double? heights;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.06,
        width: width * 0.08,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.lucky16LBtn), fit: BoxFit.fill),
        ),
        child: Text(
          title,
          style:  TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: fontSize??AppConstant.luckyBtnFont),
        ),
      ),
    );
  }
}