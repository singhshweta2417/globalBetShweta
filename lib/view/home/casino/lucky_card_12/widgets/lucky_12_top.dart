import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/view/home/casino/lucky_card_12/controller/lucky_12_controller.dart';
import 'package:globalbet/view/home/casino/lucky_card_12/view_model/lucky_12_result_view_model.dart';
import 'package:globalbet/view/home/casino/lucky_card_12/widgets/luck_12_exit_pop_up.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:provider/provider.dart';

class Lucky12Top extends StatelessWidget {
  const Lucky12Top({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final lucky12ResultViewModel = Provider.of<Lucky12ResultViewModel>(context);
    return Consumer<Lucky12Controller>(builder: (context, l12c, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            height: height * 0.08,
            width: width * 0.2,
            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.lucky16LBgBlue),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'GAME ID :',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstant.luckyKaFont,
                      fontFamily: 'kalam'),
                ),
                Text(
                  lucky12ResultViewModel.lucky12ResultList.isNotEmpty
                      ? (lucky12ResultViewModel
                                  .lucky12ResultList.first.periodNo! +
                              1)
                          .toString()
                      : '',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstant.luckyKaFont,
                      fontFamily: 'kalam'),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.08,
            width: width * 0.2,
            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.lucky16LBgBlue),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BALANCE:',
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstant.luckyKaFont,
                      fontFamily: 'kalam'),
                ),
                Text(
                  profileViewModel.balance.toStringAsFixed(2),//balance
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstant.luckyKaFont,
                      fontFamily: 'kalam'),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Luck12ExitPopUp(
                    yes: () {
                      // exit the game
                      l12c.disConnectToServer(context);
                      // Navigator.pushReplacementNamed(
                      //     context, RoutesName.dashboard);
                    },
                  );
                },
              );
            },
            child: Container(
              height: width * 0.03,
              width: width * 0.03,
              margin: EdgeInsets.only(right: width * 0.05),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.lucky12Close),
                      fit: BoxFit.fill)),
            ),
          ),
        ],
      );
    });
  }
}
