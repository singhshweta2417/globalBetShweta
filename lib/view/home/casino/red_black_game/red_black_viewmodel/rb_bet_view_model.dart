import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/profile_view_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/seven_up_down_repo/jackpot_bet_repo.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/utils.dart';

class RedBlackBetViewModel with ChangeNotifier {
  final _redBlackBetRepo = JackpotBetRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> redBlackBet(context, String heart, String club, String spade,
      String diamond, String red, String black, String joker) async {
    setLoading(true);
    UserViewModel userViewModal = UserViewModel();
    UserModel user = await userViewModal.getUser();
    String userId = user.id.toString();
    final betList = [
      {'number': '1', 'amount': heart.toString()},
      {'number': '2', 'amount': club.toString()},
      {'number': '3', 'amount': spade.toString()},
      {'number': '4', 'amount': diamond.toString()},
      {'number': '5', 'amount': red.toString()},
      {'number': '6', 'amount': black.toString()},
      {'number': '7', 'amount': joker.toString()}
    ];
    _redBlackBetRepo.jackpotBet(userId, betList, 21).then((value) {
      if (value['status'] == 200) {
        print(betList);
        print("betList red black wali");
        setLoading(false);
        Provider.of<ProfileViewModel>(context, listen: false)
            .profileApi(context);
        Utils.flushBarSuccessMessage(
            value['message'].toString(), context, Colors.green);
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(
            value['message'].toString(), context, Colors.black);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
