import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/model/win_amount_model.dart';
import 'package:game_on/view/home/lottery/wingo/repo/win_go_pop_up_repo.dart';
import 'package:game_on/view/home/lottery/wingo/widgets/loss_pop_up.dart';
import 'package:game_on/view/home/lottery/wingo/widgets/win_pop_up.dart';

class WinGoPopUpViewModel with ChangeNotifier {
  final _winGoPopUpRepo = WinGoPopUpRepository();

  bool _loadingGameWin = false;
  bool get loadingGameWin => _loadingGameWin;
  setLoadingGameWin(bool value) {
    _loadingGameWin = value;
    notifyListeners();
  }

  WinAmountModel? _winAmountData;
  WinAmountModel? get winAmountData => _winAmountData;
  setWinAmountData(WinAmountModel value, context) {
    _winAmountData = value;
    notifyListeners();
  }

  UserViewModel userProvider = UserViewModel();

  Future<void> winAmountApi(context, String gameId, dynamic period) async {
    setLoadingGameWin(true);
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    _winGoPopUpRepo.winAmountApi(token, gameId, period).then((value) {
      if (value.status == 200) {
        setLoadingGameWin(false);
        setWinAmountData(value, context);
        if (value.data!.win != 0) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return WinPopUpPage(
                winNumber: value.data!.number!,
                winAmount: value.data!.win!.toString(),
                gameSrNo: value.data!.gamesNo!,
                gameId: value.data!.gameId!,
                result: value.data!.result.toString(),
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return LossPopUpPage(
                winNumber: value.data!.number!,
                winAmount: value.data!.win!.toString(),
                gameSrNo: value.data!.gamesNo!,
                gameId: value.data!.gameId!,
                result: value.data!.result.toString(),
              );
            },
          );
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
