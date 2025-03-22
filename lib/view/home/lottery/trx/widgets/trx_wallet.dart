import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/lottery/trx/res/trx_colors.dart';
import 'package:provider/provider.dart';


class TrxWallet extends StatefulWidget {
  const TrxWallet({super.key});

  @override
  State<TrxWallet> createState() => _TrxWalletState();
}

class _TrxWalletState extends State<TrxWallet> {
  @override
  Widget build(BuildContext context) {
    final userProfileViewModel = Provider.of<ProfileViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: TrxColors.appBarGradient,
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
            image: AssetImage(Assets.imagesWalletBg), fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                Assets.iconsGameWallet,
                height: 30,
                color: TrxColors.whiteColor,
              ),
               textWidget(
                 text: '  Wallet Balance',
                fontWeight: FontWeight.w500,
                color: TrxColors.whiteColor,
                fontSize: 18,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textWidget(
                text: "Rs ",
                fontSize: 20,
                color: TrxColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
              textWidget(
                text:
                    userProfileViewModel.balance.toStringAsFixed(2),
                fontSize: 20,
                color: TrxColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  userProfileViewModel.profileApi(context);
                  Utils.flushBarSuccessMessage(
                    'Wallet refresh ✔',
                    context,Colors.green
                  );
                },
                child: Image.asset(
                  Assets.iconsTotalBal,
                  height: 30,
                  color: TrxColors.whiteColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
    }
}
