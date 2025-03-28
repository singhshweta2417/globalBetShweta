import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/res/size_const.dart';
import 'package:provider/provider.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/main.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/api_urls.dart';
import 'package:game_on/res/components/app_bar.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/circular_percent.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/res/helper/api_helper.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/wallet/deposit_history.dart';
import 'package:game_on/view/wallet/deposit_screen.dart';
import 'package:game_on/view/wallet/withdraw_screen.dart';
import 'package:game_on/view/wallet/withdrawal_history.dart';
import 'package:http/http.dart' as http;

class WalletScreenNew extends StatefulWidget {
  const WalletScreenNew({super.key});

  @override
  State<WalletScreenNew> createState() => _WalletScreenNewState();
}

class _WalletScreenNewState extends State<WalletScreenNew> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<ProfileViewModel>(context);
    return Scaffold(
        appBar: const GradientAppBar(
            title: Text(
              'Wallet',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: Colors.white),
            ),
            centerTitle: true,
            gradient: AppColors.primaryGradient),
        body: Container(
          height: height,
          padding: EdgeInsets.fromLTRB(width*0.04, height*0.03, width*0.04, height*0.05),
          decoration: const BoxDecoration(
            gradient: AppColors.bgGrad
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset(
                Assets.iconsProWallet,
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(text: '🪙 ',fontWeight: FontWeight.w900,
                      fontSize: 20),
                  textWidget(
                    text: userData.balance == 0
                        ? ""
                        : userData.balance.toStringAsFixed(2),
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
              textWidget(
                textAlign: TextAlign.center,
                  text: 'Total Balance',
                  color: AppColors.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
              Sizes.spaceHeight20,
              Container(
                height: height * 0.62,
                decoration: BoxDecoration(
                    color: AppColors.contLightColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        percentage(
                          ((double.tryParse(userData.mainWallet?.toString() ?? '0') ?? 0) /
                              (double.tryParse(userData.balance?.toString() ?? '1') ?? 1) *
                              100)
                              .toStringAsFixed(2),
                          (userData.mainWallet == null || userData.mainWallet.isEmpty)
                              ? "0"
                              : (double.tryParse(userData.mainWallet.toString()) ?? 0).toStringAsFixed(2),
                          'Main wallet',
                        ),

                        percentage(
                          ((double.tryParse(userData.thirdPartyWallet?.toString() ?? '0') ?? 0) /
                              (double.tryParse(userData.balance?.toString() ?? '1') ?? 1) *
                              100)
                              .toStringAsFixed(2),
                          (userData.thirdPartyWallet == null || userData.thirdPartyWallet.isEmpty)
                              ? "0"
                              : (double.tryParse(userData.thirdPartyWallet.toString()) ?? 0).toStringAsFixed(2),
                          '3rd party wallet',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    AppBtn(
                        height: height * 0.07,
                        title: 'Main wallet transfer',
                        fontSize: 17,
                        onTap: () {
                          mainWalletTransfer(context);
                        },
                        hideBorder: true,
                        gradient: AppColors.loginSecondaryGrad),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        groups(
                          Assets.iconsProDeposit,
                          'Deposit',
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const DepositScreen()));
                          },
                        ),
                        groups(
                          Assets.iconsProWithdraw,
                          'Withdrawal',
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const WithdrawScreen()));
                          },
                        ),
                        groups(
                          Assets.iconsRechargeHistory,
                          'Deposit\n history',
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const DepositHistory()));
                          },
                        ),
                        groups(
                          Assets.iconsWithdrawHistory,
                          'Withdrawal\n     history',
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const WithdrawHistory()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Sizes.spaceHeight20,
              const Text(
                "Version : 2025",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ],
          ),
        ));
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  UserViewModel userProvider = UserViewModel();
  mainWalletTransfer(context) async {
    final profileProvider =
        Provider.of<ProfileViewModel>(context, listen: false);

    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.post(
      Uri.parse(ApiUrl.mainWalletTransfer),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": token,
      }),
    );
    var data = jsonDecode(response.body);
    if (data["status"] == 200) {
      profileProvider.profileApi(context);
      return Utils.flushBarSuccessMessage(
          data['message'], context, Colors.black);
    } else if (data["status"] == 401) {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    } else {
      Utils.flushBarErrorMessage(data['message'], context, Colors.black);
    }
  }

  ///  code  pusheddddddddddddddddd

  groups(String img, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: height * 0.08,
            width: width * 0.16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: AppColors.bgGrad),
            child: Center(
              child: Image.asset(
                img,
                height: 40,
              ),
            ),
            //color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          textWidget(
              text: title,
              color: AppColors.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ],
      ),
    );
  }

  Widget percentage(String percentData, String amount, String title) {
    double? percentage;
    try {
      percentage = double.parse(percentData) / 100;
    } catch (e) {
      percentage = 0;
    }

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        CircularPercentIndicator(
          animation: true,
          animationDuration: 1200,
          lineWidth: 10.0,
          startAngle: 8.0,
          radius: 120,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: AppColors.whiteColor.withOpacity(0.5),
          linearGradient: AppColors.loginSecondaryGrad,
          percent: percentage.isNaN ? 0 : percentage,
          center: CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.contLightColor,
            child: textWidget(
              text: percentage.isNaN
                  ? "0.00%"
                  : '${(percentage * 100).toStringAsFixed(2)}%',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget(text: '🪙 ',fontWeight: FontWeight.w900,
                fontSize: 20),
            textWidget(
              text: amount,
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: AppColors.whiteColor,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        textWidget(
          text: title,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: AppColors.whiteColor,
        ),
      ],
    );
  }
}
