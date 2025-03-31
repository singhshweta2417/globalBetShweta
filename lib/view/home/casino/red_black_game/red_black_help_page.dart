import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';

class HelpPopup extends StatefulWidget {
  const HelpPopup({super.key});

  @override
  State<HelpPopup> createState() => _HelpPopupState();
}

class _HelpPopupState extends State<HelpPopup> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: height * 0.25,
            width: width * 0.8,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.redBlackImgBgHelp),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.34,
                      right: width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'HELP',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height * 0.028,
                          width: width * 0.083,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * 0.72,
                  height: height * 0.18,
                  child: const Text(
                    'One card will randomly be drawn from one deck of poker per game.(54 card,contain Joker)',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
