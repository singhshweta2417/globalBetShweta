import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_result_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/res/seven_up_api.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';

class JackpotResultRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<JackpotResultModel> jackpotResultApi(
      context, dynamic limit, dynamic gameid) async {
    final data = {"game_id": gameid, "limit": limit};
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          ApiUrl7Up.lastResultJackpot, data);
      return JackpotResultModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during jackpot result api: $e');
      }
      rethrow;
    }
  }
}
