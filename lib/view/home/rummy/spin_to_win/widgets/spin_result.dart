import 'package:flutter/material.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/res/app_constant.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/controller/spin_controller.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/view_model/spin_result_view_model.dart';
import 'package:provider/provider.dart';

class SpinResult extends StatelessWidget {
  const SpinResult({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final spinResultViewModel = Provider.of<SpinResultViewModel>(context);
    return Consumer<SpinController>(builder: (context, stc, child) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: spinResultViewModel.spinResultList.length,
        itemBuilder: (context, index) {
          final number = spinResultViewModel.spinResultList[index];
          Color color = stc.getColorForNumber(int.parse(number.winNumber.toString()));
          final jackpot = stc.getJackpotForIndex(number.jackpot!);
          return Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.09,
                  width: width * 0.043,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: color,
                  ),
                  child: Text(
                    number.winNumber.toString(),
                    style:  TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white,
                      fontFamily: 'roboto_bl',
                      fontSize: AppConstant.spinResFont
                    ),
                  ),
                ),
              ),
              if(jackpot!=null)
                Positioned(
                    bottom: -10,
                    child: _buildJackpotImage(jackpot))
            ],
          );
        },
      );
    });
  }
  Widget _buildJackpotImage(String assetPath) {
    return Container(
      height: 18,
      width: 25,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.fill),
      ),
    );
  }
}
