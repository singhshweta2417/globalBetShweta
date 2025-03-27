import 'package:flutter/foundation.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/casino/7up_down_new/7_up_model/jackpot_game_history_model.dart';
import 'package:globalbet/view/home/casino/7up_down_new/seven_up_down_repo/jackpot_game_history_repo.dart';

class SevenUpDownGameHistoryViewModel with ChangeNotifier {
  final _sevenUpDownGameHistory = JackpotGameHistoryRepository();

  bool _loader = false;
  bool get loader => _loader;
  setLoader(bool value) {
    _loader = value;
    notifyListeners();
  }

  JackpotGameHistoryModel? _sevenUpDownGameHistoryModel;
  JackpotGameHistoryModel? get sevenUpDownGameHistoryModel => _sevenUpDownGameHistoryModel;
  setSevenUpDownGameHistoryApi(JackpotGameHistoryModel value) {
    _sevenUpDownGameHistoryModel = value;
    notifyListeners();
  }

  Future<void> sevenUpDownGameHistoryApi(context) async {
    setLoader(true);
    UserViewModel userViewModal = UserViewModel();
    UserModel user = await userViewModal.getUser();
    String userId = user.id.toString();
    _sevenUpDownGameHistory.jackpotGameHistoryApi(context, userId,22).then((value) {
      if (value.status == 200) {
        setLoader(false);
        setSevenUpDownGameHistoryApi(value);
      } else {
        setLoader(false);
      }
    }).onError((error, stackTrace) {
      setLoader(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
