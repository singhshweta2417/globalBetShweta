import 'package:flutter/foundation.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/deposit_history_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/history_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/withdraw_history_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/repo/history_repo.dart';

class HistoryViewModel with ChangeNotifier {
  final _historyRepo = HistoryRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  HistoryModel? _historyModel;
  HistoryModel? get historyModel => _historyModel;
  setHistoryData(HistoryModel value) {
    _historyModel = value;
    notifyListeners();
  }


  Future<void> historyApi(context) async {
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();

    final data = {
      "userid" : userId,
      "game_id" : "21"
    };
    setLoading(true);
    _historyRepo.historyApi(data).then((value) {
      if (value.status == true) {
        setHistoryData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error on HistoryAPI : $error');
      }
    });
  }


  bool _depositHisLoading = false;
  bool get depositHisLoading => _depositHisLoading;
  setDepositHisLoading(bool value) {
    _depositHisLoading = value;
    notifyListeners();
  }

  DepositHistoryModel? _depositHistoryModel;
  DepositHistoryModel? get depositHistoryModel => _depositHistoryModel;
  setDepositHistoryData(DepositHistoryModel value) {
    _depositHistoryModel = value;
    notifyListeners();
  }


  bool _withdrawHisLoading = false;
  bool get withdrawHisLoading => _withdrawHisLoading;
  setWithdrawHisLoading(bool value) {
    _withdrawHisLoading = value;
    notifyListeners();
  }

  WithdrawHistoryModel? _withdrawHisData;
  WithdrawHistoryModel? get withdrawHisData => _withdrawHisData;
  setWithdrawHistoryData(WithdrawHistoryModel value) {
    _withdrawHisData = value;
    notifyListeners();
  }

}