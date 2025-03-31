import 'package:flutter/foundation.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_game_history_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/seven_up_down_repo/jackpot_game_history_repo.dart';

class RedBlackGameHistoryViewModel with ChangeNotifier {
  final _redBlackGameHistory = JackpotGameHistoryRepository();

  bool _loader = false;
  bool get loader => _loader;
  setLoader(bool value) {
    _loader = value;
    notifyListeners();
  }

  JackpotGameHistoryModel? _redBlackGameHistoryModel;
  JackpotGameHistoryModel? get redBlackGameHistoryModel =>
      _redBlackGameHistoryModel;
  setRedBlackGameHistoryApi(JackpotGameHistoryModel value) {
    _redBlackGameHistoryModel = value;
    notifyListeners();
  }

  Future<void> redBlackGameHistoryApi(context) async {
    setLoader(true);
    UserViewModel userViewModal = UserViewModel();
    UserModel user = await userViewModal.getUser();
    String userId = user.id.toString();
    _redBlackGameHistory
        .jackpotGameHistoryApi(context, userId, 21)
        .then((value) {
      if (value.status == 200) {
        setLoader(false);
        setRedBlackGameHistoryApi(value);
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
