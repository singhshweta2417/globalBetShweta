import 'package:flutter/material.dart';
import 'package:globalbet/main.dart';
import 'package:globalbet/res/aap_colors.dart';
import 'package:globalbet/view/home/lottery/trx/res/trx_text_widget.dart';
import 'package:globalbet/view/home/lottery/trx/view_model/trx_game_his_view_model.dart';
import 'package:provider/provider.dart';

import '../res/trx_colors.dart';

class TrxChart extends StatelessWidget {
  const TrxChart({super.key});

  @override
  Widget build(BuildContext context) {
    final trxGameHisViewModel = Provider.of<TrxGameHisViewModel>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: const BoxDecoration(
              gradient: TrxColors.loginSecondaryGrad,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: width * 0.3,
                child: const TrxTextWidget(
                    title: 'Period',
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: TrxColors.whiteColor),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const TrxTextWidget(
                      title: 'Number',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: TrxColors.whiteColor),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            trxGameHisViewModel.trxGameHisModelData!.data!.length,
            (index) {
              final res = trxGameHisViewModel.trxGameHisModelData!.data![index];
              return Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 30,
                width: width * 0.99,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TrxTextWidget(
                      title: '${res.gamesNo}',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: TrxColors.whiteColor,
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
                                gradient: res.number == index
                                    ? TrxColors.loginSecondaryGrad
                                    : TrxColors.loginSecondaryGrad),
                            child: TrxTextWidget(
                              title: index.toString(),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: res.number == index
                                  ? Colors.red
                                  : AppColors.green,
                            ),
                          ),
                        );
                      }),
                    ),
                    Container(
                      height: 15,
                      width: 15,
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.unSelectedColor),
                      child: TrxTextWidget(
                        title: (int.tryParse(res.number ?? '0') ?? 0) > 4 &&
                                (int.tryParse(res.number ?? '0') ?? 0) < 10
                            ? 'B'
                            : 'S',
                        color: TrxColors.whiteColor,
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
  }
}
