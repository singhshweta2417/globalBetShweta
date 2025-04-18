import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/utils/utils.dart';
import 'package:game_on/view/home/lottery/trx/controller/trx_controller.dart';
import 'package:game_on/view/home/lottery/trx/model/trx_my_bet_his_model.dart';
import 'package:game_on/view/home/lottery/trx/repo/trx_my_bet_his_repo.dart';
import 'package:provider/provider.dart';

class TrxMyBetHisViewModel with ChangeNotifier {
  final _trxMyBetHisRepo = TrxMyBetHisRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  TrxMyBetHisModel? _trxMyBetHisModelData;
  TrxMyBetHisModel? get trxMyBetHisModelData => _trxMyBetHisModelData;
  setMyBetHisData(TrxMyBetHisModel value) {
    _trxMyBetHisModelData = value;
    notifyListeners();
  }

  Future<void> trxMyBetHisApi(context, int offset) async {
    setLoading(true);
    final trc = Provider.of<TrxController>(context, listen: false);
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    Map data = {
      "game_id": trc.trxTimerList[trc.gameIndex].gameId.toString(),
      "userid": userId,
      "limit": "10",
      "offset": offset
    };
    _trxMyBetHisRepo.trxMyBetHisApi(data).then((value) {
      if (value.status == 200) {
        setLoading(false);
        setMyBetHisData(value);
      } else {
        setLoading(false);
        Utils.flushBarSuccessMessage(
          value.message.toString(),
          context,Colors.red
        );
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
