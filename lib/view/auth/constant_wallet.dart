import 'package:flutter/material.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:game_on/generated/assets.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/res/components/app_btn.dart';
import 'package:game_on/res/components/text_widget.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/wallet/deposit_screen.dart';
import 'package:game_on/view/wallet/withdraw_screen.dart';

import '../../main.dart';

class ConstantWallet extends StatefulWidget {
  const ConstantWallet({super.key});

  @override
  State<ConstantWallet> createState() => _ConstantWalletState();
}

class _ConstantWalletState extends State<ConstantWallet> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, userData, child) {
        return Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(
            gradient: AppColors.unSelectedColor,
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
                image: AssetImage(Assets.imagesWalletbg), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.iconsGamewallet,
                      height: 30,
                    ),
                    textWidget(
                      text: '  Wallet Balance',
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textWidget(text: '🪙 ',fontWeight: FontWeight.w900,
                        fontSize: 20),
                    textWidget(
                      text: userData.balance == null
                          ? ""
                          : userData.balance.toStringAsFixed(2),
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        userData.profileApi(context);
                        Utils.flushBarSuccessMessage(
                            'Wallet refresh ✔', context, Colors.white);
                      },
                      child: Image.asset(Assets.iconsTotalBal, height: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBtn(
                    titleColor: AppColors.whiteColor,
                    width: width * 0.4,
                    height: 38,
                    borderRadius: 8,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WithdrawScreen(),
                        ),
                      ).then((value) {
                        // Fetch wallet balance again after returning from Withdraw screen
                        userData.profileApi(context);
                      });
                    },
                    title: 'Withdraw',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    gradient: AppColors.loginSecondaryGrad,
                    hideBorder: true,
                  ),
                  AppBtn(
                    titleColor: AppColors.whiteColor,
                    width: width * 0.4,
                    height: 38,
                    borderRadius: 8,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DepositScreen(),
                        ),
                      ).then((value) {
                        // Fetch wallet balance again after returning from Deposit screen
                        userData.profileApi(context);
                      });
                    },
                    gradient: AppColors.transparentGradient,
                    title: 'Deposit',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    border: Border.all(color: AppColors.whiteColor),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
