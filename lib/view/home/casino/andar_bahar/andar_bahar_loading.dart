import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/view/home/casino/andar_bahar/andar_bahar_assets.dart';
import 'package:game_on/view/home/casino/andar_bahar/andar_home_page.dart';

class AndarBaharLoading extends StatefulWidget {
  const AndarBaharLoading({super.key});

  @override
  AndarBaharLoadingState createState() => AndarBaharLoadingState();
}

class AndarBaharLoadingState extends State<AndarBaharLoading> {
  @override
  void initState() {
    super.initState();
    harsh();
  }

  harsh() async {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AndarBaharHome(
                      gameId: '13',
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.andarbaharAdornGift),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AndarAssets.andarbaharLoading,
              height: height * 0.40,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Andhar Bahar is a verifiable 100% Jupiter",
              style: TextStyle(fontSize: width * 0.02, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
