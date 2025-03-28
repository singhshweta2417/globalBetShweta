import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/seven_up_down_repo/jackpot_bet_repo.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/utils.dart';

class SevenUpDownViewModel with ChangeNotifier {
  final _sevenUpDownBetRepo = JackpotBetRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> sevenUpDownBet(
      context, String redCount, String blueCount, String greenCount) async {
    setLoading(true);
    UserViewModel userViewModal = UserViewModel();
    UserModel user = await userViewModal.getUser();
    String userId = user.id.toString();
    final betList = [
      {'number': '1', 'amount': redCount.toString()},
      {'number': '2', 'amount': blueCount.toString()},
      {'number': '3', 'amount': greenCount.toString()}
    ];
    _sevenUpDownBetRepo.jackpotBet(userId, betList, 22).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Provider.of<ProfileViewModel>(context, listen: false)
            .profileApi(context);
        Utils.flushBarSuccessMessage(
            value['message'].toString(), context, Colors.green);
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(
            value['message'].toString(), context, Colors.red);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
