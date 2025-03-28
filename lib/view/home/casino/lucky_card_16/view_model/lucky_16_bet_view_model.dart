import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_16/repo/lucky_16_bet_repo.dart';
import '../../../../../utils/utils.dart';

class Lucky16BetViewModel with ChangeNotifier {
  final _lucky16BetRepo = Lucky16BetRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  Future<void> lucky16BetApi(dynamic betList, context) async {
    setLoading(true);
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    // UserViewModel userViewModel = UserViewModel();
    // String? userId = await userViewModel.getUser();
    Map data = {"user_id": userId, "bets": betList};
    _lucky16BetRepo.lucky16BetApi(data).then((value) {
      if (value['success'] == true) {
        setLoading(false);
      } else {
        setLoading(false);
        Utils.flushBarSuccessMessage(
            value['message'].toString(), context,Colors.green);
        // Utils.show(value['message'].toString(), context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
