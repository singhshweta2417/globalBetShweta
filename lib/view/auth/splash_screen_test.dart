import 'dart:async';

import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/routes/routes_name.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    harsh();
  }

  harsh() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("token") ?? '0';
    print(userid);
    print('nknknknkn');
    Timer(
        const Duration(seconds: 3),
        () => userid != '0'
            ? Navigator.pushNamed(context, RoutesName.bottomNavBar)
            : Navigator.pushNamed(context, RoutesName.loginScreen));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.bgGrad,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage(Assets.imagesSplashImage),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          textWidget(
            text: 'Withdraw fast, safe and stable',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryTextColor,
          ),
        ],
      ),
    )));
  }
}
