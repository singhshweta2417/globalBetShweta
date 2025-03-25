import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:globalbet/res/components/app_bar.dart';
import 'package:globalbet/res/components/app_btn.dart';
import 'package:globalbet/res/components/text_field.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/utils/routes/routes_name.dart';
import 'package:globalbet/view/home/lottery/wingo/res/size_const.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/account/service_center/customer_service.dart';
import 'package:globalbet/view/auth/forget_password_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool selectedButton = true;
  bool hidePassword = true;
  bool rememberPass = false;
  bool activeButton = true;
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController passwordConn = TextEditingController();

  /// Check internet
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    initConnectivity();
    super.initState();
  }

  Future<bool> _onWillPop() async {
    bool shouldExit = await Utils.showExitConfirmation(context) ?? false;
    return shouldExit;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: GradientAppBar(
            centerTitle: true,
            title: textWidget(
                text: 'Global Bet',
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: AppColors.whiteColor),
            ),
        body: _connectionStatus == ConnectivityResult.none
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image(
                      image: const AssetImage(Assets.imagesNoDataAvailable),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('There is no Internet connection'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text('Please check your Internet connection'),
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.fromLTRB(
                    width * 0.05, height * 0.02, width * 0.05, 0),
                decoration: const BoxDecoration(gradient: AppColors.bgGrad),
                child: ListView(
                  children: [
                    textWidget(
                        text: 'Log in',
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColors.whiteColor),
                    textWidget(
                        text:
                            'Please log in with your phone number or email\nIf you forget your password, please contact customer service',
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: AppColors.whiteColor),
                    Sizes.spaceHeight10,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedButton = !selectedButton;
                              activeButton = !activeButton;
                            });
                          },
                          child: Container(
                            height: height * 0.1,
                            width: width * 0.45,
                            decoration: BoxDecoration(
                              gradient: selectedButton
                                  ? AppColors.loginSecondaryGrad
                                  : AppColors.unSelectedColor,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedButton = !selectedButton;
                                    activeButton = !activeButton;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    selectedButton
                                        ? Image.asset(Assets.iconsPhoneTabColor,
                                            scale: 1.5,
                                            color: AppColors.whiteColor)
                                        : Image.asset(
                                            Assets.iconsPhoneTab,
                                            scale: 1.5,
                                            color: AppColors.unSelectColor,
                                          ),
                                    textWidget(
                                      text: 'Log in with phone',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: selectedButton
                                          ? AppColors.whiteColor
                                          : AppColors.unSelectColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedButton = !selectedButton;
                              activeButton = !activeButton;
                            });
                          },
                          child: Container(
                            height: height * 0.1,
                            width: width * 0.45,
                            decoration: BoxDecoration(
                              gradient: !selectedButton
                                  ? AppColors.loginSecondaryGrad
                                  : AppColors.unSelectedColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !selectedButton
                                    ? Image.asset(Assets.iconsEmailTabColor,
                                        scale: 1.5,
                                        color: AppColors.whiteColor)
                                    : Image.asset(
                                        Assets.iconsEmailTab,
                                        scale: 1.5,
                                        color: AppColors.unSelectColor,
                                      ),
                                textWidget(
                                  text: 'Email Login',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: !selectedButton
                                      ? AppColors.whiteColor
                                      : AppColors.unSelectColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Sizes.spaceHeight10,
                    Row(
                      children: [
                        Image.asset(
                            selectedButton
                                ? Assets.iconsPhone
                                : Assets.iconsEmailTab,
                            scale: 1.5,
                            color: AppColors.whiteColor),
                        const SizedBox(width: 20),
                        textWidget(
                            text: selectedButton ? 'Phone Number' : 'Mail',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.whiteColor)
                      ],
                    ),
                    Sizes.spaceHeight5,
                    selectedButton
                        ? Row(
                            children: [
                              const SizedBox(
                                width: 100,
                                child: CustomTextField(
                                  fillColor: AppColors.unSelectColor,
                                  enabled: false,
                                  hintText: '+91',
                                  hintColor: Colors.white,
                                  suffixIcon: RotatedBox(
                                      quarterTurns: 45,
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                  child: CustomTextField(
                                onChanged: (value) {
                                  if (phoneCon.text.length == 10) {
                                    setState(() {
                                      activeButton = !activeButton;
                                    });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: phoneCon,
                                maxLength: 10,
                                hintText: 'Please enter the phone number',
                                fillColor: AppColors.unSelectColor,
                              )),
                            ],
                          )
                        : CustomTextField(
                            onChanged: (value) {
                              if (emailCon.text.isNotEmpty) {
                                setState(() {
                                  activeButton = !activeButton;
                                });
                              }
                            },
                            controller: emailCon,
                            maxLines: 1,
                            hintText: 'please input your email',
                            fillColor: AppColors.unSelectColor),
                    Sizes.spaceHeight10,
                    Row(
                      children: [
                        Image.asset(Assets.iconsPassword,
                            scale: 1.5, color: AppColors.whiteColor),
                        const SizedBox(width: 20),
                        textWidget(
                            text: 'Password',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.whiteColor)
                      ],
                    ),
                    Sizes.spaceHeight5,
                    CustomTextField(
                      fillColor: AppColors.unSelectColor,
                      obscureText: hidePassword,
                      controller: passwordCon,
                      maxLines: 1,
                      hintText: 'Please enter Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Image.asset(
                            hidePassword
                                ? Assets.iconsEyeClose
                                : Assets.iconsEyeOpen,
                            scale: 1.5,
                            color: AppColors.primaryContColor,
                          )),
                    ),
                    Sizes.spaceHeight20,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rememberPass = !rememberPass;
                            });
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: rememberPass
                                  ? BoxDecoration(
                                      color: AppColors.whiteColor,
                                      border: Border.all(
                                          color: AppColors.whiteColor),
                                      borderRadius:
                                          BorderRadiusDirectional.circular(50),
                                    )
                                  : BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.whiteColor),
                                      borderRadius:
                                          BorderRadiusDirectional.circular(50),
                                    ),
                              child: rememberPass
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                  : null),
                        ),
                        const SizedBox(width: 20),
                        textWidget(
                            text: 'Remember password',
                            fontSize: 14,
                            color: AppColors.whiteColor),
                      ],
                    ),
                    Sizes.spaceHeight20,
                    AppBtn(
                      loading: authProvider.loading,
                      title: 'Log in',
                      fontSize: 20,
                      onTap: () {
                        if (selectedButton == true) {
                          if (kDebugMode) {
                            print("object");
                          }
                          authProvider.userLogin(
                              context, phoneCon.text, passwordCon.text);
                        } else {
                          authProvider.userLogin(
                              context, emailCon.text, passwordCon.text);
                        }
                      },
                    ),
                    Sizes.spaceHeight20,
                    AppBtn(
                        title: 'R e g i s t e r',
                        fontSize: 20,
                        titleColor: AppColors.primaryContColor,
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.registerScreenOtp,
                              arguments: '1');
                        },
                        gradient: AppColors.unSelectedColor),
                    Sizes.spaceHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen()));
                          },
                          child: Column(
                            children: [
                              Image.asset(Assets.iconsPassword,
                                  height: 50,
                                  color: AppColors.whiteColor),
                              textWidget(
                                  text: 'Forgot password',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.whiteColor)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerCareService()));
                          },
                          child: Column(
                            children: [
                              Image.asset(Assets.iconsCustomer,
                                  height: 50,
                                  color: AppColors.whiteColor),
                              textWidget(
                                  text: 'Customer Service',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppColors.whiteColor)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
