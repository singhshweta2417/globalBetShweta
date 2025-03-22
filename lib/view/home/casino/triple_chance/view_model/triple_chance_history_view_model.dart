import 'package:flutter/foundation.dart';
import 'package:globalbet/model/user_model.dart';
import 'package:globalbet/res/view_model/user_view_model.dart';
import 'package:globalbet/view/home/casino/triple_chance/repo/triple_chance_history_repo.dart';
import '../model/triple_chance_history_model.dart';



class TripleChanceHistoryViewModel with ChangeNotifier {
  final _tripleChanceHistoryRepo = TripleChanceHistoryRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  TripleChanceHistoryModel? _tripleChanceHistoryModel;

  TripleChanceHistoryModel? get lucky12HistoryModel => _tripleChanceHistoryModel;

  setListData(TripleChanceHistoryModel value) {
    _tripleChanceHistoryModel = value;
    notifyListeners();
  }

  Future<void> lucky12HistoryApi(context) async {
    UserViewModel userProvider = UserViewModel();
    UserModel user = await userProvider.getUser();
    String userId = user.id.toString();
    // UserViewModel userViewModel = UserViewModel();
    // String? userId = await userViewModel.getUser();
    _tripleChanceHistoryRepo.tripleChanceHistoryApi(userId).then((value) {
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