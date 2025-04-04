import 'package:flutter/foundation.dart';
import 'package:game_on/model/user_model.dart';
import 'package:game_on/res/view_model/user_view_model.dart';
import 'package:game_on/view/home/rummy/spin_to_win/model/spin_history_model.dart';
import 'package:game_on/view/home/rummy/spin_to_win/repo/spin_history_repo.dart';

class SpinHistoryViewModel with ChangeNotifier {
  final _spinHistoryRepo = SpinHistoryRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  SpinHistoryModel? _spinHistoryModel;

  SpinHistoryModel? get spinHistoryModel => _spinHistoryModel;

  setListData(SpinHistoryModel value) {
    _spinHistoryModel = value;
    notifyListeners();
  }

  Future<void> spinHistoryApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    UserModel user = await userViewModel.getUser();
    String userId = user.id.toString();
    _spinHistoryRepo.spinHistoryApi(userId).then((value) {
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