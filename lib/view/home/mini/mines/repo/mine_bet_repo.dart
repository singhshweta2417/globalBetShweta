import 'package:flutter/foundation.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/base_api_services.dart';
import 'package:globalbet/view/home/lottery/wingo/helper/network/network_api_services.dart';
import 'package:globalbet/view/home/mini/mines/res/mine_api_url.dart';

class MineBetRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> mineBetApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(MineApiUrl.mineBet, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during mineBetApi: $e');
      }
      rethrow;
    }
  }
}