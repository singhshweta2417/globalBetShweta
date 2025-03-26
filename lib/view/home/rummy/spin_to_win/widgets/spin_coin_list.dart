import 'package:flutter/material.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:provider/provider.dart';
import '../controller/spin_controller.dart';

class SpinCoinList extends StatefulWidget {
  const SpinCoinList({super.key});

  @override
  State<SpinCoinList> createState() => _SpinCoinListState();
}

class _SpinCoinListState extends State<SpinCoinList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<SpinController>(builder: (context, stc, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(stc.coinSpinList.length, (i) {
          return GestureDetector(
            onTap: () {
              stc.selectIndex(i, stc.coinSpinList[i].value);
            },
            child: Container(
              height: height * 0.16,
              width: width * 0.09,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: stc.selectedIndex == i
                      ? const Color(0xff3df821)
                      : Colors.transparent),
              child: Container(
                height: height * 0.15,
                width: width * 0.08,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        stc.coinSpinList[i].image,
                      ),
                      fit: BoxFit.fill,
                    )),
                child: Text(
                  stc.coinSpinList[i].value.toString(),
                  style:  TextStyle(
                      fontSize: AppConstant.spinCoinFont,
                      fontFamily: 'roboto_slab_bl',
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          );
        }),
      );
    });
  }
}
