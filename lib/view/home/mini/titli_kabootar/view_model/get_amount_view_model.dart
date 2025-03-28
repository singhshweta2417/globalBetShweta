import 'package:flutter/foundation.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/model/get_amount_model.dart';
import 'package:game_on/view/home/mini/titli_kabootar/repo/get_amount_repo.dart';

class GetAmountViewModel with ChangeNotifier {
  final _getAmountRepo  = GetAmountRepo();

  GetAmountModel? _getAmountModel;
  GetAmountModel? get getAmountModel => _getAmountModel;

  setGetAmountData(GetAmountModel value) {
    _getAmountModel = value;
    notifyListeners();
  }

  Future<void> getAmountApi(context,String gameNo) async {
    // UserViewModel userViewModel = UserViewModel();
    // String? userId = await userViewModel.getUser();
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    final data = {
      "userid" : userId,
      "games_no" : gameNo
    };
    _getAmountRepo.getAmountApi(data).then((value) {
      if (value.status == true) {
        setGetAmountData(value);
        // Utils.flushBarSuccessMessage("value fetch", context, AppColors.white);
      } else {
        if (kDebugMode) {
          print('value: ${value.message}');
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

}

