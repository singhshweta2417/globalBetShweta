import 'package:flutter/material.dart';
import 'package:globalbet/generated/assets.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/controller/controller.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/font_size.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/view/widget/coin_design.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Consumer<TitliController>(
      builder: (context, tc, child) {
        return Row(
          children: [
            Container(
              height: height * 0.15,
              width: width * 0.1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.titliTimerBg),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tc.timerStatus == 1
                        ? tc.timerBetTime.toString().padLeft(2, '0')
                        : '00',
                    style: TextStyle(
                        color: tc.timerStatus == 1
                            ? const Color(0xff02ff03)
                            : Colors.red,
                        fontSize: height * 0.07,
                        ),
                  ),
                  const TextConst(
                    title: "Second Left",
                    color: AppColors.green,
                    fontSize: 8,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            spaceWidth5,
            const CoinList(),
          ],
        );
      }
    );
  }
}
