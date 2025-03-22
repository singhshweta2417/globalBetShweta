import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/profile_view_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/utils/utils.dart';
import 'package:globalbet/view/home/mini/mines/controller/mine_controller.dart';
import 'package:globalbet/view/home/mini/mines/repo/mine_cash_out_repo.dart';
import 'package:provider/provider.dart';

class MineCashOutViewModel with ChangeNotifier {
  final _mineCashOutRepo = MineCashOutRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> mineCashOutApi(dynamic winAmount,dynamic multiplier,int status,context) async {
    final profileViewModel=Provider.of<ProfileViewModel>(context,listen: false);
    final mic=Provider.of<MineController>(context,listen: false);
    setLoading(true);
    // UserViewModel userViewModal = UserViewModel();
    // String? userId = await userViewModal.getUser();
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    Map data = {
      "userid":userId,
      "win_amount":winAmount,
      "multipler":multiplier,
      "status":status.toString()
    };
    _mineCashOutRepo.mineCashOutApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Utils.flushBarSuccessMessage(value['message'].toString(), context,Colors.green);
        profileViewModel.profileApi(context);
        if(status==1){
          mic.refreshGame();
        }
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