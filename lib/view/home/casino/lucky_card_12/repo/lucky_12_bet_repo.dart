import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';

import '../res/api_url.dart';

class Lucky12BetRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> lucky12BetApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(Lucky12ApiUrl.lucky12Bet, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during lucky12BetApi: $e');
      }
      rethrow;
    }
  }
}
