import 'dart:convert';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_field.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController oldPassCon = TextEditingController();
  TextEditingController newPassCon = TextEditingController();
  TextEditingController confirmPassCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
        appBar: GradientAppBar(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.white,
                  )),
            ),
            centerTitle: true,
            title: textWidget(
              text: 'Change Password',
              fontWeight: FontWeight.w900,
              fontSize: 20,
              color: AppColors.whiteColor,
            ),
            gradient: AppColors.unSelectedColor),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.iconsPassword,
                              height: 30,
                            ),
                            const SizedBox(width: 20),
                            textWidget(
                                text: 'Login Password',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.whiteColor)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomTextField(
                            obscureText: hideSetPassword,
                            controller: oldPassCon,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white),
                            hintText: 'Enter your old password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideSetPassword = !hideSetPassword;
                                  });
                                },
                                icon: Image.asset(
                                  hideSetPassword
                                      ? Assets.iconsEyeClose
                                      : Assets.iconsEyeOpen,
                                )),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.iconsPassword,
                              height: 30,
                            ),
                            const SizedBox(width: 20),
                            textWidget(
                                text: 'New Password',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.whiteColor)
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomTextField(
                            obscureText: hideSetPassword,
                            controller: newPassCon,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white),
                            hintText: 'Please enter the new password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideSetPassword = !hideSetPassword;
                                  });
                                },
                                icon: Image.asset(
                                  hideSetPassword
                                      ? Assets.iconsEyeClose
                                      : Assets.iconsEyeOpen,
                                )),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.iconsPassword,
                              height: 30,
                            ),
                            const SizedBox(width: 20),
                            textWidget(
                                text: 'Confirm Password',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: AppColors.whiteColor)
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomTextField(
                            obscureText: hideSetPassword,
                            controller: confirmPassCon,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.white),
                            hintText: 'Please re-enter password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideSetPassword = !hideSetPassword;
                                  });
                                },
                                icon: Image.asset(
                                  hideSetPassword
                                      ? Assets.iconsEyeClose
                                      : Assets.iconsEyeOpen,
                                )),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child: AppBtn(
                          title: 'U p d a t e',
                          fontSize: 20,
                          titleColor: AppColors.whiteColor,
                          hideBorder: true,
                          onTap: () {
                            changePass(oldPassCon.text, newPassCon.text,
                                confirmPassCon.text);
                          },
                          gradient: AppColors.loginSecondaryGrad,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  UserViewModel userProvider = UserViewModel();

  changePass(String oldPass, String newPass, String confirmPass) async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(token);
    }
    final response = await http.post(Uri.parse(ApiUrl.changePasswordApi),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userid": token,
          "old_password": oldPass,
          "new_password": newPass,
          "confirm_password": confirmPass
        }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["status"] == 200) {
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
      } else {
        Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
      }
    } else {
      throw Exception("error");
    }
  }
}
