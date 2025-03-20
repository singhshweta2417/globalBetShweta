import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/profile_provider.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/lottery/trx/controller/trx_controller.dart';
import 'package:globalbet/view/home/lottery/trx/repo/trx_bet_repo.dart';
import 'package:provider/provider.dart';

class TrxBetViewModel with ChangeNotifier {
  final _trxBetRepo = TrxBetRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> trxAddBet(
      dynamic number, dynamic amount, int gameId, context) async {
    final trc = Provider.of<TrxController>(context, listen: false);
    if (gameId == 6) {
      if (!trc.isPlayAllowed(trc.oneMinuteTime, trc.oneMinuteStatus, context)) return;
    } else if (gameId == 7) {
      if (!trc.isPlayAllowed(
          trc.threeMinuteTime, trc.threeMinuteStatus, context)) return;
    } else if (gameId == 8) {
      if (!trc.isPlayAllowed(trc.fiveMinuteTime, trc.fiveMinuteStatus, context)) return;
    } else {
      if (!trc.isPlayAllowed(trc.tenMinuteTime, trc.tenMinuteStatus, context)) return;
    }
    setLoading(true);
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    Map data = {
      "userid": token,
      "game_id": gameId.toString(),
      "number": number,
      "amount": amount,
    };
    _trxBetRepo.trxAddBet(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Navigator.pop(context);
        Provider.of<ProfileProvider>(context, listen: false).fetchProfileData();
        Utils.flushBarSuccessMessage(
          value['message'].toString(), context,Colors.green);
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(
          value['message'].toString(), context,Colors.red);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}