import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/model/country_model.dart';
import 'package:globalbet/offer/country_repo.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/api_urls.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_field.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/provider/auth_provider.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:flutter/material.dart';
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
  TextEditingController refercodee = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController OtpCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String selectedCountryCode = '+91';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldDark,
      appBar: GradientAppBar(
        centerTitle: true,
        title:  textWidget(
            text: 'Global Bet',
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: AppColors.primaryTextColor),
        gradient:  AppColors.primaryGradient),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                  child: ListTile(
                    title: textWidget(
                        text: 'Register',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColors.primaryTextColor),
                    subtitle: textWidget(
                        text: 'Please register by phone number or email',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.primaryTextColor),
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 90,
                  decoration: const BoxDecoration(gradient: AppColors.loginSecondaryGrad),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.iconsPhoneTabColor,scale: 1.5,),
                      const SizedBox(width: 2),
                      textWidget(
                          text: 'Register your phone',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.primaryTextColor)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.iconsInvitionCode,
                        height: 30,
                      ),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Enter Referral Code',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.primaryTextColor)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: CustomTextField(
                    controller: refercodee,
                    maxLines: 1,
                    hintText: 'Please Enter Referral code',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.iconsPhone,
                        height: 30,

                      ),
                      const SizedBox(width: 20),
                      textWidget(
                          text: 'Phone Number',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.primaryTextColor)
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
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
                              enabled: false,
                              onChanged:  (value) async {
                                String? code = await showCountryPicker(context);
                                if (code != null) {
                                  selectedCountryCode = code;
                                }
                              },
                              hintText: selectedCountryCode,
                              hintColor: AppColors.whiteColor,
                              suffixIcon: RotatedBox(
                                quarterTurns: 45,
                                child: Icon(Icons.arrow_forward_ios_outlined, size: 15, color: AppColors.whiteColor,),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                            child: CustomTextField(
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
                    )),
                if (showContainer == true && selectedCountryCode == "+91")
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.verified,
                                color: AppColors.gradientFirstColor,
                              ),
                              const SizedBox(width: 20),
                              textWidget(
                                  text: 'OTP',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: AppColors.secondaryTextColor)
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: CustomTextField(
                          controller: OtpCon,
                          maxLines: 1,
                          hintText: 'Verification code',
                          onChanged: (v) async {
                            if(v.length==4){
                              otpMatch(context,OtpCon.text,phoneCon.text, selectedCountryCode);
                            }else{
                              if (kDebugMode) {
                                print("not done");
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                if (showContainer == false && isPhoneNumberValid == true && selectedCountryCode == "+91")
                  AppBtn(
                    width: width*0.35,
                    height: height*0.053,
                    onTap: () {
                      if (isPhoneNumberValid) {
                        setState(() {
                          showContainer = phoneCon.text.length==10;
                        });
                        otpurl(context,phoneCon.text);
                      } else {
                        if (kDebugMode) {
                          print("Please enter a valid 10-digit phone number");
                        }
                      }

                    },
                    title: 'Send OTP',
                    titleColor: Colors.white,
                  ),


                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                    child: Row(
                      children: [
                        Image.asset(Assets.iconsEmailTab,height: 30,),
                        const SizedBox(width: 20),
                        textWidget(
                            text: 'Email',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.primaryTextColor)
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: CustomTextField(
                    controller: emailCon,
                    maxLines: 1,
                    hintText: 'please input your email',
                    style: const TextStyle(color: Colors.white),
                  ),
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
                          text: 'Set password',
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: AppColors.primaryTextColor)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: CustomTextField(
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
                ),


                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Row(
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
                              color: AppColors.gradientFirstColor,
                              border: Border.all(
                                  color: AppColors.secondaryTextColor),

                              borderRadius: BorderRadiusDirectional.circular(50),

                            )
                                :BoxDecoration(
                              border: Border.all(
                                  color: AppColors.secondaryTextColor),
                              borderRadius: BorderRadiusDirectional.circular(50),
                            ),
                            child: readAndAgreePolicy ?const Icon(Icons.check,color: Colors.white,):null

                        ),
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
                            textColor:AppColors.gradientFirstColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            spanTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: AppBtn(
                      title: 'Register',
                      fontSize: 20,
                      loading: authProvider.regLoading,
                      onTap: () {
                        if(phoneCon.text.isEmpty || phoneCon.text.length!=10){
                          Utils.flushBarErrorMessage("Enter phone number", context, Colors.red);
                        }else if(setPasswordCon.text.isEmpty){
                          Utils.flushBarErrorMessage("Set your password", context, Colors.red);
                        }  else if(emailCon.text.isEmpty){
                          Utils.flushBarErrorMessage("Confirm your email", context, Colors.red);
                        }
                        else {
                          authProvider.userRegister(
                              context,
                              phoneCon.text,
                              setPasswordCon.text,
                              refercodee.text,
                              emailCon.text,
                              selectedCountryCode.toString()
                          );
                        }},
                      hideBorder: true,
                      gradient: AppColors.loginSecondaryGrad

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: AppBtn(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.loginScreen);
                    },
                    gradient: AppColors.secondaryGradient,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget(
                            text: 'I have an account',
                            fontSize: 16,
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w600),
                        const SizedBox(width: 15),
                        textWidget(
                            text: 'Login',
                            fontSize: 22,
                            color: AppColors.gradientFirstColor,
                            fontWeight: FontWeight.w600)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  otpurl(context,String phonenumber) async {
    final response = await http.get(
      Uri.parse('${ApiUrl.sendOtp}mode=live&digit=4&mobile=$phonenumber'),
    );
    var data = jsonDecode(response.body);
    if(data["status"]=="200"){
      setState(() {
        show=true;
      });
      Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
    }else {
      Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
    }
  }

  otpMatch(BuildContext context, String myControllers, String phone, String selectedCountryCode) async {
    final authProvider = Provider.of<UserAuthProvider>(context);
    if (selectedCountryCode == "+91") {
      // Directly register the user without OTP verification
      authProvider.userRegister(
          context,
          phoneCon.text,
          setPasswordCon.text,
          refercodee.text,
          emailCon.text,
        selectedCountryCode
      );
    } else {
      // Proceed with OTP verification
      final response = await http.get(Uri.parse('${ApiUrl.verifyOtp}$phone&otp=$myControllers'));

      if (kDebugMode) {
        print("OTP Verification Process");
      }

      var data = jsonDecode(response.body);
      if (data["status"] == "200") {
        setState(() {
          show = true;
        });
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
        // Navigator.pushReplacementNamed(context, RoutesName.bottomNavBar);
      } else {
        setState(() {
          show = false;
        });
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
      }
    }
  }

}

Future<String?> showCountryPicker(BuildContext context) async {
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
            color: AppColors.scaffoldDark,
          borderRadius: BorderRadius.circular(10)
        ),
        child: ListView.builder(
          itemCount: countryList.length,
          itemBuilder: (context, index) {
            final country = countryList[index];
            return ListTile(
              title: Text('${country.name} (${country.sortname})',style: TextStyle(
                  color: AppColors.whiteColor
              ),),
              subtitle: Text('${country.phoneCode}',style: TextStyle(
                color: AppColors.whiteColor
              ),),
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
