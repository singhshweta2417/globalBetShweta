import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/casino/triple_chance/repo/triple_chance_bet_repo.dart';

import '../../../../../utils/utils.dart';


class TripleChanceBetViewModel with ChangeNotifier {
  final _tripleChanceBetRepo = TripleChanceBetRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  Future<void> tripleChanceBetApi(dynamic betList, context) async {
    setLoading(true);
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    // UserViewModel userViewModel = UserViewModel();
    // String? userId = await userViewModel.getUser();
    Map data = {"user_id": userId, "bets": betList};
    _tripleChanceBetRepo.tripleChanceBetApi(data).then((value) {
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


