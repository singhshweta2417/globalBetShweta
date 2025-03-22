import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/components/circular_percent.dart';
import 'package:globalbet/view/home/casino/lucky_card_12/controller/lucky_12_controller.dart';
import 'package:provider/provider.dart';

class Lucky12Timer extends StatelessWidget {
  const Lucky12Timer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Lucky12Controller>(builder: (context, l12c, child) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: const Color(0xffe5ca3b)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: width*0.06,
              percent: l12c.timerStatus ==
                  1
                  ? (90 - l12c.timerBetTime) /
                  90
                  : 0,
              lineWidth: 50,
              linearGradient: const LinearGradient(colors: [
                Colors.red,
                Colors.redAccent,
                Colors.green,
                Colors.green,
                Colors.green,
                Colors.green,
              ],
                  stops: [0.0,0.2,0.4,0.6,0.8,1.0]
              ),
            ),
            Container(
                height: height * 0.15,
                width: height * 0.15,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff242424),
                ),
                child: Text(
                  l12c.timerStatus == 1
                      ? l12c.timerBetTime.toString().padLeft(2, '0')
                      : '00',
                  style: TextStyle(
                      color: l12c.timerStatus == 1
                          ? const Color(0xff02ff03)
                          : Colors.red,
                      fontSize: height * 0.09,
                      fontFamily: 'digital'),
                ))
          ],
        ),
      );
    });
  }
}
