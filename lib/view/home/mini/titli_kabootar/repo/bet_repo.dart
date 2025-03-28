import 'package:flutter/foundation.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:game_on/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:game_on/view/home/mini/titli_kabootar/res/api_url.dart';

class BetRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> betApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(TitliKabootarApiUrl.betApi, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during betApi: $e');
      }
      rethrow;
    }
  }
}
