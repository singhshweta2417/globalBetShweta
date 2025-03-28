import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/country_model.dart';
import 'package:game_on/offer/country_repo.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_field.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/provider/auth_provider.dart';
import 'package:game_on/utils/routes/routes_name.dart';
import 'package:game_on/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:game_on/view/home/lottery/wingo/res/size_const.dart';
import 'package:provider/provider.dart';
import '../../res/components/rich_text.dart';
import 'package:http/http.dart' as http;

class RegisterScreenOtp extends StatefulWidget {
  const RegisterScreenOtp({super.key});

  @override
  State<RegisterScreenOtp> createState() => _RegisterScreenOtpState();
}

class _RegisterScreenOtpState extends State<RegisterScreenOtp> {
  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  bool readAndAgreePolicy = false;
  bool showContainer = false;
  bool show = false;
  bool isPhoneNumberValid = false;

  TextEditingController phoneCon = TextEditingController();
  TextEditingController setPasswordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();
  TextEditingController referCode = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController otpCon = TextEditingController();

  String selectedCountryCode = '+91';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);
    return Scaffold(
      appBar: GradientAppBar(
          centerTitle: true,
          title: textWidget(
              text: 'Game On',
              fontWeight: FontWeight.w600,
              fontSize: 28,
              color: AppColors.whiteColor),
          gradient: AppColors.primaryGradient),
      body: Container(
          padding:
              EdgeInsets.fromLTRB(width * 0.05, height * 0.02, width * 0.05, 0),
          decoration: const BoxDecoration(gradient: AppColors.bgGrad),
          child: ListView(
            children: [
              textWidget(
                  text: 'Register',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: AppColors.whiteColor),
              textWidget(
                  text: 'Please register by phone number or email',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.whiteColor),
              Sizes.spaceHeight10,
              Column(
                children: [
                  Image.asset(
                    Assets.iconsPhoneTabColor,
                    scale: 1.5,
                  ),
                  textWidget(
                      text: 'Register your phone',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.whiteColor),
                ],
              ),
              const Divider(),
              Sizes.spaceHeight10,
              Row(
                children: [
                  Image.asset(
                    Assets.iconsInvitionCode,
                    height: 30,
                    color: AppColors.primaryContColor,
                  ),
                  const SizedBox(width: 20),
                  textWidget(
                      text: 'Enter Referral Code',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: AppColors.whiteColor)
                ],
              ),
              Sizes.spaceHeight5,
              CustomTextField(
                  controller: referCode,
                  maxLines: 1,
                  hintText: 'Please Enter Referral code',
                  style: const TextStyle(color: Colors.white),
                  fillColor: AppColors.unSelectColor),
              Sizes.spaceHeight10,
              Row(
                children: [
                  Image.asset(
                    Assets.iconsPhone,
                    height: 30,
                    color: AppColors.primaryContColor,
                  ),
                  const SizedBox(width: 20),
                  textWidget(
                      text: 'Phone Number',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: AppColors.whiteColor)
                ],
              ),
              Sizes.spaceHeight5,
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: GestureDetector(
                      onTap: () async {
                        String? code = await showCountryPicker(context);
                        if (code != null) {
                          selectedCountryCode = code;
                        }
                      },
                      child: CustomTextField(
                        fillColor: AppColors.unSelectColor,
                        enabled: false,
                        onChanged: (value) async {
                          String? code = await showCountryPicker(context);
                          if (code != null) {
                            selectedCountryCode = code;
                          }
                        },
                        hintText: selectedCountryCode,
                        hintColor: AppColors.whiteColor,
                        suffixIcon: const RotatedBox(
                          quarterTurns: 45,
                          child: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      child: CustomTextField(
                    fillColor: AppColors.unSelectColor,
                    onChanged: (v) {
                      if (v.length == 10) {
                        setState(() {
                          isPhoneNumberValid = true;
                        });
                      } else {
                        setState(() {
                          isPhoneNumberValid = false;
                        });
                      }
                    },
                    keyboardType: TextInputType.phone,
                    controller: phoneCon,
                    maxLength: 10,
                    hintText: 'Please enter the phone number',
                    style: const TextStyle(color: Colors.white),
                  )),
                ],
              ),
              if (showContainer == true && selectedCountryCode == "+91")
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.verified,
                              color: AppColors.primaryContColor,
                            ),
                            const SizedBox(width: 20),
                            textWidget(
                              text: 'OTP',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: AppColors.primaryContColor,
                            )
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: CustomTextField(
                        fillColor: AppColors.unSelectColor,
                        controller: otpCon,
                        maxLines: 1,
                        hintText: 'Verification code',
                        onChanged: (v) async {
                          if (v.length == 4) {
                            otpMatch(context, otpCon.text, phoneCon.text,
                                selectedCountryCode);
                          } else {
                            if (kDebugMode) {
                              print("not done");
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              Sizes.spaceHeight10,
              if (showContainer == false &&
                  isPhoneNumberValid == true &&
                  selectedCountryCode == "+91")
                AppBtn(
                  width: width * 0.35,
                  height: height * 0.053,
                  onTap: () {
                    if (isPhoneNumberValid) {
                      setState(() {
                        showContainer = phoneCon.text.length == 10;
                      });
                      otpUrl(context, phoneCon.text);
                    } else {
                      if (kDebugMode) {
                        print("Please enter a valid 10-digit phone number");
                      }
                    }
                  },
                  title: 'Send OTP',
                  titleColor: Colors.white,
                ),
              Row(
                children: [
                  Image.asset(
                    Assets.iconsEmailTab,
                    height: 30,
                    color: AppColors.primaryContColor,
                  ),
                  const SizedBox(width: 20),
                  textWidget(
                      text: 'Email',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: AppColors.whiteColor)
                ],
              ),
              Sizes.spaceHeight5,
              CustomTextField(
                fillColor: AppColors.unSelectColor,
                controller: emailCon,
                maxLines: 1,
                hintText: 'please input your email',
                style: const TextStyle(color: Colors.white),
              ),
              Sizes.spaceHeight10,
              Row(
                children: [
                  Image.asset(
                    Assets.iconsPassword,
                    height: 30,
                    color: AppColors.primaryContColor,
                  ),
                  const SizedBox(width: 20),
                  textWidget(
                      text: 'Set password',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: AppColors.whiteColor)
                ],
              ),
              Sizes.spaceHeight5,
              CustomTextField(
                fillColor: AppColors.unSelectColor,
                obscureText: hideSetPassword,
                controller: setPasswordCon,
                style: const TextStyle(color: Colors.white),
                maxLines: 1,
                hintText: 'Please enter Set password',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hideSetPassword = !hideSetPassword;
                      });
                    },
                    icon: Image.asset(hideSetPassword
                        ? Assets.iconsEyeClose
                        : Assets.iconsEyeOpen)),
              ),
              Sizes.spaceHeight10,
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        readAndAgreePolicy = !readAndAgreePolicy;
                      });
                    },
                    child: Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        decoration: readAndAgreePolicy
                            ? BoxDecoration(
                                color: AppColors.whiteColor,
                                border: Border.all(
                                    color: AppColors.primaryContColor),
                                borderRadius:
                                    BorderRadiusDirectional.circular(50),
                              )
                            : BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryContColor),
                                borderRadius:
                                    BorderRadiusDirectional.circular(50),
                              ),
                        child: readAndAgreePolicy
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null),
                  ),
                  const SizedBox(width: 10),
                  CustomRichText(
                    textSpans: [
                      CustomTextSpan(
                        text: "I have read and agree",
                        textColor: Colors.white,
                        fontSize: 13,
                        spanTap: () {
                          setState(() {
                            readAndAgreePolicy = !readAndAgreePolicy;
                          });
                        },
                      ),
                      CustomTextSpan(
                        text: "【Privacy Agreement】",
                        textColor: AppColors.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        spanTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Sizes.spaceHeight10,
              AppBtn(
                  title: 'Register',
                  fontSize: 20,
                  loading: authProvider.regLoading,
                  onTap: () {
                    if (phoneCon.text.isEmpty || phoneCon.text.length != 10) {
                      Utils.flushBarErrorMessage(
                          "Enter phone number", context, Colors.red);
                    } else if (setPasswordCon.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Set your password", context, Colors.red);
                    } else if (emailCon.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          "Confirm your email", context, Colors.red);
                    } else {
                      authProvider.userRegister(
                          context,
                          phoneCon.text,
                          setPasswordCon.text,
                          referCode.text,
                          emailCon.text,
                          selectedCountryCode.toString());
                    }
                  },
                  gradient: AppColors.loginSecondaryGrad),
              Sizes.spaceHeight10,
              AppBtn(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.loginScreen);
                },
                gradient: AppColors.unSelectedColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                        text: 'I have an account',
                        fontSize: 16,
                        color: AppColors.primaryContColor,
                        fontWeight: FontWeight.w600),
                    const SizedBox(width: 15),
                    textWidget(
                        text: 'Login',
                        fontSize: 22,
                        color: AppColors.primaryContColor,
                        fontWeight: FontWeight.w600)
                  ],
                ),
              ),
              Sizes.spaceHeight10,
            ],
          )),
    );
  }

  otpUrl(context, String phonenumber) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.sendOtp}mode=live&digit=4&mobile=$phonenumber'),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == "200") {
      setState(() {
        show = true;
      });
      Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
    } else {
      Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
    }
  }

  otpMatch(context, String myControllers, String phone,
      String selectedCountryCode) async {
    final authProvider = Provider.of<UserAuthProvider>(context);
    if (selectedCountryCode == "+91") {
      // Directly register the user without OTP verification
      authProvider.userRegister(context, phoneCon.text, setPasswordCon.text,
          referCode.text, emailCon.text, selectedCountryCode);
    } else {
      // Proceed with OTP verification
      final response = await http
          .get(Uri.parse('${ApiUrl.verifyOtp}$phone&otp=$myControllers'));

      if (kDebugMode) {
        print("OTP Verification Process");
      }

      var data = jsonDecode(response.body);
      if (data["status"] == "200") {
        setState(() {
          show = true;
        });
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
      } else {
        setState(() {
          show = false;
        });
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
      }
    }
  }
}

Future<String?> showCountryPicker( context) async {
  List<Data> countryList = []; // List to hold country data

  try {
    CountryRepository repo = CountryRepository();
    CountryCodeModel model = await repo.countryApi({});
    countryList = model.data ?? [];
  } catch (e) {
    if (kDebugMode) print('Error fetching countries: $e');
  }

  return await showModalBottomSheet<String>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: AppColors.darkColor,
            borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
          itemCount: countryList.length,
          itemBuilder: (context, index) {
            final country = countryList[index];
            return ListTile(
              title: Text(
                '${country.name} (${country.sortname})',
                style: const TextStyle(color: AppColors.whiteColor),
              ),
              subtitle: Text(
                '${country.phoneCode}',
                style: const TextStyle(color: AppColors.whiteColor),
              ),
              onTap: () {
                Navigator.pop(context, '${country.phoneCode}');
              },
            );
          },
        ),
      );
    },
  );
}
