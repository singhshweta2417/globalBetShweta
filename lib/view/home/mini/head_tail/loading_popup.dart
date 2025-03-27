
import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/app_constant.dart';
import 'package:globalbet/view/home/mini/head_tail/head_tail_assets.dart';

class HeadTailPopUp extends StatefulWidget {
  final int time;
  const HeadTailPopUp({super.key, required this.time});

  @override
  _HeadTailPopUpState createState() => _HeadTailPopUpState();
}

class _HeadTailPopUpState extends State<HeadTailPopUp> {
  int WaitingTimeSeconds = 30;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(HeadTailAssets.headTailAdornGift),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              HeadTailAssets.headTailHomeHeadTales,
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
                    value: 1 - (widget.time / WaitingTimeSeconds),
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xffea0b3e)),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  '  ${(100 - ((widget.time / WaitingTimeSeconds) * 100)).toStringAsFixed(0)}%',
                  style: TextStyle(fontSize: width * 0.02, color: Colors.white),
                ),
                // Text(' ${_linearProgressAnimation.value.toStringAsFixed(2)}%',style: TextStyle(color: Colors.white),),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Head Tail is a verifiable 100% ${AppConstants.appName}",
              style: TextStyle(fontSize: width * 0.02, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
