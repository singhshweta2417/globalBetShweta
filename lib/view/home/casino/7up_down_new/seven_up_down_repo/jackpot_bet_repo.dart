import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/casino/7up_down_new/res/7_up_api.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';


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
      print(data);
      print("data seven bet wala");
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during jackpot Bet: $e');
      }
      rethrow;
    }
  }
}
