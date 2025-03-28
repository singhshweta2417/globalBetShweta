import 'package:flutter/foundation.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/casino/lucky_card_16/model/lucky_16_history_model.dart';
import 'package:game_on/view/home/casino/lucky_card_16/repo/lucky_16_history_repo.dart';

class Lucky16HistoryViewModel with ChangeNotifier {
  final _lucky16HistoryRepo = Lucky16HistoryRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Lucky16HistoryModel? _lucky16HistoryModel;

  Lucky16HistoryModel? get lucky16HistoryModel => _lucky16HistoryModel;

  setListData(Lucky16HistoryModel value) {
    _lucky16HistoryModel = value;
    notifyListeners();
  }

  Future<void> lucky16HistoryApi(context) async {
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    // UserViewModel userViewModel = UserViewModel();
    // String? userId = await userViewModel.getUser();
    _lucky16HistoryRepo.lucky16HistoryApi(userId).then((value) {
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
