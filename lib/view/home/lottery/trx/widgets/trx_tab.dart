import 'package:flutter/material.dart';
import 'package:globalbet/view/home/lottery/trx/controller/trx_controller.dart';
import 'package:globalbet/view/home/lottery/trx/widgets/trx_chart.dart';
import 'package:globalbet/view/home/lottery/trx/widgets/trx_game_his.dart';
import 'package:globalbet/view/home/lottery/trx/widgets/trx_my_bet_his.dart';
import 'package:provider/provider.dart';

class TrxTab extends StatelessWidget {
  const TrxTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrxController>(builder: (context, trc, child) {
      if (trc.trxDataTab == 0) {
        return const TrxGameHis();
      } else if (trc.trxDataTab == 1) {
        return const TrxChart();
      } else {
        return const TrxMyBetHis();
      }
    });
  }
}