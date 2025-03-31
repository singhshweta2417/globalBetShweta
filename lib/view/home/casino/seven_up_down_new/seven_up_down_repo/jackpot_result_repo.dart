import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/7_up_model/jackpot_result_model.dart';
import 'package:game_on/view/home/casino/seven_up_down_new/res/seven_up_api.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';

class JackpotResultRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<JackpotResultModel> jackpotResultApi(
      context, dynamic limit, dynamic gameid) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${ApiUrl7Up.lastResultJackpot}$gameid&limit=$limit');
      return JackpotResultModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during ho gy result api: $e');
      }
      rethrow;
    }
  }
}
