import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/mines/model/mine_bet_his_model.dart';
import 'package:globalbet/view/home/mini/mines/repo/mine_bet_his_repo.dart';

class MineBetHisViewModel with ChangeNotifier {
  final _mineBetHisRepo = MineBetHisRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  MineBetHisModel? _mineBetHisModelData;
  MineBetHisModel? get mineBetHisModelData => _mineBetHisModelData;
  setBetHistoryData(MineBetHisModel value) {
    _mineBetHisModelData = value;
    notifyListeners();
  }

  Future<void> mineBetHisApi(context, int offset) async {
    setLoading(true);
    // UserViewModel userViewModal = UserViewModel();
    // String? userId = await userViewModal.getUser();
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    _mineBetHisRepo.mineBetHisApi(userId).then((value) {
      if (value.status == 200) {
        setLoading(false);
        setBetHistoryData(value);
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
