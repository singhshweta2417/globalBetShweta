import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_win_popup_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/res/seven_up_api.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';


class JackpotPopUpRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<JackpotWinPopupModel> winAmountJackpotApi(dynamic userId,dynamic period,dynamic gameid) async {
    final data = {
      "userid": userId,
      "game_id": gameid,
      "game_no": period.toString()
    };
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl7Up.winPopupJackpot,data);
      print('Dekho ky huaaa ${ApiUrl7Up.winPopupJackpot}');
      print('Dekho mgr pyaar se ${data}');
      return JackpotWinPopupModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during winAmountJackpot Api: $e');
      }
      rethrow;
    }
  }
}
