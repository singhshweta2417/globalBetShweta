import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/lottery/wingo/controller/win_go_controller.dart';
import 'package:globalbet/view/home/lottery/wingo/model/win_go_my_his_model.dart';
import 'package:globalbet/view/home/lottery/wingo/repo/win_go_my_his_repo.dart';
import 'package:provider/provider.dart';
import 'package:globalbet/utils/utils.dart';

class WinGoMyHisViewModel with ChangeNotifier {
  final _winGoMyHisRepo = WinGoMyHisRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  WinGoMyHisModel? _winGoMyHisModelData;
  WinGoMyHisModel? get winGoMyHisModelData => _winGoMyHisModelData;
  setBetHistoryData(WinGoMyHisModel value) {
    _winGoMyHisModelData = value;
    notifyListeners();
  }

  UserViewModel userProvider = UserViewModel();

  Future<void> myBetHisApi(context, int offset) async {
    setLoading(true);
    final wgc = Provider.of<WinGoController>(context, listen: false);
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    Map data = {
      "game_id": (wgc.gameIndex + 1).toString(),
      "userid": token,
      "limit": "10",
      "offset": offset
    };
    _winGoMyHisRepo.myBetHisApi(data).then((value) {
      if (value.status == 200) {
        setLoading(false);
        setBetHistoryData(value);
      } else {
        setLoading(false);
        Utils.flushBarSuccessMessage(
            value.message.toString(), context, Colors.green);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
