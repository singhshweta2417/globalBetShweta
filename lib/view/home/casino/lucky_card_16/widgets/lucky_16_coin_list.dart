import 'package:flutter/material.dart';
import 'package:game_on/view/home/casino/lucky_card_16/controller/lucky_16_controller.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:provider/provider.dart';

class Lucky16CoinList extends StatelessWidget {
  const Lucky16CoinList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<Lucky16Controller>(builder: (context, l16c, child) {
      return  SizedBox(
            height: height * 0.12,
            width: width * 0.32,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: List.generate(
                l16c.coinList.length,
                    (index) => GestureDetector(
                  onTap: () {
                    l16c.selectIndex(
                        index,
                        l16c
                            .coinList[index].value);
                  },
                  child: Container(
                    height: height * 0.09,
                    width: height * 0.09,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color:
                          l16c.selectedIndex ==
                              index
                              ? Colors.yellow
                              : Colors
                              .transparent),
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
                              image: AssetImage(l16c
                                  .coinList[index]
                                  .image))),
                      child: Text(
                        l16c.coinList[index].value.toString(),
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
      }
    );
  }
}