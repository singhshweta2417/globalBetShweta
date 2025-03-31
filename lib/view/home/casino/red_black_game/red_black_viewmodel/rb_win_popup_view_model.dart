import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_win_popup_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/seven_up_down_repo/jackpot_winpopup_repo.dart';
import 'package:provider/provider.dart';

import '../../../lottery/wingo/widgets/loss_pop_up.dart';
import '../../../lottery/wingo/widgets/win_pop_up.dart';

class RedBlackPopUpViewModel with ChangeNotifier {
  final _rBPopUpRepo = JackpotPopUpRepository();

  bool _loadingGameWin = false;
  bool get loadingGameWin => _loadingGameWin;
  setLoadingGameWin(bool value) {
    _loadingGameWin = value;
    notifyListeners();
  }

  JackpotWinPopupModel? _rBWinPopupModel;
  JackpotWinPopupModel? get rBWinPopupModel => _rBWinPopupModel;
  setWinAmountData(JackpotWinPopupModel value, context) {
    _rBWinPopupModel = value;
    notifyListeners();
  }

  Future<void> winAmountRb(context, dynamic period) async {
    setLoadingGameWin(true);
    UserViewModel userViewModal = UserViewModel();
    UserModel user = await userViewModal.getUser();
    String userId = user.id.toString();
    _rBPopUpRepo.winAmountJackpotApi(userId, period, 21).then((value) {
      if (value.status == 200) {
        setLoadingGameWin(false);
        setWinAmountData(value, context);
        if (value.win != 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return WinPopUpPage(
                winNumber: value.number!,
                winAmount: value.win.toString(),
                gameSrNo: value.gamesNo!,
                gameId: value.gameid!,
                result: value.result.toString(),
              );
            },
          );
          Provider.of<ProfileViewModel>(context, listen: false)
              .profileApi(context);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LossPopUpPage(
                winNumber: value.number!,
                winAmount: value.win.toString(),
                gameSrNo: value.gamesNo!,
                gameId: value.gameid!,
                result: value.result.toString(),
              );
            },
          );
          Provider.of<ProfileViewModel>(context, listen: false)
              .profileApi(context);
        }
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
