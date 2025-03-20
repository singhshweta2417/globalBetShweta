import 'package:flutter/material.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/res/components/text_widget.dart';
import 'package:globalbet/view/home/lottery/wingo/controller/win_go_controller.dart';
import 'package:globalbet/view/home/lottery/wingo/view_model/win_go_game_his_view_model.dart';
import 'package:provider/provider.dart';

import 'package:globalbet/main.dart';

class WinGoChart extends StatelessWidget {
  const WinGoChart({super.key});

  @override
  Widget build(BuildContext context) {
    final wingoResult = Provider.of<WinGoGameHisViewModel>(context);
    return Consumer<WinGoController>(builder: (context, wgc, child) {
      if (wingoResult.winGoGameHisModelData != null ||
          wingoResult.winGoGameHisModelData!.data!.isNotEmpty) {
        return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(left: 1, right: 1),
            decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width * 0.3,
                  child: const Text(
                    'Period',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.whiteColor),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  width: width * 0.21,
                  child: const Text(
                    'Number',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: List.generate(
              wingoResult.winGoGameHisModelData!.data!.length,
                  (index) {
                final res=wingoResult.winGoGameHisModelData!.data![index];
                return Container(
                  margin: const EdgeInsets.only(left: 1, right: 1),
                  height: 30,
                  width: width * 0.97,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textWidget(
                        text: '${res.gamesNo}',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                      Row(
                        children: List.generate(10, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: res.number==index?AppColors.primaryGradient:AppColors.boxGradient
                              ),
                              child: textWidget(
                                text: index.toString(),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: res.number==index?Colors.white:Colors.black,
                              ),
                            ),
                          );
                        }),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.all(2),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.buttonGradient),
                        child: textWidget(
                          text: res.number! > 4 &&
                              res.number! < 10
                              ?'B':'S',
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
      } else {
        return Container(
            height: height * 0.2,
            width: width,
            alignment: Alignment.center,
            child: const Text('No data available!',
                style: TextStyle(color: Colors.white)));
      }
    });
  }
}

