import 'package:flutter/material.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:provider/provider.dart';

import '../controller/spin_controller.dart';
import '../res/utils.dart';

class SpinBetGrid extends StatelessWidget {
  const SpinBetGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<SpinController>(builder: (context, stc, child) {
      return SizedBox(
        height: height * 0.35,
        width: width * 0.45,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 1.1),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                onTap: () {
                  if((stc.timerStatus == 1 && stc.timerBetTime <= 5) ||
                      stc.timerStatus == 2){
                    Utils.showSpiToast('WAIT FOR NEXT ROUND', context);
                  }else{
                    stc.spinAddBet(
                        stc.spinViewBetList[index], stc.selectedValue, context);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: (stc.timerStatus == 1 && stc.timerBetTime <= 5) ||
                            stc.timerStatus == 2
                        ? Colors.grey
                        : const Color(0xffd20003),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stc.spinViewBetList[index].toString(),
                        style:  TextStyle(
                          color: Colors.white,
                          fontSize: AppConstant.spinBetIdFont,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'roboto_bl'
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.05,
                        width: width * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                        child: Text(stc.spinBets
                                .where((e) =>
                                    e['game_id'] == stc.spinViewBetList[index])
                                .isNotEmpty
                            ? stc.spinBets
                                .where((e) =>
                                    e['game_id'] == stc.spinViewBetList[index])
                                .first["amount"]
                                .toString()
                            : '',
                          style:  TextStyle(
                            fontSize: AppConstant.spinBetAmFont,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
