import 'package:flutter/foundation.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/provider/user_view_provider.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/model/get_amount_model.dart';
import 'package:globalbet/view/home/mini/titli_kabootar/repo/get_amount_repo.dart';

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
    UserViewProvider userProvider = UserViewProvider();
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

