import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_result_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/seven_up_down_repo/jackpot_result_repo.dart';

class SevenUpDownResultViewModel with ChangeNotifier {
  final _sevenResult = JackpotResultRepository();

  bool _loader = false;
  bool get loader => _loader;
  setLoader(bool value) {
    _loader = value;
    notifyListeners();
  }

  JackpotResultModel? _sevenResultModel;
  JackpotResultModel? get sevenResultModel => _sevenResultModel;
  setSevenResultApi(JackpotResultModel value) {
    _sevenResultModel = value;
    notifyListeners();
  }

  Future<void> sevenResultApi(context, dynamic limit) async {
    setLoader(true);
    _sevenResult.jackpotResultApi(context, limit, 22).then((value) {
      if (value.status == 200) {
        setLoader(false);
        setSevenResultApi(value);
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
