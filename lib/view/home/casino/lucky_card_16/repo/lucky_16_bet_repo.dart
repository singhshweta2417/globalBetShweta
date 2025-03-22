import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';

import '../res/api_url.dart';


class Lucky16BetRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> lucky16BetApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.lucky16Bet, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during lucky16BetApi: $e');
      }
      rethrow;
    }
  }
}