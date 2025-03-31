import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/font_size.dart';

class RedBlackLoading extends StatefulWidget {
  final int time;
  const RedBlackLoading({super.key, required this.time});

  @override
  RedBlackLoadingState createState() => RedBlackLoadingState();
}

class RedBlackLoadingState extends State<RedBlackLoading> {
  int waitingTimeSeconds = 30;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.headTailAdornGift),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.redBlackImgHomeRedblack,
              height: height * 0.40,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xffea0b3e), width: 1),
                  ),
                  child: LinearProgressIndicator(
                    value: 1 - (widget.time / waitingTimeSeconds),
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xffea0b3e)),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  '  ${(100 - ((widget.time / waitingTimeSeconds) * 100)).toStringAsFixed(0)}%',
                  style: TextStyle(fontSize: width * 0.02, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Red Black is a verifiable 100% $appName",
              style: TextStyle(fontSize: width * 0.02, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
