import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_result_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/seven_up_down_repo/jackpot_result_repo.dart';

class RedBlackResultViewModel with ChangeNotifier {
  final _rBResult = JackpotResultRepository();

  bool _loader = false;
  bool get loader => _loader;
  setLoader(bool value) {
    _loader = value;
    notifyListeners();
  }

  JackpotResultModel? _sevenResultModel;
  JackpotResultModel? get sevenResultModel => _sevenResultModel;
  setRbResultApi(JackpotResultModel value) {
    _sevenResultModel = value;
    notifyListeners();
  }

  Future<void> rBResultApi(context, dynamic limit) async {
    setLoader(true);
    _rBResult.jackpotResultApi(context, limit, 16).then((value) {
      if (value.status == 200) {
        setLoader(false);
        setRbResultApi(value);
      } else {
        setLoader(false);
      }
    }).onError((error, stackTrace) {
      setLoader(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
