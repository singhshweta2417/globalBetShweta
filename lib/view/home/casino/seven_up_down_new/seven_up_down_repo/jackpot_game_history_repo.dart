import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_game_history_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/res/seven_up_api.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';

class JackpotGameHistoryRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<JackpotGameHistoryModel> jackpotGameHistoryApi(
      context, dynamic userid, dynamic gameid) async {
    final data = {"userid": userid, "game_id": gameid};
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiUrl7Up.gameHistoryJackpot, data);
      return JackpotGameHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during jackpot game history api: $e');
      }
      rethrow;
    }
  }
}
