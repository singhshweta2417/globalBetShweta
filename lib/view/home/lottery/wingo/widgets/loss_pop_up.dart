import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/view/home/lottery/wingo/res/size_const.dart';

class LossPopUpPage extends StatelessWidget {
  final int winNumber;
  final dynamic winAmount;
  final int gameSrNo;
  final int gameId;
  final String result;

  const LossPopUpPage({
    super.key,
    required this.winNumber,
    required this.winAmount,
    required this.gameSrNo,
    required this.gameId,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width * 0.9,
            height: height * 0.6,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(Assets.winGoWinGoLossBg),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 120),
                 textWidget(
                  text: "Sorry",
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
                Sizes.spaceHeight25,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Sizes.spaceWidth5,
                     textWidget(
                      text: "Lottery result",
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    Sizes.spaceWidth5,
                    Container(
                      width: width * 0.2,
                      height: height * 0.03,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Center(
                        child: textWidget(
                          text: winNumber==0?
                          'Red Violet':winNumber==5?
                          'Green Violet':(winNumber==2&&winNumber==4&&winNumber==6&&winNumber==8)?
                          'Red':'Green',
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Sizes.spaceWidth5,
                    Container(
                      width: width * 0.04,
                      height: height * 0.03,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child:  Center(
                        child: textWidget(
                          text: winNumber.toString(),
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Sizes.spaceWidth5,
                    Container(
                      width: width * 0.08,
                      height: height * 0.03,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child:  Center(
                        child: textWidget(
                          text: winNumber<5?'Small':'Big',
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.1),
                textWidget(
                  text: "Lose",
                  fontSize: 30,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.w900,
                ),
                Sizes.spaceHeight15,
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                      text: "Period : ",
                      fontSize: 12,
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
                    textWidget(
                      text: '$gameId min',
                      fontSize: 12,
                      color: Colors.black26,
                      fontWeight: FontWeight.w900,
                    ),
                    Sizes.spaceWidth5,
                    textWidget(
                      text:gameSrNo.toString(),
                      fontSize: 12,
                      color: Colors.black26,
                      fontWeight: FontWeight.w900,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel_outlined,
                size: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
