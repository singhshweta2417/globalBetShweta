import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/controller/spin_controller.dart';
import 'package:globalbet/view/home/rummy/spin_to_win/repo/spin_bet_repo.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/utils.dart';

class SpinBetViewModel with ChangeNotifier {
  final _spinBetRepo = SpinBetRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  Future<void> spinBetApi(dynamic betList, context) async {
    final scc=Provider.of<SpinController>(context,listen: false);
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    UserModel user = await userViewModel.getUser();
    String userId = user.id.toString();
    Map data = {"user_id": userId, "bets": betList};
    _spinBetRepo.spinBetApi(data).then((value) {
      if (value['success'] == true) {
        scc.repeatBets.clear();
        scc.repeatBets.addAll(betList);
        setLoading(false);
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(value['message'].toString(), context,Colors.red);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
