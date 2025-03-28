import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_constant.dart';

class SlideTap extends StatelessWidget {
  const SlideTap({
    super.key,
    required this.title,
    required this.play,
    required this.win,
    required this.reversIcon,
    required this.onTap,
  });

  final String title;
  final String play;
  final String win;
  final bool reversIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: width * 0.08,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.tripleChanceTSlideBgNew),
                  fit: BoxFit.fill)),
          child: RotatedBox(
              quarterTurns: 1,
              child: Row(children: [
                Container(
                  margin:  EdgeInsets.only(left: height*0.018),
                  height: height * 0.08,
                  width: AppConstant.trChSlideConWi,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xff620000),
                  ),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Text(
                      'WIN : $win',
                      style:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                           fontSize: height*0.035,
                          fontFamily: 'roboto_lite'),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.08,
                  width: AppConstant.trChSlideConWi,
                  margin:  EdgeInsets.only(left: height*0.01),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xff620000),
                  ),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Text(
                      'PLAY : $play',
                      style:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: height*0.035,
                          fontFamily: 'roboto_lite'),
                    ),
                  ),
                ),
                Expanded(
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Padding(
                      padding:  EdgeInsets.only(left: height*0.03, right: height*0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style:  TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: height*0.026,
                                fontFamily: 'roboto_lite'),
                          ),
                          RotatedBox(
                              quarterTurns: 1,
                              child: !reversIcon
                                  ? Image.asset(
                                Assets.tripleChancePlay,
                                color: Colors.green,
                                scale: AppConstant.trChSlidePlayIcon,
                              )
                                  : RotatedBox(
                                  quarterTurns: 2,
                                  child: Image.asset(
                                    Assets.tripleChancePlay,
                                    color: Colors.yellow,
                                    scale: AppConstant.trChSlidePlayIcon,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ]))),
    );
  }
}