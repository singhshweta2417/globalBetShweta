import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/casino/lucky_card_12/repo/lucky_12_bet_repo.dart';

import '../../../../../utils/utils.dart';


class Lucky12BetViewModel with ChangeNotifier {
  final _lucky12BetRepo = Lucky12BetRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  Future<void> lucky12BetApi(dynamic betList, context) async {
    setLoading(true);
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    // UserViewModel userViewModel = UserViewModel();
    // String? userId = await userViewModel.getUser();
    Map data = {"user_id": userId, "bets": betList};
    _lucky12BetRepo.lucky12BetApi(data).then((value) {
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
