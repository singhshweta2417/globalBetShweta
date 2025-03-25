import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/mines/repo/mine_bet_repo.dart';
import 'package:provider/provider.dart';

class MineBetViewModel with ChangeNotifier {
  final _mineBetRepo = MineBetRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> mineBetApi(dynamic amount,context) async {
    final profileViewModel=Provider.of<ProfileViewModel>(context,listen: false);
    setLoading(true);
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();

    Map data = {
      "game_id":"12",
      "userid":userId,
      "amount":amount
    };
    _mineBetRepo.mineBetApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Utils.flushBarSuccessMessage(value['message'].toString(), context,Colors.green);
        profileViewModel.profileApi(context);
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(
          value['message'].toString(), context,Colors.red);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}