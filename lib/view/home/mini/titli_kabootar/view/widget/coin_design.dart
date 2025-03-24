import 'package:flutter/material.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/controller/controller.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_colors.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/text_const.dart';
import 'package:provider/provider.dart';

class CoinList extends StatelessWidget {
  const CoinList({super.key});

  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;
    final  width = MediaQuery.of(context).size.width;
    return Consumer<TitliController>(
      builder: (context, tc , child) {
        return Container(
          height: height * 0.15,
          width: width * 0.45,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(color: AppColors.golden),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: List.generate(tc.coinList.length, (index)
               => GestureDetector(
                  onTap: () {
                    tc.setResetOne(false);
                    tc.chipSelectIndex(index, tc.coinList[index].value);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.012),
                    child: CircleAvatar(
                      radius: tc.selectedIndex == index && tc.resetOne == false? 22 : 17,
                      backgroundImage: AssetImage(tc.coinList[index].image),
                      child: TextConst(
                        title:tc.coinList[index].value.toString(),
                        fontSize: 9,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
