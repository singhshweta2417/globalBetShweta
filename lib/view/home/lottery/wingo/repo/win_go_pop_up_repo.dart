import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/model/win_amount_model.dart';
import 'package:game_on/view/home/lottery/wingo/res/win_go_api_url.dart';


class WinGoPopUpRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<WinAmountModel> winAmountApi(
      dynamic userId, String gameId, dynamic period) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${WinGoApiUrl.wingoWinAmount}$userId&game_id=$gameId&games_no=$period");
      return WinAmountModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during winAmountApi: $e');
      }
      rethrow;
    }
  }
}
