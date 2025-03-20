// ignore_for_file: use_build_context_synchronously

import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/provider/services/splash_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:globalbet/view/auth/login_screen.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

SplashServices splashServices = SplashServices();


class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: AppColors.scaffolddark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 270,
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Container(
              height: 80,
              width: width*0.50,
              decoration:  const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(Assets.imagesLogoutcancel))
              ),

            ),
            SizedBox(height: height / 30),
            Text("Do you want to logout?",
                style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.iconsColor)
                    ),
                    child: Center(
                      child: textWidget(
                          text: "Cancel",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        color: AppColors.primaryTextColor
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('token');
                    // Navigator.canPop(context);

                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const LoginScreen()));
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: AppColors.loginSecondryGrad
                    ),
                    child: Center(
                      child: textWidget(
                        text: "Confirm",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.primaryTextColor
                      ),
                    ),
                  ),
                ),],
            )
          ],
        ),
      ),
    );
  }
}
