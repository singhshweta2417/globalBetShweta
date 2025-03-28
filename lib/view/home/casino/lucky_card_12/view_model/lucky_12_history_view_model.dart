import 'package:flutter/foundation.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_12/model/lucky_12_history_model.dart';
import 'package:game_on/view/home/casino/lucky_card_12/repo/lucky_12_history_repo.dart';




class Lucky12HistoryViewModel with ChangeNotifier {
  final _lucky12HistoryRepo = Lucky12HistoryRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Lucky12HistoryModel? _lucky12HistoryModel;

  Lucky12HistoryModel? get lucky12HistoryModel => _lucky12HistoryModel;

  setListData(Lucky12HistoryModel value) {
    _lucky12HistoryModel = value;
    notifyListeners();
  }

  Future<void> lucky12HistoryApi(context) async {
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    // UserViewModel userViewModel = UserViewModel();
    // String? userId = await userViewModel.getUser();
    _lucky12HistoryRepo.lucky12HistoryApi(userId).then((value) {
      if (value.success == true) {
        setListData(value);
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