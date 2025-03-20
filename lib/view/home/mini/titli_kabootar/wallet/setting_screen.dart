import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/font_size.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/account_view.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/add_account.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/deposit_history.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/deposit_screen.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/withdraw_history.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/wallet/withdraw_screen.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.2, vertical: height * 0.12),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.imagesBlackHisBox), fit: BoxFit.fill),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.08,
              vertical: height * 0.05,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Image(
                          height: 20, image: AssetImage(Assets.titliCancel))),
                ),
                const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.12),
                  child: Divider(
                    color: AppColors.white,
                    height: height * 0.01,
                  ),
                ),
                spaceHeight10,
                _buildOption(context,
                    title: "Add Account",
                    icon: Icons.person_add_alt, onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AddAccountScreen());
                }),
                _buildOption(context,
                    title: "View Account",
                    icon: Icons.account_circle, onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AccountView());
                }),
                _buildOption(
                  context,
                  title: "Deposit",
                  icon: Icons.account_balance_wallet_outlined,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const DepositScreen());
                  },
                ),
                _buildOption(
                  context,
                  title: "Withdraw",
                  icon: Icons.attach_money,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const WithdrawScreen());
                  },
                ),
                _buildOption(
                  context,
                  title: "Deposit History",
                  icon: Icons.history,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const DepositHistoryScreen());
                  },
                ),
                _buildOption(
                  context,
                  title: "Withdraw History",
                  icon: Icons.history,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => const WithdrawHistoryScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            spaceWidth5,
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
