import 'package:flutter/foundation.dart';
import 'package:game_on/res/aap_colors.dart';
import 'package:game_on/view/home/lottery/wingo/model/win_go_result_model.dart';
import 'package:game_on/view/home/lottery/wingo/repo/win_go_result_repo.dart';
import 'package:game_on/view/home/lottery/wingo/view_model/win_go_pop_up_view_model.dart';
import 'package:provider/provider.dart';
import 'package:game_on/utils/utils.dart';

class WinGoResultViewModel with ChangeNotifier {
  final _winGoResultRepo = WinGoResultRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  WinGoResultModel? _wingoResultModelData;
  WinGoResultModel? get wingoResultModelData => _wingoResultModelData;
  setWingoResultData(WinGoResultModel value) {
    _wingoResultModelData = value;
    notifyListeners();
  }

  int? _gameSrNo;
  int? get gameSrNo => _gameSrNo;
  void setPeriodNo(int gameSrNo) {
    _gameSrNo = gameSrNo;
    notifyListeners();
  }

  Future<void> wingoResultApi(context, int status, dynamic index) async {
    setLoading(true);
    final wga = Provider.of<WinGoPopUpViewModel>(context, listen: false);
    _winGoResultRepo
        .gameResultApi(context, (index + 1).toString())
        .then((value) {
      if (value.status == 200) {
        setPeriodNo(value.data!.first.gamesNo! + 1);
        setLoading(false);
        setWingoResultData(value);
        if (status == 1) {
          wga.winAmountApi(
              context, (index + 1).toString(), value.data!.first.gamesNo);
        }
      } else {
        setLoading(false);
        Utils.flushBarSuccessMessage(
            value.message.toString(), context, AppColors.green);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}