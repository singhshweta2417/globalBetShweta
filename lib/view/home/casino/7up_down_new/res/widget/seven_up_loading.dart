


import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/head_tail/head_tail_assets.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_constant.dart';



class SevenUpLoading extends StatefulWidget {
  final int time;
  const SevenUpLoading({super.key,  required this.time});

  @override
  _SevenUpLoadingState createState() => _SevenUpLoadingState();
}

class _SevenUpLoadingState extends State<SevenUpLoading> {
  int WaitingTimeSeconds = 30;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(HeadTailAssets.headTailAdornGift),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/seven_up_down_new/loading7.gif',height: height*0.40,),
            SizedBox(height: height*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffea0b3e), width: 1),
                  ),
                  child: LinearProgressIndicator(
                    value: 1 - (widget.time / WaitingTimeSeconds),
                    backgroundColor: Colors.grey,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffea0b3e)),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  '  ${(100 - ((widget.time / WaitingTimeSeconds) * 100)).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: width*0.02,
                      color: Colors.white
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.02,),
            Text(
              "SevenUp is a verifiable 100% ${AppConstant.appName}",
              style: TextStyle(
                  fontSize: width*0.02,
                  color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}