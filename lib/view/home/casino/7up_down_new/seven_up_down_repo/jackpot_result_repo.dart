import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/casino/7up_down_new/7_up_model/jackpot_result_model.dart';
import 'package:globalbet/view/home/casino/7up_down_new/res/7_up_api.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';

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
