import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/lottery/trx/model/trx_win_amount_model.dart';
import 'package:game_on/view/home/lottery/trx/repo/trx_win_amount_repo.dart';
import 'package:game_on/view/home/lottery/trx/widgets/trx_loss_pop_up.dart';
import 'package:game_on/view/home/lottery/trx/widgets/trx_win_pop_up.dart';
import 'package:provider/provider.dart';

class TrxWinAmountViewModel with ChangeNotifier {
  final _trxWinAmountRepo = TrxWinAmountRepository();

  bool _loadingGameWin = false;
  bool get loadingGameWin => _loadingGameWin;
  setLoadingGameWin(bool value) {
    _loadingGameWin = value;
    notifyListeners();
  }

  TrxWinAmountModel? _trxWinAmountData;
  TrxWinAmountModel? get trxWinAmountData => _trxWinAmountData;
  setWinAmountData(TrxWinAmountModel value, context) {
    _trxWinAmountData = value;
    notifyListeners();
  }

  Future<void> trxWinAmountApi(context, String gameId, dynamic period) async {
    setLoadingGameWin(true);
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    _trxWinAmountRepo.trxWinAmountApi(userId, gameId, period).then((value) {
      if (value.status == 200) {
        setLoadingGameWin(false);
        setWinAmountData(value, context);
        if (value.data!.win != 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TrxWinPopUp(
                winNumber: value.data!.number!,
                winAmount: value.data!.win.toString(),
                gameSrNo: value.data!.gamesNo!,
                gameId: value.data!.gameId!,
                result: value.data!.result.toString(),
              );
            },
          );
          Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);

        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TrxLossPopUp(
                winNumber: value.data!.number!,
                winAmount: value.data!.win!,
                gameSrNo: value.data!.gamesNo!,
                gameId: value.data!.gameId!,
                result: value.data!.result.toString(),
              );
            },
          );
        }
        Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);

      } else {
        if (kDebugMode) {
          print('Bet not place in this period no!');
        }
      }
    }).onError((error, stackTrace) {
      setLoadingGameWin(false);
      if (kDebugMode) {
        print('Error: $error');
      }
    });
  }
}