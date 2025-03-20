import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/trx/model/trx_win_amount_model.dart';
import 'package:globalbet/view/home/lottery/trx/res/trx_api_url.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';

class TrxWinAmountRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<TrxWinAmountModel> trxWinAmountApi(
      dynamic userId, String gameId, dynamic period) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          "${TrxApiUrl.trxWinAmount}$userId&game_id=$gameId&games_no=$period");
      return TrxWinAmountModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during trxWinAmountApi: $e');
      }
      rethrow;
    }
  }
}