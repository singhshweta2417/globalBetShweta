import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/res/seven_up_api.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';


class JackpotBetRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> jackpotBet(dynamic userid,dynamic betList,dynamic gameid) async {
    final data = {
      "userid": userid,
      "game_id": gameid,
      "json": betList,
    };
    try {
      dynamic response = await _apiServices.getPostApiResponse(ApiUrl7Up.betPlacedJackpot, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during jackpot Bet: $e');
      }
      rethrow;
    }
  }
}
