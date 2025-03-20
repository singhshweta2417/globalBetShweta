import 'package:flutter/foundation.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
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
    UserViewProvider userProvider = UserViewProvider();
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


  Future<void> depositHistoryApi(context) async {
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    final data = {
      "user_id" : userId,
    };

    setLoading(true);
    _historyRepo.depositHistoryApi(data).then((value) {
      if (value.status == true) {
        setDepositHistoryData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error on depositHistoryApi : $error');
      }
    });
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


  Future<void> withdrawHistoryApi(context) async {
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    final data = {
      "user_id" : userId,
      "type" : 1
    };
    if (kDebugMode) {
      print("History Data");
      print({
        "user_id" : userId,
      });
    }
    setLoading(true);
    _historyRepo.withdrawHistoryApi(data).then((value) {
      if (value.status == true) {
        setWithdrawHistoryData(value);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error on depositHistoryApi : $error');
      }
    });
  }

}