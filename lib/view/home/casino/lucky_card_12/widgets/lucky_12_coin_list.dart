import 'package:flutter/material.dart';
import 'package:game_on/view/home/casino/lucky_card_12/controller/lucky_12_controller.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:provider/provider.dart';

class Lucky12CoinList extends StatelessWidget {
  const Lucky12CoinList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<Lucky12Controller>(builder: (context, l12c, child) {
      return SizedBox(
          height: height * 0.12,
          width: width * 0.32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              l12c.coinList.length,
              (index) => GestureDetector(
                onTap: () {
                  l12c.setResetOne(false);
                  l12c.chipSelectIndex(index, l12c.coinList[index].value);
                },
                child: Container(
                  height: height * 0.09,
                  width: height * 0.09,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.5,
                        color: l12c.selectedIndex == index &&
                                l12c.resetOne == false
                            ? Colors.yellow
                            : Colors.transparent),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: height * 0.09,
                    width: height * 0.09,
                    padding: const EdgeInsets.only(top: 2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(l12c.coinList[index].image),
                          fit: BoxFit.fill
                        ),
                    ),
                    child: Text(
                      l12c.coinList[index].value.toString(),
                      style:  TextStyle(
                        fontSize: AppConstant.luckyCoinFont,
                        fontFamily: 'dangrek',
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
