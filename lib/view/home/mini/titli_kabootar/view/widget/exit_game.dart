import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/res/orientation.dart';
import 'package:game_on/view/bottom/bottom_nav_bar.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/font_size.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/sound.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/text_const.dart';

class ExitTitliGame extends StatelessWidget {
  const ExitTitliGame({super.key});

  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return  Material(
      color: Colors.transparent,
      child: Container(
        height: height,
        margin: EdgeInsets.symmetric(horizontal: width*0.3,
            vertical: height*0.3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(image: AssetImage(Assets.imagesBlackHisBox),
                fit: BoxFit.fill
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width*0.3,
              child: const TextConst(
                textAlign: TextAlign.center,
                maxLines: 2,
                title: "Are you sure you want to exit this game",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            spaceHeight25,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const TextConst(
                    title: "Cancel",
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Audio.audioPlayers.stop();
                    OrientationPortraitUtil.setPortraitOrientation();
                    FeedbackProvider.navigateToHome(context);
                    Audio.audioPlayers.stop();
                  },
                  child: const TextConst(
                    title: "Yes",
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
