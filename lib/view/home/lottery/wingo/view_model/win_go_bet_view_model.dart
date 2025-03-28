import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/lottery/wingo/controller/win_go_controller.dart';
import 'package:game_on/view/home/lottery/wingo/repo/win_go_bet_repo.dart';
import 'package:provider/provider.dart';
import 'package:game_on/utils/utils.dart';


class WinGoBetViewModel with ChangeNotifier {
  final _winGoBetRepo = WinGoBetRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  UserViewModel userProvider = UserViewModel();

  Future<void> wingoBet(
      dynamic number, dynamic amount, int gameId, context) async {
    final wgc = Provider.of<WinGoController>(context, listen: false);
    if (gameId == 1) {
      if (!wgc.isPlayAllowed(wgc.oneMinuteTime, wgc.oneMinuteStatus, context)) return;
    } else if (gameId == 2) {
      if (!wgc.isPlayAllowed(
          wgc.threeMinuteTime, wgc.threeMinuteStatus, context)) return;
    } else if (gameId == 3) {
      if (!wgc.isPlayAllowed(wgc.fiveMinuteTime, wgc.fiveMinuteStatus, context)) return;
    } else {
      if (!wgc.isPlayAllowed(wgc.tenMinuteTime, wgc.tenMinuteStatus, context)) return;
    }
    setLoading(true);
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    Map data = {
      "userid": token,
      "game_id": gameId.toString(),
      "number": number,
      "amount": amount,
    };
    _winGoBetRepo.wingoBet(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Navigator.pop(context);
        Utils.flushBarSuccessMessage(
            value['message'].toString(), context, Colors.green);
        wgc.clear();
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(
            value['message'].toString(), context, Colors.red );
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
