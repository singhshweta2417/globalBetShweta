import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/profile_provider.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
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
    final profileViewModel=Provider.of<ProfileProvider>(context,listen: false);
    setLoading(true);
    // UserViewModel userViewModal = UserViewModel();
    // String? userId = await userViewModal.getUser();
    UserViewProvider userProvider = UserViewProvider();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    print("🎉🎉🎉🎉");
    Map data = {
      "game_id":"12",
      "userid":userId,
      "amount":amount
    };
    _mineBetRepo.mineBetApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Utils.flushBarSuccessMessage(value['message'].toString(), context,Colors.green);
        profileViewModel.fetchProfileData();
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