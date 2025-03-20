import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/trx/res/trx_api_url.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';

class TrxBetRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> trxAddBet(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(TrxApiUrl.trxBet, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during trxAddBet: $e');
      }
      rethrow;
    }
  }
}